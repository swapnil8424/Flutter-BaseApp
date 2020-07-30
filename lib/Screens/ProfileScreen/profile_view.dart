import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login/Screens/Login/components/card_row.dart';
import 'package:firebase_login/Screens/ProfileScreen/profile_edit.dart';
import 'package:firebase_login/constraints.dart';
import 'package:flutter/material.dart';

class ProfileViewScreen extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const ProfileViewScreen({
    Key key,
    @required this.documentSnapshot,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String name = documentSnapshot['name'] ==  null ? " " : documentSnapshot['name'];
    String email = documentSnapshot['email'] ==  null ? " " : documentSnapshot['email'];
    String phoneNumber = documentSnapshot['phoneNumber'] == null ? " " : documentSnapshot['phoneNumber'];
    String age = documentSnapshot['age'] == null ? ' ' : documentSnapshot['age'];
    String address = documentSnapshot['address'] == null ? ' ' : documentSnapshot['address'];
    String image = documentSnapshot['image'] == null ? null : documentSnapshot['image'];
    String birthDate = documentSnapshot['birthDate'] == null ? ' ' : documentSnapshot['birthDate'];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 85,
                backgroundColor: Colors.amber,
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: kPrimaryColor,
                  backgroundImage: image == null ? AssetImage('assets/images/avatar.png') : NetworkImage(image),
                ),
              ),
              SizedBox(height: 10,),
              RaisedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen(documentSnapshot: documentSnapshot,)));
                },
                color: Colors.blue[700],
                icon: Icon(Icons.edit, color: Colors.white,),
                label: Text("Edit Profile", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'NAME',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(thickness: 2,),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  elevation: 8,
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'CONTACT DETAILS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Divider(thickness: 2,),
                        CardRow(phoneNumber, Icons.phone),
                        CardRow(email, Icons.email),
                        CardRow(address, Icons.location_on),
                      ],
                    ),
                  ),
                  elevation: 8,
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'PERSONAL DETAILS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Divider(thickness: 2,),
                        CardRow(birthDate, Icons.cake),
                        CardRow(age.toString(), Icons.person_outline),
                      ],
                    ),
                  ),
                  elevation: 8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


