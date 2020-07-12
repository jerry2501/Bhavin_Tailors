
import 'package:bhavintailors/Pages/zoom_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class careouselView extends StatefulWidget {
  List front;

  careouselView({@required this.front});
  @override
  _careouselViewState createState() => _careouselViewState();
}

class _careouselViewState extends State<careouselView> {
  int _current=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Bhavin Tailors',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 22),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              height: 400,
              enableInfiniteScroll: false,
              initialPage: 0,
              enlargeCenterPage: true,
              onPageChanged: (index){
                setState(() {
                  _current=index;
                });
              },
              items: widget.front.map((imgUrl){
                return Builder(
                  builder: (BuildContext context){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.red,style: BorderStyle.solid)
                      ),
                      child: GestureDetector(child: CachedNetworkImage(imageUrl:imgUrl,
                        fit: BoxFit.fitWidth,
                        placeholder: (context,url)=>CircularProgressIndicator(),
                        errorWidget: (context,url,error)=>Icon(Icons.error,color: Colors.red,),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> zoomView(imgUrl: imgUrl,)));
                      },
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(widget.front,(index,url){
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current==index?Colors.red:Colors.grey,
                  ),
                );
              }),
            ),
             Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.touch_app,color: Colors.grey,),
                  SizedBox(width: 10,),
                  Text('Tap on Image to Zoom',style: TextStyle(fontFamily: 'CrimsonText',color: Colors.grey,fontSize: 16),),
                ],
              ),
          ],
        ),
      ),
    );
  }

  List<T> map<T>(List list,Function handler){
    List<T> result=[];
    for(var i=0;i<list.length;i++){
      result.add(handler(i,list[i]));
    }
    return result;
  }
}
