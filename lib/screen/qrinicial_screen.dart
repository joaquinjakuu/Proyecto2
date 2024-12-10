import 'package:flutter/material.dart';
import 'package:myapp/screen/login_screen.dart';
import 'package:myapp/utils/global_state.dart'; // Importa el archivo global_state.dart

class QrInicialScreen extends StatelessWidget {
  static const name = 'QrInicialScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/codigoqr.png', // QR generado
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Historial clínico del usuario', // Descripción bajo el QR
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Saltar al login'),
            ),
          ],
        ),
      ),
    );
  }
}
