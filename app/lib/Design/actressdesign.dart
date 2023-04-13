import 'package:app/model/actormodel.dart';
import 'package:app/tabbarview.dart/actorcollections.dart';
import 'package:app/tabbarview.dart/actresscollection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:math' as Math;







class ActressDesignWidget extends StatefulWidget {
  ActorModel model;
  BuildContext? context;

  ActressDesignWidget({required this.model, this.context});

  @override
  _ActressDesignWidgetState createState() => _ActressDesignWidgetState();
}

class _ActressDesignWidgetState extends State<ActressDesignWidget> {
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ActressScreen(model: widget.model)));
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
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
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
                Text(
                widget.model.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "Signatra",
                ),
              ),
              SizedBox(width: 5,),
               GestureDetector(
                    onTap: (){
                       showDialog(context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Are you Sure Delete?'),
                          actions: [
                            TextButton(onPressed: () {
                              deleteMenu(widget.model.menuID!);
                            }, child: Text('Yes')),
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text('No')),
                          ],
                        ),);
                    },
                    child: Icon(Icons.delete_sweep,color: Colors.red,)),
              ],),)
            ]),
           
              
             




              
            ],
          ),
        ),
      ),
    );
  }




}

