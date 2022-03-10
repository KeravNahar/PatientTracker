import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud/screens/login.dart';
import 'package:crud/screens/widgets/text_field.dart';
import 'package:provider/provider.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late UserCredential userCredential;
  RegExp regExp = RegExp("@.");
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Future sendData()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
      await FirebaseFirestore.instance.collection('userData').doc(userCredential.user!.uid).set({
        'email': email.text.trim(),
        'username': username.text.trim(),
        'userid': userCredential.user!.uid,
        'password' : password.text.trim(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        globalKey.currentState!.showSnackBar(SnackBar(content: Text("The password is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        globalKey.currentState!.showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
      }
    } catch (e) {
      globalKey.currentState!.showSnackBar(SnackBar(content: Text('error')
      )
      );
    }
  }

  void validation(){
    if(email.text.trim().isEmpty||email.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter a Email address"),
        ),
      );
      return;
    }
    else if(!regExp.hasMatch(email.text)){
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter valid Email address"),
        ),
      );
      return;
    }
    if(username.text.trim().isEmpty||username.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter a Username"),
        ),
      );
      return;
    }
    if(password.text.trim().isEmpty||password.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter a Password"),
        ),
      );
      return;
    }
    else{
      sendData();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Sign Up",style: TextStyle(color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            Column(
              children: [
                WidTextField(
                  hintText: "Enter Email Address",
                  obscureText: false,
                  controller: email ,
                ),
                SizedBox(height: 30,),
                WidTextField(
                  hintText: "Enter Username",
                  obscureText: false,
                  controller: username,
                ),
                SizedBox(height: 30,),
                WidTextField(
                  hintText: "Enter Password",
                  obscureText: true,
                  controller: password,
                ),
                SizedBox(height: 30,),

              ],
            ),
            Container(
              height: 60,
              width : 200,
              child :RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(30)
                ),
                onPressed: () {
                  validation();
                },
                child: Text("Register", style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have a Account?", style: TextStyle(color: Colors.grey),),
                Container(
                  height: 25,
                  width : 120,
                  child :FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("SignIn here.", style: TextStyle(color: Colors.blue),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}