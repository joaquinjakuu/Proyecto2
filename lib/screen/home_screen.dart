import 'package:flutter/material.dart';
import 'package:myapp/screen/configuracionuser_screen.dart';
import 'package:myapp/screen/infoapp_screen.dart';
import 'package:myapp/screen/login_screen.dart';
import 'codigoqr_screen.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> datosMedicos = [
      {'label': 'Nombre', 'value': 'Juan'},
      {'label': 'Apellido', 'value': 'Pérez'},
      {'label': 'Teléfono', 'value': '123-456-7890'},
      {'label': 'Género', 'value': 'Masculino'},
      {'label': 'Fecha de Nacimiento', 'value': '01/01/1990'},
      {'label': 'Enfermedades', 'value': 'Hipertensión'},
      {'label': 'Síntomas', 'value': 'Malestar'},
      {'label': 'Tipo de Sangre', 'value': 'A+'},
      {'label': 'Tratamiento', 'value': 'Terapia'},
      {'label': 'Medicación', 'value': 'Ibuprofeno'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos Médicos y Personales'),
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
                context.pushNamed(ConfiguracionUser.name);
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Código QR'),
              onTap: () {
                context.pushNamed(CodigoQrScreen.name);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Información de la app'),
              onTap: () {
                context.pushNamed(InfoAppScreen.name);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Mi cuenta'),
              onTap: () {
                Navigator.pop(context); // Regresa a la pantalla actual
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
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            ...datosMedicos.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> data = entry.value;
              Color fondoColor = (index % 2 == 0) ? Colors.white : Colors.grey[200]!;

              return Container(
                padding: const EdgeInsets.all(16.0),
                color: fondoColor,
                child: Text(
                  '${data['label']}: ${data['value']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
