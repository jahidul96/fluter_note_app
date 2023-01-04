// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final db = FirebaseFirestore.instance;
  final titleController = TextEditingController();
  final decriptionController = TextEditingController();

  // addNote
  addNote() {
    Map<String, dynamic> note = {
      "title": titleController.text,
      "description": decriptionController.text,
    };

    db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("mynotes")
        .add(note)
        .then((value) => {
              print(value.id),
              Get.snackbar(
                "Note App",
                "Your note added!!",
                backgroundColor: Colors.white,
              ),
              Navigator.pop(context),
              titleController.clear(),
              decriptionController.clear(),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add A Note",
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: decriptionController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "description",
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: MaterialButton(
                  color: Colors.black,
                  onPressed: addNote,
                  child: Text(
                    "Add Note",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
