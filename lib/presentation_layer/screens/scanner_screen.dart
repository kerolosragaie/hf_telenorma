import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPro(
        addBackButton: true,
      ),
      body: BarcodeCamera(
        types: const [BarcodeType.ean8, BarcodeType.ean13, BarcodeType.code128],
        resolution: Resolution.hd720,
        framerate: Framerate.fps30,
        mode: DetectionMode.pauseVideo,
        onScan: (code) {
          print(code);
        },
        children: [
          const MaterialPreviewOverlay(animateDetection: false),
          const BlurPreviewOverlay(),
          Positioned(
            child: ElevatedButton(
              onPressed: () => CameraController.instance.resumeDetector(),
              child: Text('Resume'),
            ),
          )
        ],
      ),
    );
  }
}
