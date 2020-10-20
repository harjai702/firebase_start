import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  File sampleImage;
  String carModel;
  String carColor;
  Stream cars;
  crudMethods crudObj=new crudMethods();
  Future getImage() async{
    final tempImage=await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      sampleImage=File(tempImage.path);
      imgDialog(context);
    });
  }
  Future<bool> addDialog(BuildContext context) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title:Text('Add Data', style:TextStyle(fontSize: 15.0)),
            content:Column(
              children:<Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car name'),
                  onChanged: (value){
                    this.carModel=value;
                  },
                ),
                SizedBox(height:5.0),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car color'),
                  onChanged: (value){
                    this.carColor=value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child:Text('Add'),
                textColor: Colors.blue,
                onPressed:(){
                  Navigator.of(context).pop();
                  //Map<String,String> carData={'carName':this.carModel,'color':this.carColor};
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.carColor
                  }).then((result){
                    dialogTrigger(context);
                  }).catchError((e){
                    print(e);
                  });
                },
              ),
            ],
          );
        }
    );
  }
  Future<bool> imgDialog(BuildContext context) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title:Text('Add image', style:TextStyle(fontSize: 15.0)),
            content: Container(
            child: Image.file(sampleImage,height: 300.0,width: 300.0,),
            ),
            actions: <Widget>[
              FlatButton(
                child:Text('Add'),
                textColor: Colors.blue,
                onPressed:(){
                final StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child('myimage.jpg');
                final StorageUploadTask task=firebaseStorageRef.putFile(sampleImage);
                },
              ),
            ],
          );
        }
    );
  }
  Future<bool> updateDialog(BuildContext context,selectedDoc) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title:Text('Update Data', style:TextStyle(fontSize: 15.0)),
            content:Column(
              children:<Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car name'),
                  onChanged: (value){
                    this.carModel=value;
                  },
                ),
                SizedBox(height:5.0),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter car color'),
                  onChanged: (value){
                    this.carColor=value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child:Text('Update'),
                textColor: Colors.blue,
                onPressed:(){
                  Navigator.of(context).pop();
                  //Map<String,String> carData={'carName':this.carModel,'color':this.carColor};
                  crudObj.updateData(selectedDoc,{
                    'carName': this.carModel,
                    'color': this.carColor
                  }).then((result){
                    dialogTrigger(context);
                  }).catchError((e){
                    print(e);
                  });
                },
              ),
            ],
          );
        }
    );
  }
  Future<bool> dialogTrigger(BuildContext context) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content:Text('Added'),
            title:Text('Job Done', style:TextStyle(fontSize: 15.0)),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed:(){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
@override
void initState(){
    crudObj.getData().then((results){
      setState((){
        cars = results;
      });
    });
    super.initState();
}
  @override
  Widget build(BuildContext contet){
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:Text('Dashboard'),
        actions:<Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              addDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: (){
              getImage();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              crudObj.getData().then((results){
                setState((){
                  cars = results;
                });
              });
            },
          ),
        ],
      ),
      body: _carList()
    );
  }
  Widget _carList(){
   if(cars!=null){
     return StreamBuilder(
       stream:cars,
       builder: (context, snapshot){
         return ListView.builder(
           itemCount: snapshot.data.docs.length,
           padding: EdgeInsets.all(5.0),
           itemBuilder: (context,i){
             return new ListTile(
               title: Text(snapshot.data.docs[i].data()['carName']),
               subtitle: Text(snapshot.data.docs[i].data()['color']),
               onTap: (){
                 updateDialog(context, snapshot.data.docs[i].documentID);
               },
               onLongPress: (){
                 crudObj.deleteDate(snapshot.data.docs[i].documentID);
               },
             );
           },
         );
       }
     );
   }
   else{
     return Text('Loading, Please wait..');
   }
  }
}