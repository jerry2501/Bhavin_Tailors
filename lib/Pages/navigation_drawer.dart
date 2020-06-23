import 'package:bhavintailors/Pages/drawerBloc.dart';
import 'package:bhavintailors/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationDrawer extends StatefulWidget {
 drawerBloc bloc;
 NavigationDrawer({this.bloc});
  static Widget create(BuildContext context){
    final auth=Provider.of<AuthBase>(context);
    return Provider<drawerBloc>(
      builder: (_)=>drawerBloc(auth: auth),
      dispose: (context,bloc)=>bloc.dispose(), //it is used to dispose bloc when widget removed from widget tree
      child: Consumer<drawerBloc>(builder:(context,bloc,_)=> NavigationDrawer(bloc:bloc)), //to access bloc and pass it to constructor
    );
  }

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.bloc.userDetails();
  }
  @override
  Widget build(BuildContext context) {
   return Drawer(
     child:StreamBuilder<FirebaseUser>(
       stream: widget.bloc.accountStream,
       builder: (context,snapshot){
         if(snapshot.hasData){
         return  buildContent(context,snapshot.data);}
         else{
           return Center(child: CircularProgressIndicator(),);
         }
       }
     )
   );
  }

  Widget buildContent(BuildContext context,FirebaseUser user){

    return ListView(
      children:<Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(user.displayName,style:TextStyle(fontFamily: 'CrimsonText',fontSize: 16),),
          accountEmail: Text(user.email,style: TextStyle(fontFamily: 'SourceSansPro',fontSize: 16),),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(user.displayName.substring(0,1),style: TextStyle(fontSize: 40,color: Colors.red,),),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard,color: Colors.red,),
          title: Text('Blouse',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
          subtitle: Text('All types',style: TextStyle(fontFamily:'SourceSansPro' ),),
        ),
        ListTile(
          leading: Icon(Icons.dashboard,color: Colors.red,),
          title: Text('Dress & kurties',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
          subtitle: Text('All types',style: TextStyle(fontFamily:'SourceSansPro' ),),
        ),
        Divider(thickness: 2,),
        ListTile(
          leading: Icon(Icons.favorite,color: Colors.red,),
          title: Text('Favourites',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
        ),
        ListTile(
          leading: Icon(Icons.contacts,color: Colors.red,),
          title: Text('Address & Contact',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
        ),
        Divider(thickness: 2,),
        ListTile(
          leading: Icon(Icons.share,color: Colors.red,),
          title: Text('Share this App',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
        ),
      ],
    );
  }
}

