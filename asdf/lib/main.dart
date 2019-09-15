import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IO 2019',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _teks = 'log me';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 30)).then((value) {
      setState(() {
       _teks = 'console log me'; 
      });
    });
    Future.delayed(Duration(seconds: 60)).then((value) {
      setState(() {
       _teks = 'console.log(me)'; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _teks,
          style: TextStyle(fontSize: 72),
        ),
      ),
    );
  }
}
