import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/appstyle.dart';

class NoteReaderScreen extends StatefulWidget {
  // final DocumentReference ref;
  NoteReaderScreen(
    this.doc, {
    Key? key,
  }) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late String title;
  late String des;
  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    title = widget.doc["note_title"];
    des = widget.doc["note_content"];
    int color_id = widget.doc['color-id'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyle.cardsColor[color_id],
        appBar: AppBar(
          backgroundColor: AppStyle.cardsColor[color_id],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                        });
                      },
                      child: Icon(
                        Icons.edit_note,
                        size: 24.0,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        delete();
                      },
                      child: Icon(
                        Icons.delete_forever,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 8.0,
                        )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                // Text(
                //   widget.doc["note_title"],
                //   style: AppStyle.mainTitle,
                // ),
                // SizedBox(
                //   height: 12,
                // ),
                // Text(
                //   widget.doc["note_content"],
                //   style: AppStyle.mainContent,
                // ),
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Title",
                        ),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        initialValue: widget.doc['note_title'],
                        enabled: edit,
                        onChanged: (_val) {
                          title = _val;
                        },
                        validator: (_val) {
                          if (_val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Note Description",
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.grey,
                        ),
                        initialValue: widget.doc["note_content"],
                        enabled: edit,
                        onChanged: (_val) {
                          des = _val;
                        },
                        maxLines: 20,
                        validator: (_val) {
                          if (_val!.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppStyle.accentColor,
        //   onPressed: () async {
        //     FirebaseFirestore.instance.collection("Notes").add({
        //       "note_title": _titleController.text,
        //       "note_content": _mainController.text,
        //       "color-id": color_id,
        //     }).then((value) {
        //       print(value.id);
        //       Navigator.pop(context);
        //     }).catchError((error) => print("Failed $error"));
        //   },
        //   child: Icon(Icons.save),
        // ),
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.save_rounded,
                  color: Colors.white,
                ),
                backgroundColor: Colors.grey[700],
              )
            : null,
      ),
    );
  }

  void delete() async {
    // await widget.ref.delete();
    Navigator.pop(context);
  }
  // void save() async {
  //   if (key.currentState!.validate()) {
  //     await widget.ref.update({'note_title': title, 'note_content': des});
  //     Navigator.of(context).pop();
  //   }
  // }
}
