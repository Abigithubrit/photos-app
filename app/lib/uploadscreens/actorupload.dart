import 'dart:io';
import 'dart:ui';
import 'package:app/pages/screenpage.dart';
import 'package:app/widgets/errordialog.dart';
import 'package:app/widgets/progressindicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'as storageRef;
class ActorUploadScreen extends StatefulWidget {
  const ActorUploadScreen({super.key});

  @override
  State<ActorUploadScreen> createState() => _ActorUploadScreenState();
}

class _ActorUploadScreenState extends State<ActorUploadScreen> {
  
  XFile? imageXFile;
  final ImagePicker _picker=ImagePicker();
  TextEditingController titleController=TextEditingController();
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
        title: const Text('Add New Actor',
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
               child: const Text('Add New Actor',style: TextStyle(
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

  menuUploadFormScreen(){
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
        title: const Text('Uploading New actor',
        style: TextStyle(fontSize: 16,
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

         
const Divider(color: Colors.amber,),
          ListTile(
            leading: const Icon(Icons.title,color: Colors.cyan,),
            title: Container(
              width: 250,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Actor name',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black)
                ),
                controller: titleController,
                style: const TextStyle(
                  color: Colors.black
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
    titleController.clear();
    imageXFile=null;
   });
  }
  validateUploadForm()async{

   if (imageXFile !=null)
{
  if( titleController.text.isNotEmpty)
  {
    //upload the image
    String downloadUrl = await uploadImage(File(imageXFile!.path));
    //save image to firebase
    saveInfo(downloadUrl, );
    setState(() {
  uploading = true;
});
  }
  else{
    showDialog(context: context,
         builder: (c){
          return const ErrorDialog(
            message: 'Please write title and info for menu',
          );
         });
  }

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
        .collection("actor");
        
        Navigator.pop(context);

    ref.doc(uniqueIdName).set({
      "menuID": uniqueIdName,
      'name':titleController.text,

      
      "thumbnailUrl": downloadUrl,
    });

    clearMenuUploadForm();

    setState(() {
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
  }
  
  uploadImage(mImageFile)async{
    storageRef.Reference reference =storageRef.FirebaseStorage.instance
    .ref().
    child('actor');

    storageRef.UploadTask uploadTask = reference.child(uniqueIdName + '.jpg').putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot =await uploadTask.whenComplete((){});

  String downloadUrl =await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;

  }



  @override
  Widget build(BuildContext context) {
    
    return imageXFile==null? defaultScreen():menuUploadFormScreen();
  }
}