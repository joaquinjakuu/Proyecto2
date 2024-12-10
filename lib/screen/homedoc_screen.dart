import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeDocScreen extends StatelessWidget {
  static const name = 'HomeDocScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio del Médico'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: const Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pushNamed(context, '/configuracion_doc');
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Código QR'),
              onTap: () async {
                await _requestCameraPermission(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Información de la app'),
              onTap: () {
                Navigator.pushNamed(context, '/info_app_doc');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestCameraPermission(BuildContext context) async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      _showScanner(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de cámara denegado')),
      );
    }
  }

  void _showScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Escáner QR"),
        content: SizedBox(
          width: double.infinity,
          height: 300,
          child: MobileScanner(
            onDetect: (barcode) {
              final String? code = barcode.barcodes.first.rawValue;
              if (code != null) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Código QR escaneado: $code')),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
