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
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello :)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 72),
            ),
            Text(
              'I WANT TO PLAY A GAME.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 256,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Icon(Icons.lock_open),
              onPressed: () {
                if (_controller.text == '5E#7G1R^@CM1g!rIOM3emxL@jvsrB^O8') {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => DownloadPage()));
                }
                _controller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DownloadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IO OmahTI 2019'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Gampang kan ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 64),
            ),
            Text(
              'Tapi ini hanya pemanasan hehehe\nQuest kalian baru dimulai sekarang :)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Icon(Icons.phone_android),
              onPressed: () => print('/abc.apk'),
            ),
          ],
        ),
      ),
    );
  }
}
