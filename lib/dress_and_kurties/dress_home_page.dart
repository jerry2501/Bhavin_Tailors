
import 'package:bhavintailors/Pages/SignInPage.dart';
import 'package:bhavintailors/Pages/navigation_drawer.dart';
import 'package:bhavintailors/Services/auth.dart';
import 'package:bhavintailors/common_widgets/platform_alert_dialog.dart';
import 'package:bhavintailors/dress_and_kurties/kurties_with_tousers.dart';
import 'package:bhavintailors/dress_and_kurties/punjabi_dress.dart';
import 'package:bhavintailors/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DressHomePage extends StatefulWidget {

  @override
  _DressHomePageState createState() => _DressHomePageState();
}

class _DressHomePageState extends State<DressHomePage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dress & Kurties',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 22),),
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelStyle: TextStyle(fontFamily: 'SourceProText'),
            tabs: <Widget>[
              Tab(text: "Kurties",),
              Tab(text: "Punjabi Dress",),
            ],
          ),
        ),
        drawer: NavigationDrawer.create(context),
        body:TabBarView(
          children: <Widget>[
            KurtiWithTrousers(),
            PunjabiDress(),
          ],
        ),
      ),
    );
  }
}


