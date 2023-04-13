import 'package:app/Design/actordesign.dart';
import 'package:app/Design/actressdesign.dart';
import 'package:app/model/actormodel.dart';
import 'package:app/uploadscreens/actorupload.dart';
import 'package:app/uploadscreens/actresscollectionupload.dart';
import 'package:app/uploadscreens/actressupload.dart';
import 'package:app/widgets/next.dart';
import 'package:app/widgets/progressindicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Actress extends StatefulWidget {
  const Actress({super.key});

  @override
  State<Actress> createState() => _ActressState();
}

class _ActressState extends State<Actress> {
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
                  backgroundImage: AssetImage('images/b.jpg'),
                ),
                Expanded(child: Text('  Post a pic')),
                IconButton(onPressed: () {
                  next(context, ActressUploadScreen());
                }, icon: Icon(Icons.add))
              ],
            ),
          ),
           Container(
              
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('actress')
              
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
                      return ActressDesignWidget(
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