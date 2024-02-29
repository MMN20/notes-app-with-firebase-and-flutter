import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils.dart';
import 'package:flutter_firebase/widgets/mybutton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class NoteDetailsPage extends StatefulWidget {
  const NoteDetailsPage(
      {super.key,
      required this.ref,
      required this.refreshView,
      required this.note});
  final DocumentReference<Map<String, dynamic>> ref;
  final String note;
  final void Function() refreshView;
  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  TextEditingController noteController = TextEditingController();

  void initData() async {}

  @override
  void initState() {
    noteController.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(20);
    return Scaffold(
      body: Padding(
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
                'update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (noteController.text != '') {
                  await widget.ref.update({
                    'note': noteController.text,
                  });
                }
                widget.refreshView();
                Navigator.pop(context);
              },
              color: mainButtonColorColor,
            ),
          ],
        ),
      ),
    );
  }
}
