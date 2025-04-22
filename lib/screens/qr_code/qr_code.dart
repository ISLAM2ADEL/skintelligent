import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skintelligent/commons.dart';

class Qrcode extends StatefulWidget {
  const Qrcode({Key? key}) : super(key: key);
  static const String id = 'Qrcode';

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  String? _scanQrcodeRes;
  // final MobileScannerController _scannerController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Camera permission is required for scanning')),
      );
    }
  }

  void _onDetect(BarcodeCapture barcodeCapture) {
    final String? code = barcodeCapture.barcodes.first.rawValue;
    if (code != null && code != _scanQrcodeRes) {
      setState(() {
        _scanQrcodeRes = code;
      });

      Future.delayed(const Duration(seconds: 1), () async {
        String? temp = barcodeCapture.barcodes.first.rawValue;
        temp = _scanQrcodeRes;
        setState(() {
          _scanQrcodeRes = null;
        });

        await Navigator.pushReplacementNamed(context, ProfileScreen.id,
            arguments: temp);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            onDetect: _onDetect,
          ),
          const CustomScannerView(),
          if (_scanQrcodeRes != null)
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.black87,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Scan Result:\n",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: _scanQrcodeRes!,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.greenAccent),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
