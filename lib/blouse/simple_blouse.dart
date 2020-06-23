
import 'package:bhavintailors/Pages/carousel_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SimpleBlouse extends StatefulWidget {

  @override
  _SimpleBlouseState createState() => _SimpleBlouseState();
}

class _SimpleBlouseState extends State<SimpleBlouse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('collection').document('blouse').collection('simple_blouse').snapshots(),
        builder: (context, snapshot) {
         if(snapshot.hasData){
            return _buildContent(context,snapshot);
         }
         else{
          return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }

  Widget _buildContent(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
    return GridView.builder(
      itemCount: snapshot.data.documents.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context,int index){
         return GestureDetector(
           child: Card(
             child: Image(
               image: NetworkImage(snapshot.data.documents[index].data['front'],
               scale: 5,
               ),
             ),
           ),
           onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(context)=> careouselView(front: [snapshot.data.documents[index].data['front'],snapshot.data.documents[index].data['back']].toList(),))),
         );
      },
    );
  }
}
