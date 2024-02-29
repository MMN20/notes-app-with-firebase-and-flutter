import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.doc});
  final QueryDocumentSnapshot<Map<String, dynamic>> doc;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 94, 93, 91),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          backgroundImage: AssetImage('assets/note.png'),
        ),
        title: Text(
          doc['note'],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
