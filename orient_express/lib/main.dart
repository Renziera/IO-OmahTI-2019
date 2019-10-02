import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baker Street',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masuk'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'It\'s hidden in plain sight. Use fire to expel those phantoms.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                maxLength: 6,
                textAlign: TextAlign.center,
                onSubmitted: (String s) async {
                  _controller.clear();
                  if (s.isEmpty) return;
                  DocumentSnapshot ds = await Firestore.instance
                      .collection('tim')
                      .document(s)
                      .get();
                  if (ds.exists) {
                    if (ds.data['solved'] ?? false) {
                      await ds.reference.updateData({
                        'solved': true,
                        'waktu': FieldValue.serverTimestamp(),
                      });
                    }
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ExplanationPage(
                          docRef: ds.reference,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExplanationPage extends StatelessWidget {
  final DocumentReference docRef;

  const ExplanationPage({Key key, @required this.docRef}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disclaimer'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => IdeaPage(
                docRef: docRef,
              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
              '\nPertama-tama, saya ucapkan selamat karena kalian telah sampai di sini.\n\nAplikasi ini memang jelek, jangan tertawakan saya. Jangan lupa teman anda saya tawan. Untuk membebaskannya ada satu Quest lagi yang harus kalian selesaikan. Yaitu kalian harus membuat suatu produk MVP (Minimum Viable Product). Produk dapat berupa apa saja, mulai dari aplikasi mobile, web, maupun game dengan tema bebas. Yang akan saya lihat adalah kekompakan serta kegigihan kalian dalam membuatnya.\n\nSaya tahu kalian masih maba, jadi saya beri keringanan yaitu kalian boleh berkonsultasi sesuai bidangnya dengan orang-orang ini:\n\nKadiv Gemdep\nKadiv MA\nKadiv Weebdev\nKadiv WD\nStanley Heryanto\n\nJika kalian sudah tahu apa yang akan dibuat, silahkan cantumkan ide kalian di halaman berikutnya.\n\nNB: Aplikasi ini tidak bisa di decompile, jangan coba-coba :v'),
        ),
      ),
    );
  }
}

class IdeaPage extends StatefulWidget {
  final DocumentReference docRef;

  const IdeaPage({Key key, @required this.docRef}) : super(key: key);
  @override
  _IdeaPageState createState() => _IdeaPageState();
}

class _IdeaPageState extends State<IdeaPage> {
  final TextEditingController _timController = TextEditingController();
  final TextEditingController _ideController = TextEditingController();
  List<bool> selections = [false, false, false, false];
  String _title = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    DocumentSnapshot ds = await widget.docRef.get();
    if (ds.data['ide'] == null) return;
    setState(() {
      _timController.text = ds.data['nama'];
      _ideController.text = ds.data['ide'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _timController,
                decoration: InputDecoration(hintText: 'Nama Tim'),
              ),
              SizedBox(height: 16),
              ToggleButtons(
                children: <Widget>[
                  Text('Mobile'),
                  Text('Web'),
                  Text('Game'),
                  Text('Others'),
                ],
                isSelected: selections,
                onPressed: (int index) {
                  setState(() {
                    selections[index] = !selections[index];
                  });
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: _ideController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 20,
                decoration: InputDecoration(hintText: 'Ide produk'),
              ),
              SizedBox(height: 16),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('GAS'),
                onPressed: ()async {
                  if (_timController.text.isEmpty ||
                      _ideController.text.isEmpty) return;
                  await widget.docRef.updateData({
                    'nama':_timController.text,
                    'ide':_ideController.text,
                    'ubah_id': FieldValue.increment(1),
                    'waktu_ide': FieldValue.serverTimestamp(),
                  });  
                  setState(() {
                   _title = ':)'; 
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
