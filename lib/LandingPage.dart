import 'package:flutter/material.dart';
import 'loginRegPage.dart';
import 'UserHome.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Notice Board'),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Flexible(
            flex: 1,
            child: logo(),
          ),
          Flexible(
            flex: 3,
            child: board(),
          ),

          /*SizedBox(
            height: 20.0,
          ),*/
          Flexible(
            flex: 2,
            child: Container(
              child: FlatButton(
                child: Text(
                  'Upload a new Notice on the Board',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginRegPage()),
                  );
                },
              ),
            ),
          ),

          /*SizedBox(
            height: 20.0,
          ),*/
          Flexible(
            flex: 2,
            child: Container(
              child: FlatButton(
                child: Text(
                  'View NoticeBoard',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.lightBlue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserHome()),
                  );
                },
              ),
            ),
          ),
        ])));
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 70.0,
        child: Image.asset('images/logo.jpg'),
      ),
    );
  }

  Widget board() {
    return new Hero(
      tag: 'board',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 190.0,
        child: Image.asset('images/board.jpg'),
      ),
    );
  }
}
