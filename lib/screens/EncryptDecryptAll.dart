import 'package:flutter/material.dart';
import 'package:CryptD/widget/main_Drawer.dart';
import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;

class EncryptDecryptAll extends StatefulWidget {
  static const routeName = '/Encryptall';
  @override
  _EncryptDecryptAllState createState() => _EncryptDecryptAllState();
}

class _EncryptDecryptAllState extends State<EncryptDecryptAll> {
  bool _isGranted = true;
  var plainUrl = "";
  var fileName = "";

  // Directory Creation
  Future<Directory> get getAppDir async {
    //return files that is hidden
    final appDocDir = await getExternalStorageDirectory();
    return appDocDir;
  }

  Future<Directory> get getExternalVisibleDir async {
    //return files that is visible
    if (await Directory('/storage/emulated/0/CryptDFiles').exists()) {
      final externalDir = Directory(
          '/storage/emulated/0/CryptDFiles'); //uses path provider to create a pth and creates a directory if this folder doesn't exist
      return externalDir;
    }
    await Directory('/storage/emulated/0/CryptDFiles').create(recursive: true);
    final externalDir = Directory('/storage/emulated/0/CryptDFiles');
    return externalDir;
  }

  // Ask permission
  requestStoragePermission() async {
    if (!await Permission.storage.isGranted) {
      PermissionStatus result = await Permission.storage.request();
      if (result.isGranted) {
        setState(() {
          _isGranted = true;
        });
      } else {
        _isGranted = false;
      }
    }
  }

  // Controlling input
  final TextEditingController crypController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    requestStoragePermission();
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptD'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 5,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: "Enter the url to file"),
                        controller: crypController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            Directory d;
                            setState(() {
                              plainUrl = crypController.text;
                              fileName = p.basename(plainUrl);
                            });
                            print(fileName);
                            print(plainUrl);
                            FocusScope.of(context).unfocus();
                            if (_isGranted) {
                              d = await getExternalVisibleDir;
                              _downloadAndCreate(plainUrl, d, fileName);
                            } else {
                              print("No permission");
                              requestStoragePermission();
                            }
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Encryption successfull.Check at \n $d/$fileName.aes \n Press Decrypt to retrieve original file \n Press Ok to continue",
                                              style: TextStyle(
                                                fontFamily: 'RobotoCondensed',
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "ok",
                                                style: TextStyle(
                                                  fontFamily: 'RobotoCondensed',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text('Download & Encrypt File'),
                        ),
                        SizedBox(width: 10),
                        RaisedButton(
                          onPressed: () async {
                            Directory d;
                            if (_isGranted) {
                              d = await getExternalVisibleDir;
                              _getNormalFile(d, fileName);
                            } else {
                              print("No permission");
                              requestStoragePermission();
                            }
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Decryption successfull.Check at $d/$fileName \n Press Ok to continue",
                                              style: TextStyle(
                                                fontFamily: 'RobotoCondensed',
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                            RaisedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "ok",
                                                style: TextStyle(
                                                  fontFamily: 'RobotoCondensed',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
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
    );
  }
}

_downloadAndCreate(String url, Directory d, fileName) async {
  if (await canLaunch(url)) {
    print("Data downloading");
    var resp = await http.get(url);
    var encResult = _encryptData(resp.bodyBytes);
    String pathData = await _writeData(encResult, d.path + '/$fileName.aes');
    print("file encrypted successfully $pathData");
  } else {
    print("Can't launch Url");
  }
}

_getNormalFile(Directory d, fileName) async {
  Uint8List encData = await _readData(d.path + '/$fileName.aes');
  var plainData = await _decryptData(encData);
  String pathData = await _writeData(plainData, d.path + '/$fileName');
  print("file decrypted sucessfully: $pathData");
}

_encryptData(plainString) {
  print("Encrypting file..");
  final encrypted =
      MyEncrypt.myencrypter.encryptBytes(plainString, iv: MyEncrypt.iv);
  return encrypted.bytes;
}

_decryptData(encData) {
  print("Decrypting file..");
  enc.Encrypted en = new enc.Encrypted(encData);
  final decrypted = MyEncrypt.myencrypter.decryptBytes(en, iv: MyEncrypt.iv);
  return decrypted;
}

Future<String> _writeData(dataToWrite, fileNamewithPath) async {
  print("Writing Data");
  io.File f = io.File(fileNamewithPath);
  await f.writeAsBytes(dataToWrite);
  return f.absolute.toString();
}

Future<Uint8List> _readData(fileNamewithPath) async {
  print("Reading Data");
  io.File f = io.File(fileNamewithPath);
  return await f.readAsBytes();
}

class MyEncrypt {
  static final myKey = enc.Key.fromUtf8("@hekNhR^@hekNhR^@hekNhR^@hekNhR^");
  static final iv = enc.IV.fromLength(16);
  static final myencrypter = enc.Encrypter(enc.AES(myKey));
}
