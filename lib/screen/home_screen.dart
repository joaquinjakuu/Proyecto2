import 'package:flutter/material.dart';
import 'package:myapp/screen/configuracionuser_screen.dart';
import 'package:myapp/screen/infoapp_screen.dart';
import 'package:myapp/screen/login_screen.dart';
import 'codigoqr_screen.dart'; // Asegúrate de importar la pantalla del Código QR

class HomeScreen extends StatelessWidget {
  static const name = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    // Lista de datos estáticos (por ahora)
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
                  MaterialPageRoute(builder: (context) => ConfiguracionUser()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('Código QR'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CodigoQrScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Información de la app'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoAppScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Mi cuenta'),
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
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
                  style: TextStyle(
                    fontFamily: 'InknutAntiqua', 
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
