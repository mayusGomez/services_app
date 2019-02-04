import 'package:flutter/material.dart';


class GoogleAuthButton extends StatelessWidget{

  final Function onPressedCallback;
  GoogleAuthButton({ this.onPressedCallback });

  @override
  Widget build(BuildContext context){

    return RaisedButton(
      onPressed: onPressedCallback,
      child: new Container(
        width: 230.0,
        height: 50.0,
        alignment: Alignment.center,
        child: new Text(
              'Login with Google',
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
      ),
    );

  }

}