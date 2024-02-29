import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/note_details_page.dart';
import 'package:flutter_firebase/utils.dart';
import 'package:flutter_firebase/pages/bottom_sheet_page.dart';
import 'package:flutter_firebase/widgets/folder.dart';
import 'package:flutter_firebase/widgets/note.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.collectionReference});
  final CollectionReference<Map<String, dynamic>> collectionReference;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
  void initData() async {
    QuerySnapshot<Map<String, dynamic>> query = await widget.collectionReference
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data = List.of(query.docs);
    setState(() {});
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainButtonColorColor,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (c) {
                return AddFolderNotePage(
                  collectionReference: widget.collectionReference,
                  refreshView: () {
                    initData();
                  },
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: mainButtonColorColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            if (data[index]['type'] == 'note') {
              return InkWell(
                  onLongPress: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.rightSlide,
                            title: '',
                            desc: 'Are you sure you want to delete this note?',
                            btnCancelText: 'No',
                            btnOkText: 'Yes',
                            btnOkOnPress: () async {
                              await widget.collectionReference
                                  .doc(data[index].id)
                                  .delete();
                              setState(() {
                                data.remove(data[index]);
                              });
                            },
                            btnCancelOnPress: () {})
                        .show();
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      ModalBottomSheetRoute(
                        builder: (c) => NoteDetailsPage(
                          note: data[index]['note'],
                          refreshView: () {
                            setState(() {
                              initData();
                            });
                          },
                          ref: data[index].reference,
                        ),
                        isScrollControlled: false,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.sizeOf(context).height * 0.70,
                        ),
                      ),
                    );
                  },

                  ///
                  child: Note(
                    doc: data[index],
                  ));
            } else {
              return InkWell(
                onLongPress: () async {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.rightSlide,
                          title: '',
                          desc:
                              'Are you sure you want to delete this folder and the descendent files with it?',
                          btnCancelText: 'No',
                          btnOkText: 'Yes',
                          btnOkOnPress: () async {
                            await widget.collectionReference
                                .doc(data[index].id)
                                .delete();
                            setState(() {
                              data.remove(data[index]);
                            });
                          },
                          btnCancelOnPress: () {})
                      .show();
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => HomePage(
                        collectionReference: widget.collectionReference
                            .doc(data[index].id)
                            .collection(data[index]['folder']),
                      ),
                    ),
                  );
                },
                child: Folder(
                  doc: data[index],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
