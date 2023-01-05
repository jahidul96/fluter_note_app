import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoteDetails extends StatefulWidget {
  QueryDocumentSnapshot doc;
  NoteDetails(this.doc, {super.key});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  final db = FirebaseFirestore.instance;
  final titleController = TextEditingController();
  final decriptionController = TextEditingController();

  // editNotes
  editNotes() {
    Map<String, dynamic> editedNote = {
      "title": titleController.text,
      "description": decriptionController.text,
      "createdAt": DateTime.now(),
    };

    db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("mynotes")
        .doc(widget.doc.id)
        .update(editedNote)
        .then((value) {
      print("Notes updated");
      Get.snackbar(
        "Note app",
        "Your Noted updated",
        backgroundColor: Colors.white,
      );
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  // popupDialogBox

  popupDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            width: 300,
            height: 300,
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
                      onPressed: editNotes,
                      child: Text(
                        "Edit Note",
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime noteTime = widget.doc['createdAt'].toDate();
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("mynotes")
                  .doc(widget.doc.id)
                  .delete()
                  .then((value) {
                Get.snackbar(
                  "Note App",
                  "Your Note Deleted!!",
                  backgroundColor: Colors.white,
                );
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["title"],
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              DateFormat.yMMMd().add_jm().format(noteTime),
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              widget.doc["description"],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: popupDialogBox,
        child: Icon(Icons.edit),
      ),
    );
  }
}
