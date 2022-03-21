import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xid/xid.dart';

class ActionList extends StatelessWidget {
  final String id;
  const ActionList({required this.id});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
    List<String> actionList = ["Like", "comment", "Share"];

    List<String> selectedActionList = [];

    void addListToDB() async {
      await _firestore
          .collection("Users")
          .doc(_auth.currentUser!.uid)
          .collection("PostData")
          .doc()
          .collection("ActionEntry")
          .add({"action": selectedActionList.toString()});
    }

    _showReportDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Actions to be Perform"),
              content: MultiSelectChip(
                actionList,
                onSelectionChanged: (selectedList) {
                  // setState(() {
                  //   selectedActionList = selectedList;
                  // });
                  selectedActionList = selectedList;
                },
              ),
              actions: <Widget>[
                FlatButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      addListToDB();
                      print("Added to db successfully");
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Which actions you want to perform?",
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Times new roman",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            RaisedButton(
                child: Text("Actions"),
                onPressed: () {
                  _showReportDialog();
                }),
            Text(selectedActionList.join(" , ")),
          ],
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> actionList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.actionList, {required this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> action_choices = [];

    widget.actionList.forEach((item) {
      action_choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return action_choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
