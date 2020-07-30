import 'package:firebase_login/constraints.dart';
import 'package:firebase_login/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class UserProfile extends StatelessWidget {
  final User user;

  UserProfile(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 85,
                  backgroundColor: Colors.amber,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(user.image),
                  ),
                ),
//                Container(
//                  width: 160,
//                  height: 160,
//                  padding: EdgeInsets.all(2.0),    //border radius
//                  child: CircleAvatar(
//                    backgroundImage: NetworkImage(user.image),
//                  ),
//                  decoration: BoxDecoration(
//                    color: Colors.amber,       //border color
//                    shape: BoxShape.circle,
//                  ),
//                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'NAME',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'CONTACT DETAILS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                              fontSize: 16,
                            ),
                          ),
                          CardRow(user.phone, Icons.phone),
                          CardRow(user.email, Icons.email),
                          CardRow(user.address, Icons.location_on),
                        ],
                      ),
                    ),
                    elevation: 8,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'PERSONAL DETAILS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                              fontSize: 16,
                            ),
                          ),
                          CardRow(user.date, Icons.cake),
                          CardRow(user.age.toString(), Icons.person_outline),
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
      ),
    );
  }
}


class CardRow extends StatelessWidget {
  final String content;
  final IconData icon;

  CardRow(
      this.content,
      this.icon,
      );


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 32,),
          SizedBox(width: 12,),
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
