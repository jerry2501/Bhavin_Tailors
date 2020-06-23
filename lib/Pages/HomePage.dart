
import 'package:bhavintailors/Pages/navigation_drawer.dart';
import 'package:bhavintailors/Services/auth.dart';
import 'package:bhavintailors/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut(BuildContext context) async{
    try {
      final auth=Provider.of<AuthBase>(context);
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async{
    final didRequestSignOut= await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    print('didRequestSignOut:$didRequestSignOut');
    if(didRequestSignOut==true){
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bhavin Tailors',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 22),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
           icon: Icon(Icons.power_settings_new,color: Colors.white,),
            onPressed: (){
              _confirmSignOut(context);
            },
          ),
        ],

      ),
      drawer: NavigationDrawer.create(context),
    );
  }
}


