import 'package:bhavintailors/Pages/navigation_drawer.dart';
import 'package:bhavintailors/Services/MapUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  var number='8488893172';
  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('Address & Contact',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 20,),),
        centerTitle: true,
        elevation: 0,
        bottom:PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/3),
          child: Column(
            children: <Widget>[
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:CachedNetworkImageProvider('https://firebasestorage.googleapis.com/v0/b/bhavin-tailors.appspot.com/o/bhavin.jpg?alt=media&token=84210446-e800-4447-b6ce-e8b0be662a02',
                      ),
                      fit: BoxFit.fill
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text('Bhavesh KuKadiya',style: TextStyle(fontFamily: 'SourceSansPro',fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text('Founder of Bhavin Tailors (Ramnagar,Ahmedabad)',style: TextStyle(fontFamily: 'CrimsonText',color: Colors.white,fontSize: 16),),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
      drawer: NavigationDrawer.create(context),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shadowColor: Colors.red[300],
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text('Address',style: TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'CrimsonText'),),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('B-1,Bhavin Tailors,NeelKamal Shopping Centre,Ramnagar,Sabarmati,Ahmedabad-380005',style: TextStyle(fontFamily: 'SourceSansPro',),),
                          ),
                          SizedBox(height: 10,),
                          Divider(thickness: 1,),
                          Text('Contact No.',style: TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'CrimsonText'),),
                          SizedBox(height: 5,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.contacts,color: Colors.red,size: 18,),
                              SizedBox(width: 8,),
                              Text(number,style: TextStyle(fontFamily: 'SourceSansPro',fontSize: 18),),
                              SizedBox(width: 10,),
                              GestureDetector(
                                  child: Icon(Icons.content_copy,size: 18,),
                                onTap: (){
                                  Clipboard.setData(new ClipboardData(text: number));
                                  key.currentState.showSnackBar(SnackBar(content: Text('Copied to Clipboard'),));
                                },
                              ),
                            ],
                          ),
                        ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
              GestureDetector(
                child: Text('View Address On Map >',style: TextStyle(color: Colors.red,fontFamily: 'SourceSansPro',fontSize: 16),),
                onTap: ()=>MapUtils.openMap(23.0841149,72.5911226),
              ),
          ],
        ),
    );
  }
}
