import 'package:app/fullscreen.dart';
import 'package:app/model/actormodel.dart';
import 'package:app/pages/screenpage.dart';
import 'package:app/tabbarview.dart/actorcollections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:math' as Math;







class ActorCollectionDesignWidget extends StatefulWidget {
  ActorModel model;
  BuildContext? context;

  ActorCollectionDesignWidget({required this.model, this.context});

  @override
  _ActorCollectionDesignWidgetState createState() => _ActorCollectionDesignWidgetState();
}

class _ActorCollectionDesignWidgetState extends State<ActorCollectionDesignWidget> {
  
deleteItem(String itemID) {
    FirebaseFirestore.instance
       
        
        .collection("actor")
        .doc(widget.model.menuID)
        .collection("items")
        .doc(itemID)
        .delete()
        .then((value) {
      FirebaseFirestore.instance.collection("items").doc(itemID).delete();

      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const Screenpage()));
 
    });
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
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Image.network(
                    widget.model.thumbnailUrl!,
                    height: MediaQuery.of(context).size.width*0.5-14,
                    
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              
            ]),
           
              
             




              
            ],
          ),
        ),
      ),
    );
  }




}

