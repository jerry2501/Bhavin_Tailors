import 'package:bhavintailors/Pages/HomePage.dart';
import 'package:bhavintailors/Pages/address_page.dart';
import 'package:bhavintailors/Pages/drawerBloc.dart';
import 'package:bhavintailors/Pages/suggestion_page.dart';
import 'package:bhavintailors/Services/auth.dart';
import 'package:bhavintailors/dress_and_kurties/dress_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: Text(user.displayName.substring(0,1),style: TextStyle(fontSize: 40,color: Color.fromRGBO(255, 26, 26, 1),),),
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard,color: Color.fromRGBO(255, 26, 26, 1),),
          title: Text('Blouse',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
          subtitle: Text('All types',style: TextStyle(fontFamily:'SourceSansPro' ),),
          onTap:()=> Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage())),
        ),
        ListTile(
          leading: Icon(Icons.dashboard,color: Color.fromRGBO(255, 26, 26, 1),),
          title: Text('Dress & kurties',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
          subtitle: Text('All types',style: TextStyle(fontFamily:'SourceSansPro' ),),
          onTap:()=> Navigator.push(context, MaterialPageRoute(builder:(context)=>DressHomePage())),
        ),
        Divider(thickness: 2,),
        ListTile(
          leading: Icon(Icons.contacts,color: Color.fromRGBO(255, 26, 26, 1),),
          title: Text('Address & Contact',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
          onTap:()=> Navigator.push(context, MaterialPageRoute(builder:(context)=>AddressPage() )),
        ),
        ListTile(
          leading: Icon(Icons.speaker_notes,color: Color.fromRGBO(255, 26, 26, 1),),
          title: Text('Suggestions',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>SuggestionPage() ));
          },
        ),
        Divider(thickness: 2,),
        ListTile(
          leading: Icon(Icons.share,color: Color.fromRGBO(255, 26, 26, 1),),
          title: Text('Share this App',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 18),),
        ),
      ],
    );
  }
}

