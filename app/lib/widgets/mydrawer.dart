import 'package:app/pages/loginpage.dart';
import 'package:app/pages/screenpage.dart';
import 'package:app/widgets/next.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/a.jpg'),
              ),
              Text('abi.dsr123@gmail.com'),
              Text('Lalitpur-11,Nepal')
            ],
          )),
          GestureDetector(
            onTap: () {
              next(context, Screenpage());
            },
            child: ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
          ),
          GestureDetector(
            onTap: () {
             showDialog(context: context,
              builder: (context) => AlertDialog(
                title: Text('Wanna Logout'),
                actions: [
                  TextButton(onPressed: () {
                    FirebaseAuth.instance.signOut().then((value){
             Navigator.push(context, MaterialPageRoute(builder: (c)=>Loginpage()));
          });
                  }, child: Text('Yes')),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text('No')),
                ],
              ),);
            },
            child: ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.exit_to_app),
            ),
          ),
          
          
        ],
      ),
    );
  }
}