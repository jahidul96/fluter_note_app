// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleNotes extends StatelessWidget {
  Function()? onTap;
  QueryDocumentSnapshot doc;

  SingleNotes(this.onTap, this.doc, {super.key});

  List<Color> itemBg = [
    Colors.yellow,
    Colors.yellow.shade100,
    Colors.yellow.shade300,
    Colors.green.shade300,
    Colors.blue.shade300,
    Colors.yellow.shade50,
    Colors.orange,
    Colors.orange.shade300,
    Colors.red.shade300,
    Colors.pink.shade300,
    Colors.blue.shade500,
  ];

  final random_number = Random().nextInt(10);

  @override
  Widget build(BuildContext context) {
    DateTime noteTime = doc['createdAt'].toDate();
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: itemBg[random_number],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc["title"],
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
              SizedBox(height: 10),
              Text(
                doc["description"],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
