import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils.dart';
import 'package:flutter_firebase/widgets/mybutton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddFolderNotePage extends StatefulWidget {
  const AddFolderNotePage(
      {super.key,
      required this.collectionReference,
      required this.refreshView});
  final CollectionReference<Map<String, dynamic>> collectionReference;
  final void Function() refreshView;
  @override
  State<AddFolderNotePage> createState() => _AddFolderNotePageState();
}

class _AddFolderNotePageState extends State<AddFolderNotePage> {
  TextEditingController folderController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(20);
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Add a:'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Note',
              ),
              Tab(
                text: 'Folder',
              )
            ]),
          ),
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Colors.black),
                    cursorColor: mainButtonColorColor,
                    controller: noteController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: borderRadius,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                      ),
                      hintText: 'Enter note name',
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    child: Text(
                      'Add the note',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (noteController.text != '') {
                        await widget.collectionReference.add({
                          'id': FirebaseAuth.instance.currentUser!.uid,
                          'type': 'note',
                          'note': noteController.text,
                        });
                        widget.refreshView();
                        Navigator.pop(context);
                        print(
                            'note added =======================================');
                      }
                    },
                    color: mainButtonColorColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Colors.black),
                    cursorColor: mainButtonColorColor,
                    controller: folderController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: borderRadius,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                      ),
                      hintText: 'Enter folder name',
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    child: Text(
                      'Add the folder',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await widget.collectionReference.add({
                        'id': FirebaseAuth.instance.currentUser!.uid,
                        'type': 'folder',
                        'folder': folderController.text
                      });
                      widget.refreshView();
                      Navigator.pop(context);
                      print(
                          'folder added =======================================');
                    },
                    color: mainButtonColorColor,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
