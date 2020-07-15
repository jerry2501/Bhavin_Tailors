import 'package:bhavintailors/Pages/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final GlobalKey<FormState> formkey=GlobalKey<FormState>();
  String title,content;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           title: Text('Feedback',style: TextStyle(fontFamily: 'CrimsonText',fontSize: 22),),
    centerTitle: true,),
      drawer: NavigationDrawer.create(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text('Give Us Your Valuable Suggestions',style: TextStyle(fontFamily: 'SourceSansPro',fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Form(
              key:formkey,
              child: Column(
                children: <Widget>[
                     TextFormField(
                        decoration: InputDecoration(
                          labelText:'Title',
                          hintText: 'Enter Title Here',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                       maxLength: 50,
                       onChanged: (value){
                          setState(() {
                            title=value;
                          });
                       },
                       validator: (value){
                          if(value.isEmpty){
                            return 'Title Should not empty';
                          }
                       },
                      ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText:'Suggetion/Feedback',
                      hintText: 'Write your views here',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    minLines: 5,
                    maxLines: 6,
                    maxLength: 300,
                    onChanged: (value){
                      setState(() {
                        content=value;
                      });
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return 'Write Something!!';
                      }
                    },
                  ),

                ],
              ),
            ),
            RaisedButton(
              color: Colors.red,
              child: Text('Submit',style: TextStyle(color: Colors.white,fontFamily: 'SourceSansPro'),),
              onPressed: (){
                sendEmail();
              },
            )
          ],
        ),
      ),
    );
  }

  Future sendEmail() async{
    final formState=formkey.currentState;
    if(formState.validate()) {
      formState.save();
      final Email email=Email(
        body: content,
        subject: title,
        recipients: ['jigneshprajapati9924@gmail.com'],
      );
      await FlutterEmailSender.send(email);
    }
  }
}
