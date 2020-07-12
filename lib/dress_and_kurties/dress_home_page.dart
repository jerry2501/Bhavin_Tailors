
import 'package:bhavintailors/Pages/navigation_drawer.dart';
import 'package:bhavintailors/Services/auth.dart';
import 'package:bhavintailors/common_widgets/platform_alert_dialog.dart';
import 'package:bhavintailors/dress_and_kurties/chudidar_dress.dart';
import 'package:bhavintailors/dress_and_kurties/kurties_with_tousers.dart';
import 'package:bhavintailors/dress_and_kurties/punjabi_dress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DressHomePage extends StatefulWidget {

  @override
  _DressHomePageState createState() => _DressHomePageState();
}

class _DressHomePageState extends State<DressHomePage> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dress & Kurties',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 22),),
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelStyle: TextStyle(fontFamily: 'SourceProText'),
            tabs: <Widget>[
              Tab(text: "Punjabi",),
              Tab(text: "Chudidar",),
              Tab(text: "Kurti With Trousers",),
            ],
          ),
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
        body:TabBarView(
          children: <Widget>[
            PunjabiDress(),
            ChudidarDress(),
            KurtiWithTrousers(),
          ],
        ),
      ),
    );
  }
}


