import 'package:date_format/date_format.dart';
import 'package:firebase_login/Screens/HomeScreen/ExplorePageTab/user_profile.dart';
import 'package:firebase_login/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Future _future;
  List<User> filteredList = [];
  List<User> dummyUserList = List<User>();
  List<String> userNames = [];
  List<User> users = [];
  TextEditingController editingController = new TextEditingController();
  String filter = "";

  Future<List<User>> getUsers() async {
    Response response = await get('https://randomuser.me/api/?seed=1&results=50&page=1');
    var data = json.decode(response.body);
    var usersJson = data['results'];

    for(var i=0; i<usersJson.length; i++) {
      Map currentUser = usersJson[i];
      Map name = currentUser['name'];
      String fullName = name['title'] + ' ' + name['first'] + ' ' + name['last'];
      Map location = currentUser['location'];
      Map street = location['street'];
      String streetName = street['number'].toString() + ' ' + street['name'];
      String address = streetName + location['city'] + ' ' + location['state'] + ' ' + location['country'] + ' ' + location['postcode'].toString();
      Map picture = currentUser['picture'];
      String image = picture['medium'];
      Map dob = currentUser['dob'];
      String date = dob['date'];
      DateTime birthDate = DateTime.parse(date);
      String dateOfBirth = formatDate(birthDate, [dd, '-', mm, '-', yyyy]);
      int age = dob['age'];

      User user = User(fullName, currentUser['email'], currentUser['phone'], dateOfBirth, age, image, address);

      users.add(user);
      userNames.add(fullName.toLowerCase());
      dummyUserList.add(user);
    }
    return users;
  }


  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      List<User> filteredList = List<User>();

      for(var i=0; i < userNames.length; i++) {
        if(userNames[i].contains(query)) {
          filteredList.add(dummyUserList[i]);
        }
      }
//      userNames.forEach((item) {
//        if(item.contains(query)) {
//          filteredList.add(item);
//        }
//      });
      setState(() {
        users.clear();
        users.addAll(filteredList);
        print(filteredList);
      });
      return;
    } else {
      setState(() {
        users.clear();
        users.addAll(dummyUserList);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _future = getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            onChanged: (value) {
              print("Value" + value);
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              )
            ),
          ),
        ),
        FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null) {
              return Container(
                child: Center(
                  child: SpinKitCircle(
                    color: Colors.lightBlue,
                    size: 50,
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(users[index].image),
                          ),
                          title: Text(users[index].name),
                          subtitle: Text(users[index].email),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UserProfile(users[index]);
                                  }
                                )
                            );
                          },
                        ),
                        Divider(
                          thickness: 1.2,
                          indent: 10,
                          endIndent: 10,
                        )
                      ],
                    );
                  }
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
