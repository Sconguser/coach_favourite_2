import 'package:flutter/material.dart';
import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:provider/provider.dart';


showAddManteeDialog(BuildContext context, String bearerToken, int idCoach, int idMentee, String name, String lastName, String email) {
  Widget dismissButton = ElevatedButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget confirmButton = ElevatedButton(
      onPressed:()async{
        await Provider.of<MenteeProvider>(context,listen:false).addMentee(bearerToken, idCoach, idMentee, name, lastName, email);
        Navigator.pop(context);
      },
      child: Text("Yee")
  );
  AlertDialog alert = AlertDialog(
    title: Text("Need confirmation"),
    content: Text("Are you sure you want to add this mantee as YOUR mantee?"),
    actions: [
      dismissButton,
      confirmButton
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}