import 'package:bhavintailors/Pages/navigation_drawer.dart';
import 'package:bhavintailors/Services/auth.dart';
import 'package:bhavintailors/blouse/designer_blouse.dart';
import 'package:bhavintailors/blouse/linen_blouse.dart';
import 'package:bhavintailors/blouse/simple_blouse.dart';
import 'package:bhavintailors/common_widgets/platform_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final key = new GlobalKey<ScaffoldState>();
  final keyIsFirstLoaded = 'is_first_loaded';
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    initializing();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bhavin Tailors',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 22),),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            unselectedLabelStyle: TextStyle(fontFamily: 'SourceProText'),
            tabs: <Widget>[
              Tab(text: "Designer",),
              Tab(text: "Linen Blouse",),
              Tab(text: "Simple",),
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
            DesignerBlouse(),
            LinenBlouse(),
            SimpleBlouse(),
          ],
        ),
      ),
    );
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(
        barrierDismissible:false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Notification"),
            content: new Text("You will Recieve notification so that you can get updated with new collection of kurties & blouse!!"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  _shownotification();
                  prefs.setBool(keyIsFirstLoaded, false);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _shownotification() async{
    await notificaion();
}
  void initializing() async{
    androidInitializationSettings=AndroidInitializationSettings('ic_launcher');
    iosInitializationSettings=IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings=InitializationSettings(androidInitializationSettings,iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
  }

  Future<void> notificaion() async{
    var time=Time(10,0,0);
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
        'Channel _ID',
        'Channel title',
        'Channel body',
        priority: Priority.High,
        importance: Importance.Max,
        styleInformation: BigTextStyleInformation(''),
    );
    IOSNotificationDetails iosNotificationDetails=IOSNotificationDetails();
    NotificationDetails notificationDetails=NotificationDetails(androidNotificationDetails,iosNotificationDetails);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Bhavin Tailors',
        'We have interesting collection of Kurties & blouse\naccording to your choice. Go check it out!!',
        time,
        notificationDetails
    );
  }


  Future onSelectNotification(String payload) async {
    if(payload!=null){
      print(payload);
      try{
        await Navigator.push(
            MyApp.navigatorKey.currentState.context,
            new MaterialPageRoute(
                builder: (context) => MyApp()));}
      catch(e){print(e.toString());}
    }
    //navigate page code here

  }

  Future onDidReceiveLocalNotification(int id,String title,String body,String payload) async{
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(child: Text("okay"),onPressed: (){
          print("");
        },)
      ],
    );
  }
}


