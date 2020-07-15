

import 'dart:async';
import 'dart:io';

import 'package:bhavintailors/Pages/SignInBloc.dart';
import 'package:bhavintailors/Services/auth.dart';
import 'package:bhavintailors/common_widgets/platform_exception_alert_dialouge.dart';
import 'package:bhavintailors/common_widgets/social_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key,@required this.bloc}) : super(key: key);
  final SignInBloc bloc;


  static Widget create(BuildContext context){
    final auth=Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      builder: (_)=>SignInBloc(auth: auth),
      dispose: (context,bloc)=>bloc.dispose(), //it is used to dispose bloc when widget removed from widget tree
      child: Consumer<SignInBloc>(builder:(context,bloc,_)=> SignInPage(bloc: bloc,)), //to access bloc and pass it to constructor
    );
  }

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  void _showSignInError(BuildContext context,PlatformException exception){
    PlatformExceptionAlertDialog(   //Used two dart file Platform_exception_alert_dailog and platform_alert_dailog
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInWithGoogle(BuildContext context) async{
    try {
      await widget.bloc.signInWithGoogle();
    }on PlatformException catch(e){
      if(e.code!='ERROR_ABORTED_BY_USER'){
        _showSignInError(context, e);
      }
    }
  }

  Future<bool> onWillPop() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit an App?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                exit(0);
              },
            )
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: StreamBuilder<bool>(
          stream: widget.bloc.isLoadingStream,
          initialData: false,
          builder: (context,snapshot){ return  buildContent(context,snapshot.data);},
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context,bool isLoading) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.1,1],
                  colors: [Colors.red[400],Colors.white],
              )
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset('images/ic_launcher.png'),
              ),
              Text('Bhavin Tailors',style: TextStyle(color: Colors.white,fontFamily:'CrimsonText',fontSize: 30),),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SocialSignInButton(
                  assetName: 'images/google-logo.png',
                  text: 'Sign in with Google',
                  textcolor: Colors.black87,
                  color: Colors.white,
                  onPressed:isLoading?null:()=> _signInWithGoogle(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
