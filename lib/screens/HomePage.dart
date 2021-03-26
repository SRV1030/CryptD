import 'package:CryptD/widget/main_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:CryptD/models/MyEncryptionDecryption.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController crypController1 = new TextEditingController();
  final TextEditingController crypController2 = new TextEditingController();
  final TextEditingController crypController3 = new TextEditingController();
  var cryptedText1,
      plainText1,
      cryptedText2,
      plainText2,
      cryptedText3,
      plainText3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptD'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.all(20),
                elevation: 5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "AES-Encryption",
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextField(
                              controller: crypController1,
                              decoration:
                                  InputDecoration(labelText: "Enter text"),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Plain Text",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(plainText1 == null ? "" : plainText1),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Encrypted Text",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(cryptedText1 == null
                                    ? ""
                                    : cryptedText1 is encrypt.Encrypted
                                        ? cryptedText1.base64
                                        : cryptedText1),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  plainText1 = crypController1.text;
                                  setState(() {
                                    cryptedText1 =
                                        MyEncryptionDecryption.encryptAES(
                                            plainText1);
                                  });
                                },
                                child: Text('Encrypt'),
                              ),
                              SizedBox(width: 10),
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    cryptedText1 =
                                        MyEncryptionDecryption.decryptAES(
                                            cryptedText1);
                                  });
                                },
                                child: Text('Decrypt'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Card(
                margin: EdgeInsets.all(20),
                elevation: 5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Fernet-Encryption",
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextField(
                              controller: crypController2,
                              decoration:
                                  InputDecoration(labelText: "Enter text"),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Plain Text",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(plainText2 == null ? "" : plainText2),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Encrypted Text",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(cryptedText2 == null
                                    ? ""
                                    : cryptedText2 is encrypt.Encrypted
                                        ? cryptedText2.base64
                                        : cryptedText2),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  plainText2 = crypController2.text;
                                  setState(() {
                                    cryptedText2 =
                                        MyEncryptionDecryption.encryptFernet(
                                            plainText2);
                                  });
                                },
                                child: Text('Encrypt'),
                              ),
                              SizedBox(width: 10),
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    cryptedText2 =
                                        MyEncryptionDecryption.decryptFernet(
                                            cryptedText2);
                                  });
                                },
                                child: Text('Decrypt'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Card(
                margin: EdgeInsets.all(20),
                elevation: 5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Salsa20-Encryption",
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextField(
                              controller: crypController3,
                              decoration:
                                  InputDecoration(labelText: "Enter text"),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Plain Text",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(plainText3 == null ? "" : plainText3),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Encrypted Text",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(cryptedText3 == null
                                    ? ""
                                    : cryptedText3 is encrypt.Encrypted
                                        ? cryptedText3.base64
                                        : cryptedText3),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  plainText3 = crypController3.text;
                                  setState(() {
                                    cryptedText3 =
                                        MyEncryptionDecryption.encryptSalsa20(
                                            plainText3);
                                  });
                                },
                                child: Text('Encrypt'),
                              ),
                              SizedBox(width: 10),
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    cryptedText3 =
                                        MyEncryptionDecryption.decryptSalsa20(
                                            cryptedText3);
                                  });
                                },
                                child: Text('Decrypt'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
