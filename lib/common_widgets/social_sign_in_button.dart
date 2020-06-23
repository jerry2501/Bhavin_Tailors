import 'package:flutter/cupertino.dart';
import 'package:bhavintailors/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton{
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textcolor,
    VoidCallback onPressed,
  }): assert(assetName!=null),
        assert(text!=null),
        super(
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(assetName),
        Text(text,
         style: TextStyle(color: textcolor,fontSize: 15),
        ),
        Opacity(
            opacity: 0.0,
            child: Image.asset('images/google-logo.png')
        ),
      ],
    ),
    color:color,
    onPressed:onPressed,
  );
}