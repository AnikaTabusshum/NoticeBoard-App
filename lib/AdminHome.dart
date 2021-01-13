import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'UserHome.dart';
import 'package:firebase_core/firebase_core.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  File sampleImage;
  String myvalue;
  String url;
  final formKey = new GlobalKey<FormState>();
  Future getImage() async {
    var tempimg = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempimg;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      await Firebase.initializeApp();
      final Reference postImageRef =
          FirebaseStorage.instance.ref().child("Post images");
      var timekey = new DateTime.now();
      final UploadTask uploadTask =
          postImageRef.child(timekey.toString() + ".jpg").putFile(sampleImage);

      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      url = imageUrl.toString();
      print("Image Url = " + url);
      gotoUserHome();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formateTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formateTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "image": url,
      "description": myvalue,
      "date": date,
      "time": time,
    };

    ref.child("Posts").push().set(data);
  }

  void gotoUserHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload the Notice Image"),
        centerTitle: true,
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: sampleImage == null
            ? Image.asset('images/upload.jpg')
            : enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: new Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(
              sampleImage,
              height: 330.0,
              width: 660.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Description'),
              validator: (value) {
                return value.isEmpty ? 'Notice Description is reuired' : null;
              },
              onSaved: (value) {
                return myvalue = value;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              elevation: 10.0,
              child: Text("Add New Notice"),
              textColor: Colors.white,
              color: Colors.pink,
              onPressed: uploadStatusImage,
            ),
          ],
        ),
      ),
    );
  }
}
