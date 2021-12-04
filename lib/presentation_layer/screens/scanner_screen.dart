import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderColor: HexColor("5E5E5F"),
                borderWidth: 8,
              ),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: HexColor("F89720"),
              child: Center(
                child: (result != null)
                    //TODO: make send sacnned code to api function
                    ? Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          color: HexColor("FFFFFF"),
                        ),
                      )
                    : const Image(
                        height: 65,
                        width: 65,
                        image: AssetImage("assets/icons/scan_button.png"),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
