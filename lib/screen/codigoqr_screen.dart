import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/user_provider.dart'; // Asegúrate de importar el provider

class CodigoQrScreen extends StatefulWidget {
  static const name = 'CodigoQrScreen';

  @override
  _CodigoQrScreenState createState() => _CodigoQrScreenState();
}

class _CodigoQrScreenState extends State<CodigoQrScreen> {
  bool isQrGenerated = false;

  @override
  void initState() {
    super.initState();
    // No es necesario obtener el correo aquí si ya lo tenemos en el provider
  }

  void _generateQrCode() {
    setState(() {
      isQrGenerated = true; // Cambia el estado para mostrar el QR
    });
  }

  @override
  Widget build(BuildContext context) {
    // Acceder al usuario desde el Provider
    final user = Provider.of<UserProvider>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Código QR'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              user != null
                  ? 'Bienvenido, ${user.firstName}'
                  : 'Cargando usuario...',
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: user != null ? _generateQrCode : null,
              child: Text(
                'Generar QR',
                style: TextStyle(
                  fontFamily: 'InknutAntiqua',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: isQrGenerated
                    ? QrImageView(
                        data: user?.email ?? 'Error: Correo no disponible',
                        version: QrVersions.auto,
                        size: 200.0,
                      )
                    : Text(
                        'QR generado aquí',
                        style: TextStyle(
                          fontFamily: 'InknutAntiqua',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
