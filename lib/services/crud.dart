import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class crudMethods{
  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser !=null){
      return true;
    }
    else{
      return false;
    }
  }
  Future<void> addData(carData) async{
    if(isLoggedIn()){
     /* FirebaseFirestore.instance.collection('testcrud').add(carData).catchError((e){
        print(e);
      });*/
     FirebaseFirestore.instance.runTransaction((Transaction crudTransaction) async{
      CollectionReference reference=await FirebaseFirestore.instance.collection('testcrud');
     reference.add(carData);
     });
    }
    else{
      print('You need to be logged in');
    }
  }
  getData() async{
    return await FirebaseFirestore.instance.collection('testcrud').snapshots();
  }
  updateData(selectedDoc, newValues){
    FirebaseFirestore
        .instance.collection('testcrud')
        .doc(selectedDoc)
        .update(newValues)
        .catchError((e){
          print(e);
    });
  }
  deleteDate(docId){
    FirebaseFirestore.instance
        .collection('testcrud')
        .doc(docId)
        .delete()
        .catchError((e){
          print(e);
    });
  }
}