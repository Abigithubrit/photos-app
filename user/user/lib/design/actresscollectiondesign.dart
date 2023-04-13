
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/fullscreen.dart';

import 'dart:math' as Math;

import 'package:user/model/actormodel.dart';







class ActressCollectionDesignWidget extends StatefulWidget {
  ActorModel model;
  BuildContext? context;

  ActressCollectionDesignWidget({required this.model, this.context});

  @override
  _ActressCollectionDesignWidgetState createState() => _ActressCollectionDesignWidgetState();
}

class _ActressCollectionDesignWidgetState extends State<ActressCollectionDesignWidget> {
  deleteMenu(String menuID) {
    FirebaseFirestore.instance
        .collection("actress")
       
 
        .doc(menuID)
        .delete();

    // Fluttertoast.showToast(msg: "Menu Deleted Successfully.");
  }




  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(widget.model.thumbnailUrl!),));            

      },
      splashColor: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[100],
              ),
              
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      widget.model.thumbnailUrl!,
                      height: MediaQuery.of(context).size.width*0.5-14,
                      
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                Positioned(
                  bottom: 2,
                  left: 5,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               
              SizedBox(width: 5,),
              
              ],),)
            ]),
           
              
             




              
            ],
          ),
        ),
      ),
    );
  }




}

