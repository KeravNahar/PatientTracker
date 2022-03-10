import 'package:crud/screens/widgets/addData.dart';
import 'package:crud/screens/widgets/show_todo.dart';
import 'package:flutter/material.dart';

import 'login.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.blue,),
          onPressed:(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage())
            );
          },
        ),
        title: Text('Appointments'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            child: Column(
                children:[
                ListShow(),
                  SizedBox(height: 30,),
                Container(
                  height: 50,
                  width: 250,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPage())
                      );
                    },
                    child: Text("Add Appointment", style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                )
                ]
            )),
      ),
    );
  }
}
