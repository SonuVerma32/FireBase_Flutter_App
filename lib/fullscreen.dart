import 'package:flutter/material.dart';

class fullScreenPath extends StatelessWidget {
  String imagePath;
  fullScreenPath(this.imagePath);
  final LinearGradient bggrediant = new LinearGradient(
      colors: [new Color(0x1010000000),new Color(0x30000000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SizedBox.expand(
        child: new Container(
          color: Colors.brown,
          child: new Stack(

            children: <Widget>[

              new Align(
                alignment: Alignment.center,
                child: new Hero(
                  tag: imagePath,
                  child: Image.network(imagePath),

                ),
              ),
              new Align(
                alignment: Alignment.topLeft,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new AppBar(
                      elevation: 8.0,
                      backgroundColor: Colors.transparent,
                      leading: new IconButton(
                          icon: new Icon(Icons.close,color: Colors.black),
                          onPressed: () => Navigator.of(context).pop())
                      ,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
