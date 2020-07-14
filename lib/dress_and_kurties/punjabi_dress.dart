
import 'package:bhavintailors/Pages/carousel_view_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';


class PunjabiDress extends StatefulWidget {

  @override
  _PunjabiDressState createState() => _PunjabiDressState();
}

class _PunjabiDressState extends State<PunjabiDress> {
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
      await Firestore.instance.collection('collection').document('blouse').collection('punjabi_dress').document(snapshot.data['uid']).updateData({'likedBy':FieldValue.arrayRemove([userId])});
    }
    if(isLiked==false){
      await Firestore.instance.collection('collection').document('blouse').collection('punjabi_dress').document(snapshot.data['uid']).updateData({'likedBy':FieldValue.arrayUnion([userId])});
    }

//    setState(() {
//      isUserLiked=isLiked;
//    });
//    print('isUserLiked;$isUserLiked');
    return !isLiked;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (state==false)?Center(child: CircularProgressIndicator(),):
      StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('collection').document('blouse').collection('punjabi_dress').snapshots(),
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
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(imageUrl:snapshot.data.documents[index].data['front'],
                    fit: BoxFit.fill,
                    placeholder: (context,url)=>Icon(Icons.image,color: Colors.grey,),
                    errorWidget: (context,url,error)=>Icon(Icons.error,color: Colors.red,),
                  ),
                ),
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
