
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/design/cartoondesign.dart';
import 'package:user/model/actormodel.dart';
import 'package:user/widgets/progressindicator.dart';
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