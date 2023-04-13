
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user/pages/homepage.dart';
import 'package:user/widgets/next.dart';
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
         
          
          
          
        ],
      ),
    );
  }
}