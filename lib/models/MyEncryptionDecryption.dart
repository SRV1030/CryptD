import 'package:encrypt/encrypt.dart' as encrypt;

class MyEncryptionDecryption {

  // AES Encryption
  static final key = encrypt.Key.fromLength(32);
  static final iv= encrypt.IV.fromLength(16);
  static final encrypter= encrypt.Encrypter(encrypt.AES(key));
  static encryptAES(text){
    final encrypted= encrypter.encrypt(text,iv: iv);
    // print(encrypted.bytes);
    // print(encrypted.base16);
    // print(encrypted.base64);
    return encrypted;
     }
  static decryptAES(text){
    final decrypted= encrypter.decrypt(text,iv: iv);
    return decrypted;
  }

  //Fernet Encryption
  static final keyFernet= encrypt.Key.fromUtf8("@hekNhR^@hekNhR^@hekNhR^@hekNhR^");
  static final fernet= encrypt.Fernet(keyFernet);
  static final encrypterFernet= encrypt.Encrypter(fernet);
  static encryptFernet(text){
    final encrypted= encrypterFernet.encrypt(text);
    // print(encrypted.bytes);
    // print(encrypted.base16);
    // print(encrypted.base64);
    return encrypted;
     }
  static decryptFernet(text){
    final decrypted= encrypterFernet.decrypt(text);
    return decrypted;
  }

  //Salsa20 Encryption
  static final keySalsa20 = encrypt.Key.fromLength(32);
  static final ivSalsa20= encrypt.IV.fromLength(8);
  static final encrypterSalsa20= encrypt.Encrypter(encrypt.Salsa20(keySalsa20));
  static encryptSalsa20(text){
    final encrypted= encrypterSalsa20.encrypt(text,iv: ivSalsa20);
    // print(encrypted.bytes);
    // print(encrypted.base16);
    // print(encrypted.base64);
    return encrypted;
     }
  static decryptSalsa20(text){
    final decrypted= encrypterSalsa20.decrypt(text,iv: ivSalsa20);
    return decrypted;
  }

}