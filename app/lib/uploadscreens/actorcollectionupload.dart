import 'dart:io';
import 'dart:ui';
import 'package:app/model/actormodel.dart';
import 'package:app/pages/screenpage.dart';
import 'package:app/widgets/errordialog.dart';
import 'package:app/widgets/progressindicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'as storageRef;
class ActorCollectionUploadScreen extends StatefulWidget {
  final ActorModel? model;
  ActorCollectionUploadScreen({this.model});
  @override
  State<ActorCollectionUploadScreen> createState() => _ActorCollectionUploadScreenState();
}

class _ActorCollectionUploadScreenState extends State<ActorCollectionUploadScreen> {
  
  XFile? imageXFile;
  final ImagePicker _picker=ImagePicker();
  TextEditingController shortInfoController=TextEditingController();
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  bool uploading = false;
  String uniqueIdName =DateTime.now().millisecondsSinceEpoch.toString();
  defaultScreen(){
    
    return Scaffold(
       appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.cyan,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text('Add New Item',
        style: TextStyle(fontSize: 20,
        fontFamily: 'Lobster'),),
        centerTitle: true,
        automaticallyImplyLeading: true,
       leading: IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Screenpage();
        },));
       }, 
       icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.cyan,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shop_2,color: Colors.white,size: 200,),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Colors.amber),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )) 
                ),
                onPressed: (){
                  takeImage(context);
                },
               child: const Text('Add New item',style: TextStyle(
                color: Colors.white,fontSize: 18
               ),))
              ],
          ),
        ),
      ),
    );
  }
  takeImage(mContext){
    return showDialog(context: mContext,
     builder: (context) {
       return SimpleDialog(
        title: const Text('Menu Image',
        style: TextStyle(
          color: Colors.amber,fontWeight: FontWeight.bold
        ),),
      
        children: [
          SimpleDialogOption(
            child: const Text('Capture With Camera',
            style: TextStyle(
              color: Colors.black
            ),
            ),
            onPressed: captureImageWithCamera,
          ),
          SimpleDialogOption(
            child: const Text('Select From Gallery',
            style: TextStyle(
              color: Colors.black
            ),
            ),
            onPressed: pickimageFromGallery,
          ),
          SimpleDialogOption(
            child: const Text('Cancel',
            style: TextStyle(
              color: Colors.black
            ),
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
       );
     },);
  }
  captureImageWithCamera()async{
    Navigator.pop(context);
    imageXFile=await _picker.pickImage(source: ImageSource.camera,
    maxHeight: 720,
    maxWidth: 1280
    );
    setState(() {
      imageXFile;
    });
  }


  pickimageFromGallery()async{
    Navigator.pop(context);
    imageXFile=await _picker.pickImage(source: ImageSource.gallery,
    maxHeight: 720,
    maxWidth: 1280
    );
    setState(() {
      imageXFile;
    });
  }

  itemUploadFormScreen(){
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.cyan,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text('Uploading New Item',
        style: TextStyle(fontSize: 20,
        fontFamily: 'Lobster'),),
        centerTitle: true,
        automaticallyImplyLeading: true,
       leading: IconButton(onPressed: (){
       clearMenuUploadForm();
       }, 
       icon: const Icon(Icons.arrow_back)),
       actions: [
        TextButton(onPressed: 
       uploading ? null:()=> validateUploadForm(),
        
         child: const Text('Add',
         style: TextStyle(
          color: Colors.amber,fontWeight: FontWeight.bold,
          fontSize: 20,fontFamily: 'Lobster'
         ),))
       ],
      ),
      body: ListView(
        children: [
          uploading == true?linearProgress():const Text(''),
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width*0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imageXFile!.path)),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.amber,),

     
         
          
        ],
      ),
    );
  }
  clearMenuUploadForm(){
   setState(() {
      shortInfoController.clear();
    titleController.clear();
    imageXFile=null;
    priceController.clear();
    descriptionController.clear();
   });
  }
  validateUploadForm()async{

if (imageXFile !=null)
{
 
    //upload the image
    String downloadUrl = await uploadImage(File(imageXFile!.path));
    //save image to firebase
    saveInfo(downloadUrl, );
    setState(() {
  uploading = true;
});


}else{
  showDialog(context: context,
         builder: (c){
          return const ErrorDialog(
            message: 'Please pick an image for Menu',
          );
         });
}
  }
 saveInfo(String downloadUrl) {
    final ref = FirebaseFirestore.instance
       
        
        .collection("actor").doc(widget.model!.menuID)
        .collection('items');

    ref.doc(uniqueIdName).set({
      "itemID": uniqueIdName,
      "menuID": widget.model!.menuID,
    
    
      "thumbnailUrl": downloadUrl,
    }).then((value) {
       final itemsRef = FirebaseFirestore.instance.collection("items");

       
    itemsRef.doc(uniqueIdName).set({
      "itemID": uniqueIdName,
      "menuID": widget.model!.menuID,
      
      "thumbnailUrl": downloadUrl,
    });
    }).then((value){
       clearMenuUploadForm();

    setState(() {
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
    });

   
  }
  
  uploadImage(mImageFile)async{
    storageRef.Reference reference =storageRef.FirebaseStorage.instance
    .ref().
    child('items');

    storageRef.UploadTask uploadTask = reference.child(uniqueIdName + '.jpg').putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot =await uploadTask.whenComplete((){});

  String downloadUrl =await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;

  }



  @override
  Widget build(BuildContext context) {
    
    return imageXFile==null? defaultScreen():itemUploadFormScreen();
  }
}