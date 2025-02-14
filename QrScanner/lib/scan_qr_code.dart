import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String _qr_Data = "Qr code data will appear here...";

  Future<void> ScanQr() async{
    final qrCode = await FlutterBarcodeScanner.scanBarcode('Colors.black','Cancel',true,ScanMode.QR);
    if(!mounted)
      return;
    setState(() {

      _qr_Data = qrCode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
        centerTitle: true,
      ),
      body: Center(
       child: Column(
         children: [
           SizedBox(height: 30,),
           Text(_qr_Data,style: TextStyle(color: Colors.orange),),
           SizedBox(height: 30,),
           ElevatedButton(onPressed: (){

           }, child: Text('Scan QR code')),
         ],
       ),
      ),
    );
  }
}
