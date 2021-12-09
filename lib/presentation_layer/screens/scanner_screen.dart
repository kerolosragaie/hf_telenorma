import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBarPro(
        addBackButton: true,
        actions: [
          //TODO: add functionallty here:
          IconButton(
            iconSize: 24,
            icon: Icon(
              Icons.e_mobiledata,
              color: HexColor("424D51"),
            ),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 24,
            icon: Icon(
              Icons.check,
              color: HexColor("424D51"),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderColor: HexColor("5E5E5F"),
                borderWidth: 8,
              ),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          //TODO: + and - buttons with card view data:
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleIconButton(
                          buttonColor: Colors.green,
                          iconButton: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleIconButton(
                          buttonColor: Colors.red,
                          iconButton: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TODO: create a stless model and view on it:
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const _DataViewer(),
                  ),
                ],
              ),
            ),
          ),
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

class _DataViewer extends StatelessWidget {
  const _DataViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "1100142: Yaprak",
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "Price: 10.00",
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          "HF: 0",
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          "Menge: 3",
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
