import 'dart:async';
import 'package:qrscan/qrscan.dart' as scanner;

class QrCodeScanner{

  String barcode;

  Future scan() async => barcode = await scanner.scan();

  Future scanPhoto() async => barcode = await scanner.scanPhoto();

  Future scanPath(String path) async => barcode = await scanner.scanPath(path);


}




