import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/screen/configdoc_screen.dart';
import 'package:myapp/screen/infoappdoc_screen.dart';
import 'package:myapp/screen/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';


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
                context.pushNamed(ConfiguracionDoc.name);
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
                context.pushNamed(InfoAppDocScreen.name);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                context.pushNamed(LoginScreen.name);
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
