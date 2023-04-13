
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/design/actresscollectiondesign.dart';
import 'package:user/model/actormodel.dart';
import 'package:user/widgets/progressindicator.dart';

class ActressScreen extends StatefulWidget {
final ActorModel? model;

  const ActressScreen({super.key, this.model});
  @override
  State<ActressScreen> createState() => _ActressScreenState();
}

class _ActressScreenState extends State<ActressScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.yellow,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: Text('Actress Collection',
        style: TextStyle(fontSize: 20,
        fontFamily: 'Lobster'),),
        centerTitle: true,
        automaticallyImplyLeading: true,
     leading: IconButton(onPressed: () {
      Navigator.pop(context);
     }, icon: Icon(Icons.arrow_back)),
      ),
    
      body: SingleChildScrollView(
      child: Column(
        children: [
          
           Container(
              
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('actress')
                .doc(widget.model!.menuID)
                .collection("item")

              
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
                      return ActressCollectionDesignWidget(
                        model: sModel,
                        context: context,
                      );
                    },);
                },),
            )
        ],
      ),
    ),

    );
  }
}