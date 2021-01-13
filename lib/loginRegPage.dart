import 'package:flutter/material.dart';
import 'AdminHome.dart';

class LoginRegPage extends StatefulWidget {
  Thepage createState() => Thepage();
}

class Thepage extends State<LoginRegPage> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  String _email = "";
  String _password = "";
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notice Board"),
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(
          key: _formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        validator: (value) {
          return value.isEmpty ? 'Password is reuired.' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
        controller: myController,
      ),
      SizedBox(
        height: 10.0,
      ),
    ];
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('images/logo.jpg'),
      ),
    );
  }

  List<Widget> createButtons() {
    return [
      new RaisedButton(
        child: new Text("Login", style: new TextStyle(fontSize: 20.0)),
        textColor: Colors.white,
        color: Colors.pink,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            if (myController.text == "1234") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminHome()),
              );
            }
          }
        },
      ),
    ];
  }
}
