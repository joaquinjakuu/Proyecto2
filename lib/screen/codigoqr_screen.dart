import 'package:flutter/material.dart';
import 'package:myapp/screen/configuracionuser_screen.dart';
import 'package:myapp/screen/home_screen.dart';
import 'package:myapp/screen/infoapp_screen.dart';
import 'package:myapp/screen/login_screen.dart';
import 'package:myapp/utils/global_state.dart';

class CodigoQrScreen extends StatefulWidget {
  static const name = 'CodigoQrScreen';

  @override
  _CodigoQrScreenState createState() => _CodigoQrScreenState();
}

class _CodigoQrScreenState extends State<CodigoQrScreen> {
  bool isImageVisible = GlobalState.isQrGenerated; // Lee el estado global al iniciar

  void showImage() {
    setState(() {
      isImageVisible = true;
      GlobalState.isQrGenerated = true; // Actualiza la variable global
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Código QR'),
        automaticallyImplyLeading: true,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bienvenido, Juan!',
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            
            ElevatedButton(
              onPressed: showImage,
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
                child: isImageVisible
                    ? Image.asset(
                        'assets/images/codigoqr.png',
                        fit: BoxFit.contain,
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
