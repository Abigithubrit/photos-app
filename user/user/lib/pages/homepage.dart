
import 'package:flutter/material.dart';
import 'package:user/pages/actor.dart';
import 'package:user/pages/actress.dart';
import 'package:user/pages/cartoons.dart';
import 'package:user/widgets/mydrawer.dart';
class Screenpage extends StatefulWidget {
  const Screenpage({super.key});

  @override
  State<Screenpage> createState() => _ScreenpageState();
}

class _ScreenpageState extends State<Screenpage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Scaffold(
        appBar: AppBar(
          title: Text('Actor and Actress Wallpaper',
          style: TextStyle(color: Colors.black,fontSize: 16),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(builder: (context) => IconButton(onPressed: () {
            Scaffold.of(context).openDrawer();
          },
           icon: Icon(Icons.menu,color: Colors.black,)),),
          bottom: TabBar(
            indicatorColor: Colors.red,
            tabs: [
            Tab(child: Text('Actor',style: TextStyle(color: Colors.black),),),
            Tab(child: Text('Actress',style: TextStyle(color: Colors.black),),),
            Tab(child: Text('Cartoons',style: TextStyle(color: Colors.black),),),
          ]),
        ),
        drawer: MyDrawer(),
        body: TabBarView(children: [
          Actor(),
          Actress(),
          Cartoons()
        ]),
      ));
  }
}
