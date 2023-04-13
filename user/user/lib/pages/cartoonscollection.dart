
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user/design/actorcollectiondesign.dart';
import 'package:user/model/actormodel.dart';
import 'package:user/widgets/progressindicator.dart';

class CartoonScreen extends StatefulWidget {
final ActorModel? model;

  const CartoonScreen({super.key, this.model});
  @override
  State<CartoonScreen> createState() => _CartoonScreenState();
}

class _CartoonScreenState extends State<CartoonScreen> {
  
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
        title: Text('Cartoon Collection',
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
                stream: FirebaseFirestore.instance.collection('cartoon')
                .doc(widget.model!.menuID)
                .collection("collection")

              
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
                      return ActorCollectionDesignWidget(
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