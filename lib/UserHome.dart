import 'package:flutter/material.dart';
import 'Posts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<Posts> postsList = [];
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      postsList.clear();

      for (var individualKey in KEYS) {
        Posts posts = new Posts(
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
        );
        postsList.add(posts);
      }

      setState(() {
        print(postsList.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notice"),
        centerTitle: true,
      ),
      body: new Container(
        child: postsList.length == 0
            ? new Text("Loading.....")
            : new ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (_, index) {
                  return PostUI(
                      postsList[index].image,
                      postsList[index].description,
                      postsList[index].date,
                      postsList[index].time);
                }),
      ),
    );
  }

  Widget PostUI(String image, String description, String date, String time) {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Container(
        padding: new EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                new Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            new Image.network(image, fit: BoxFit.cover),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              description,
              style: Theme.of(context).textTheme.subhead,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
