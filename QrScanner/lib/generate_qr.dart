import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({super.key});

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  final g_text_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR'),
        centerTitle: true,
      ),
      body: Center(

        child: Column(
          children: [
            if(g_text_controller.text.isNotEmpty)
            QrImageView(
              data: g_text_controller.text,
              version: QrVersions.auto,
              size: 320,
              gapless: false,
            ),
            TextField(
              controller: g_text_controller,
              decoration: InputDecoration(
                hintText: 'Enter text to generate QR code',
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              setState(() {

              });
            }, child: Text('Generate QR code')),
          ],
        ),
      ),
    );
  }
}
