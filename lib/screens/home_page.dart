// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/components/single_notes.dart';
import 'package:notesapp/screens/add_note.dart';
import 'package:notesapp/screens/notes_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Notes"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),

      // main content
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("mynotes")
              .snapshots(),
          builder: (context, snapshot) {
            // loadding state content

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // data content
            if (snapshot.hasData) {
              // print('doc id');
              // print(snapshot.data!.docs[1].id);
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 100,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return SingleNotes(
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetails(snapshot.data!.docs[index]),
                            ));
                      },
                      snapshot.data!.docs[index],
                    );
                  }));
            }

            //  empty content
            return Center(
              child: Text(
                "No notes Till now",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),

      // floatingButton

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        label: Text("Add Notes"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
