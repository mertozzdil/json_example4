import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JSON APP",
      home: JsonApp(),
    );
  }
}

class JsonApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JsonAppState();
  }
}

class _JsonAppState extends State<JsonApp> {
  var veri;

  void doGet(){
    http.get("https://google.com.tr").then((response) {
      setState(() {
        veri = response.body.toString();
      });
    });

  }
  void doPost(){
    http.post("https://jsonplaceholder.typicode.com/posts", body: {
      "title":"uygulamadan geldim",
      "body":"buna karşı sunucudan cevap gelecek",
      "userId":"5"
    }).then((response){
      setState(() {
        veri = response.body;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Json",style: TextStyle(color: Colors.blueAccent),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: getButton(),
              ),
              new Expanded(
                child: postButton(),
              )
            ],
          ),
          new Expanded(
              child: new Center(
                child: new ListView(
                  children: <Widget>[
                    new Text("${veri}")
                  ],
                ),
              )
          )
        ],
      ),
    );
  }

  FlatButton getButton() {
    return new FlatButton(
      child: Text("GET", style: TextStyle(color: Colors.blueGrey),),
      onPressed: doGet,
    );
  }

  FlatButton postButton() {
    return new FlatButton(
      child: Text("POST", style: TextStyle(color: Colors.blueGrey)),
      onPressed: doPost,
    );
  }
}
