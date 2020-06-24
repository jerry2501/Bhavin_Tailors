
import 'package:bhavintailors/Pages/carousel_view_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';


class SimpleBlouse extends StatefulWidget {

  @override
  _SimpleBlouseState createState() => _SimpleBlouseState();
}

class _SimpleBlouseState extends State<SimpleBlouse> {
  String userId;
  bool state=false;
  bool isUserLiked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  Future getUserId() async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    setState(() {
      userId=user.uid;
      state=true;
    });
  }

  Future<bool> onLikeTapped(bool isLiked,DocumentSnapshot snapshot) async{
    print(isLiked);
    if(isLiked==true){
      await Firestore.instance.collection('collection').document('blouse').collection('simple_blouse').document(snapshot.data['uid']).updateData({'likedBy':FieldValue.arrayRemove([userId])});
    }
    if(isLiked==false){
      await Firestore.instance.collection('collection').document('blouse').collection('simple_blouse').document(snapshot.data['uid']).updateData({'likedBy':FieldValue.arrayUnion([userId])});
    }

//    setState(() {
//      isUserLiked=isLiked;
//    });
//    print('isUserLiked;$isUserLiked');
    return !isLiked;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (state==false)?Center(child: CircularProgressIndicator(),):
      StreamBuilder<QuerySnapshot>(
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
             child: Stack(

               children: <Widget>[
                 Positioned(
                   right: 0,
                   child: LikeButton(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     size: 30,
                     isLiked: (snapshot.data.documents[index].data['likedBy'].contains(userId))?true:false,
                     onTap:(isLiked) => onLikeTapped(isLiked,snapshot.data.documents[index]),
                   ),
                 ),
                     SizedBox(height: 30,),
                     Align(
                       alignment: Alignment.center,
                       child: Image(
                             image: NetworkImage(snapshot.data.documents[index].data['front'],
                             scale: 7,
                             ),
                           ),
                     ),
                   Positioned(
                       bottom: 0,
                       child:  Container(
                         height: 40,
                          width: 190,
                          decoration: BoxDecoration(color: Colors.grey[100]),
                         ),
                     ),
                 Align(
                   alignment: Alignment.bottomCenter,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text('2x Images',style: TextStyle(fontFamily: 'SourceSansPro',color: Colors.red[300],fontWeight: FontWeight.bold),
                     ),
                   ),
                 ),
               ],
             ),
           ),
           onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(context)=> careouselView(front: [snapshot.data.documents[index].data['front'],snapshot.data.documents[index].data['back']].toList(),))),
         );
      },
    );
  }
}
