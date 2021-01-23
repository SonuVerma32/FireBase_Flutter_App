import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseflutter/fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(new Myapp());
}

class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firebase App",
      color: Colors.green,
      home: new Myhomepage(),
    );
  }
}

/*
class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpaperList;
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("wallpaper");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((snapshot) {
      setState(() {
        wallpaperList = snapshot.docs;
      });
    });
  }
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Wallpaper"),
        ),
        body: wallpaperList != null?
        new StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(8.0),
          crossAxisCount: 4,
          itemCount: wallpaperList.length,
          itemBuilder: (context,i){
            String imagePath = wallpaperList[i].get('url');
              print(imagePath);
            return new Material(
              elevation: 8.0,
              borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
              child: new InkWell(
                onTap: ()=>Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new fullScreenPath(imagePath)
                )),
                child: new Hero(
                  tag: imagePath,
                  child: new FadeInImage(
                    image: new NetworkImage(imagePath),
                    fit: BoxFit.cover,
                    placeholder: new AssetImage("lib/wallpaper/diploma.jpg"),
                  ),
                ),
              ),
            );
          },
          staggeredTileBuilder: (i) => new StaggeredTile.count(2, i.isEven?2:3),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ):
        new Center(
          child: new CircularProgressIndicator(),
        )
    );
  }
}
*/





class Myhomepage extends StatefulWidget {
  @override
  _MyhomepageState createState() => _MyhomepageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//final GoogleSignIn googleSignIn = GoogleSignIn();

class _MyhomepageState  extends State<Myhomepage> {

  _signin() async{
    await Firebase.initializeApp();
    // Sign in by user id and password
    UserCredential user = (await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: "Email",
      password: "password"));
    print(user);
 //Sign in for current user
    var googleAuth;
    final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential googleUserCredential = await firebaseAuth.signInWithCredential(googleCredential);


  }
  Map dataa = null;
  _adddata()async{
    await Firebase.initializeApp();
    Map<String,dynamic> demoData = {"Name":"Sonu","Desc":"Programmer"};
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("data");
    collectionReference.add(demoData);

  }
  _fetchdata(){
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("data");
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        dataa = snapshot.docs[0].data();
        print(dataa);
      });
    });
  }
  _deletedata()async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("data");
    QuerySnapshot querySnapshot = await collectionReference.get();
    try {
      querySnapshot.docs[0].reference.delete();
    } on Exception catch (e) {

      print(e);
    }
    dataa = {};

  }
  _updatedata()async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("data");
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"Name":"Sonu",
      "Desc":"Inter Mediate Programmer"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Firebase Auth."),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              onPressed: _signin,
              child: new Text("Sign In"),
              color: Colors.teal,
            ),
            new Padding(padding: const EdgeInsets.all(10.0)),
            new RaisedButton(
              onPressed: _adddata,
              child: new Text("Add"),
              color: Colors.teal,
            ),
            new Padding(padding: const EdgeInsets.all(10.0)),
            new RaisedButton(
              onPressed: _fetchdata,
              child: new Text("Fetch"),
              color: Colors.teal,
            ),
            new Padding(padding: const EdgeInsets.all(10.0)),
            new RaisedButton(
              onPressed: _updatedata,
              child: new Text("Update"),
              color: Colors.teal,
            ),
            new Padding(padding: const EdgeInsets.all(10.0)),
            new RaisedButton(
              onPressed: _deletedata,
              child: new Text("Delete"),
              color: Colors.teal,
            ),
            new Padding(padding: const EdgeInsets.all(20.0)),
            new Text(dataa.toString()),
          ],
        ),
      ),
    );
  }
}
