import 'package:app/Design/actordesign.dart';
import 'package:app/Design/cartoondesign.dart';
import 'package:app/model/actormodel.dart';
import 'package:app/uploadscreens/actorupload.dart';
import 'package:app/uploadscreens/cartoon.dart';
import 'package:app/uploadscreens/cartooncollectionupload.dart';
import 'package:app/widgets/next.dart';
import 'package:app/widgets/progressindicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Cartoons extends StatefulWidget {
  const Cartoons({super.key});

  @override
  State<Cartoons> createState() => _CartoonsState();
}

class _CartoonsState extends State<Cartoons> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('images/c.jpg'),
                ),
                Expanded(child: Text('  Post a pic')),
                IconButton(onPressed: () {
                  next(context, CartoonUploadScreen());
                }, icon: Icon(Icons.add))
              ],
            ),
          ),
           Container(
              
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('cartoon')
              
                .snapshots(),
            
                builder:(context, snapshot) {
                  return !snapshot.hasData? 
                  Center(child: circularProgress(),)
                  :GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                     physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    

                  ),
                 itemCount: snapshot.data!.docs.length,
                   
                    itemBuilder:(context, index) {
                    ActorModel sModel = ActorModel.fromJson(
                        snapshot.data!.docs[index].data() as Map<String,dynamic>
                      );
                      //design for display sellers cafes
                      return CartoonDesignWidget(
                        model: sModel,
                        context: context,
                      );
                    },);
                },),
            )
        ],
      ),
    );
  }
}