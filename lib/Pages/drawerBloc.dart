import 'dart:async';

import 'package:bhavintailors/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class drawerBloc{
  drawerBloc({this.auth});
  final AuthBase auth;

  final StreamController<FirebaseUser> _accountController=StreamController<FirebaseUser>();

  Stream<FirebaseUser> get accountStream => _accountController.stream;
  void dispose(){
    _accountController.close();
  }

  Future<void> userDetails() async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    _accountController.add(user);
  }

}