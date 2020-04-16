import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:qrscan/qrscan.dart' as scanner;

class QrCodeScanner{

  Uint8List bytes = Uint8List(0);
  String barcode;

  Future scan() async => barcode = await scanner.scan();

  Future scanPhoto() async => barcode = await scanner.scanPhoto();

  Future scanPath(String path) async => barcode = await scanner.scanPath(path);


}




