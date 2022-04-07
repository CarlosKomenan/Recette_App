// ignore_for_file: unused_element, unused_import, library_prefixes, unused_local_variable, avoid_web_libraries_in_flutter, non_constant_identifier_names

import 'dart:html';
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';

import 'package:recette_app/model/domaine_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DBservices {
  // Future<String> uploadImage(File file, {required String path}) async {
  //   var time = DateTime.now().toString();
  //   String img = path + "_" + time;
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   try {
  //     Reference ref = storage.ref().child(path + "/" + img);
  //     await ref.putFile(img!);
  //     UploadTask upload = ref.putFile(img!);
  //     String url = await ref.getDownloadURL();
  //     // upload.then((res) {
  //     //   res.ref.getDownloadURL();
  //     // });
  //     // await upload.onComplete;
  //     return await ref.getDownloadURL();
  //   } catch (e) {
  //     return "null";
  //   }
  // }
}

// StorageReference storageReference;
      // StorageReference ref =
      //     storageReference.child("images/" + UUID.randomUUID().toString());
      // StorageReference ref =
      //     FirebaseStorage.instance.ref().child(path + "/" + img);

      // firebase_storage.Reference ref =
      //     FirebaseStorage.instance.ref().child(path + "/" + img);
      // firebase_storage.UploadTask upload = ref.putFile(file);
// AuthClass authClass = AuthClass();
// final Stream<QuerySnapshot> _stream =
//     FirebaseFirestore.instance.collection("Domaine").snapshots();

// Stream <List<DomaineModel>> getDomaine{
//   return Domaine.snapshots().map(DomaineModel){
//     return DomaineModel.docs
//     .map((e)=>Domaine.fromJson(e.data(),Id_domaine:e.id)).toList();
//   }
// }


// ProgressDialog progressDialog
//                 = new ProgressDialog(this);
//             progressDialog.setTitle("Uploading...");
//             progressDialog.show();
// // UploadImage method
// private void uploadImage()
// {
// if (filePath != null) {

// // Code for showing progressDialog while uploading
// ProgressDialog progressDialog
// = new ProgressDialog(this);
// progressDialog.setTitle("Uploading...");
// progressDialog.show();

// // Defining the child of storageReference
// StorageReference ref
// = storageReference
//       .child(
//           "images/"
//           + UUID.randomUUID().toString());

// // adding listeners on upload
// // or failure of image
// ref.putFile(filePath)
// .addOnSuccessListener(
//     new OnSuccessListener<UploadTask.TaskSnapshot>() {

//         @Override
//         public void onSuccess(
//             UploadTask.TaskSnapshot taskSnapshot)
//         {

//             // Image uploaded successfully
//             // Dismiss dialog
//             progressDialog.dismiss();
//             Toast
//                 .makeText(MainActivity.this,
//                           "Image Uploaded!!",
//                           Toast.LENGTH_SHORT)
//                 .show();
//         }
//     })

// .addOnFailureListener(new OnFailureListener() {
//     @Override
//     public void onFailure(@NonNull Exception e)
//     {

//         // Error, Image not uploaded
//         progressDialog.dismiss();
//         Toast
//             .makeText(MainActivity.this,
//                       "Failed " + e.getMessage(),
//                       Toast.LENGTH_SHORT)
//             .show();
//     }
// })
// .addOnProgressListener(
//     new OnProgressListener<UploadTask.TaskSnapshot>() {

//         // Progress Listener for loading
//         // percentage on the dialog box
//         @Override
//         public void onProgress(
//             UploadTask.TaskSnapshot taskSnapshot)
//         {
//             double progress
//                 = (100.0
//                     * taskSnapshot.getBytesTransferred()
//                     / taskSnapshot.getTotalByteCount());
//             progressDialog.setMessage(
//                 "Uploaded "
//                 + (int)progress + "%");
//         }
//     });