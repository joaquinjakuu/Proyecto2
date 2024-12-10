import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/screen/configdoc_screen.dart';
import 'package:myapp/screen/infoappdoc_screen.dart';
import 'package:myapp/screen/login_screen.dart';
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
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'InknutAntiqua',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfiguracionDoc()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('Código QR'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeDocScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Información de la app'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoAppDocScreen()),
                );
              },
            ),
            
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Escanear QR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 45),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _requestCameraPermission(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Escanear',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Al escanear el código QR, podrás acceder a los datos clínicos del usuario',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
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
        SnackBar(content: Text('Permiso de cámara denegado')),
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
            onDetect: (BarcodeCapture capture) {
              final String? code = capture.barcodes.first.rawValue;
              if (code != null) {
                Navigator.pop(context); // Cierra el escáner después de leer el código
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
