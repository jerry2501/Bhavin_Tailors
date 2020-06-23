import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class SimpleBlouseBloc{
  final StreamController<QuerySnapshot> _simpleblousecontroller=StreamController<QuerySnapshot>();
  Stream<QuerySnapshot> get simpleblouseStream => _simpleblousecontroller.stream; //getter method to take value from stream controller

  void dispose(){
    _simpleblousecontroller.close();
  }
  
  Future getDetails() async{
    QuerySnapshot snapshot=await Firestore.instance.collection('collection').document('blouse').collection('simple_blouse').getDocuments();
    _simpleblousecontroller.add(snapshot);
  }
}