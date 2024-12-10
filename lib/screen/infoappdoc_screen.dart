import 'package:flutter/material.dart';
import 'package:myapp/screen/configdoc_screen.dart';
import 'package:myapp/screen/homedoc_screen.dart';
import 'package:myapp/screen/login_screen.dart';

class InfoAppDocScreen extends StatelessWidget {
  static const name = 'InfoAppDocScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de la Aplicación'),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información de la Aplicación',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Medifest es una aplicación diseñada para mejorar la asistencia médica en eventos masivos, como recitales, festivales, y otros eventos con gran concentración de público. '
                  'La aplicación facilita la respuesta médica ante emergencias, permitiendo que los profesionales puedan acceder al historial médico de los usuarios de forma rápida y eficaz.\n\n'

                  'En Medifest, tanto los usuarios como los médicos pueden registrarse. Los usuarios deben completar un formulario con sus datos médicos, especificando información relevante como enfermedades previas, síntomas recurrentes, medicación actual y alergias. Esta información, almacenada en la aplicación, es de vital importancia para que el equipo médico conozca el historial médico del usuario y así pueda proceder de manera adecuada durante una emergencia.\n\n'

                  'Los médicos, por su parte, deben verificar sus credenciales para utilizar la app, proporcionando documentación que certifique su doctorado antes de poder iniciar sesión. Esta validación asegura que solo profesionales capacitados tengan acceso a la información médica de los usuarios.\n\n'

                  'Durante los eventos, cada usuario recibe una pulsera con tecnología NFC, la cual contiene un enlace directo a su perfil médico en la app. En caso de que el usuario necesite atención médica, el profesional puede escanear la pulsera para obtener acceso instantáneo a su historial médico, sin necesidad de realizar preguntas en un momento crítico. Esto permite que el equipo de salud actúe con la mayor rapidez posible, basándose en datos médicos certeros y previamente verificados.\n\n'

                  'Además, si el dispositivo del usuario no es compatible con la tecnología NFC, la app cuenta con una opción de generar un código QR, el cual también enlaza directamente al perfil médico del usuario. Este código puede mostrarse en la pantalla de su teléfono y ser escaneado por el médico para acceder a la misma información de salud almacenada en su cuenta.\n\n'

                  'Medifest es una herramienta innovadora que mejora la seguridad y el bienestar de los asistentes a eventos masivos, asegurando que, ante cualquier inconveniente médico, se proporcione atención inmediata y personalizada. Con una interfaz amigable y accesible tanto para usuarios como para profesionales de la salud, Medifest representa un avance significativo en la integración de tecnología en el ámbito de la atención médica en eventos de gran escala.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
