import 'package:flutter/material.dart';
import 'package:myapp/screen/homedoc_screen.dart';
import 'package:myapp/screen/infoappdoc_screen.dart';
import 'package:myapp/screen/login_screen.dart';

class ConfiguracionDoc extends StatefulWidget {
  static const name = 'ConfiguracionDoc';

  @override
  _ConfiguracionDocState createState() => _ConfiguracionDocState();
}

class _ConfiguracionDocState extends State<ConfiguracionDoc> {
  final TextEditingController nombreUsuarioController = TextEditingController(text: 'juan123');
  final TextEditingController nombreController = TextEditingController(text: 'Juan');
  final TextEditingController apellidoController = TextEditingController(text: 'Pérez');
  final TextEditingController correoController = TextEditingController(text: 'juan@example.com');
  final TextEditingController telefonoController = TextEditingController(text: '123-456-7890');
  final TextEditingController contrasenaController = TextEditingController(text: '********');
    final TextEditingController matriculaController = TextEditingController(text: '12345678');


  bool isEditingNombreUsuario = false;
  bool isEditingNombre = false;
  bool isEditingApellido = false;
  bool isEditingCorreo = false;
  bool isEditingTelefono = false;
  bool isEditingContrasena = false;
    bool isEditingMatricula = false;


  String selectedGenero = 'Masculino';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Usuario'),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEditableField(
              label: 'Nombre de Usuario',
              controller: nombreUsuarioController,
              isEditing: isEditingNombreUsuario,
              onEditPressed: () {
                setState(() {
                  isEditingNombreUsuario = !isEditingNombreUsuario;
                });
              },
            ),
            SizedBox(height: 10),
            _buildEditableField(
              label: 'Nombre',
              controller: nombreController,
              isEditing: isEditingNombre,
              onEditPressed: () {
                setState(() {
                  isEditingNombre = !isEditingNombre;
                });
              },
            ),
            SizedBox(height: 10),
            _buildEditableField(
              label: 'Apellido',
              controller: apellidoController,
              isEditing: isEditingApellido,
              onEditPressed: () {
                setState(() {
                  isEditingApellido = !isEditingApellido;
                });
              },
            ),
            SizedBox(height: 10),
            _buildEditableField(
              label: 'Correo Electrónico',
              controller: correoController,
              isEditing: isEditingCorreo,
              onEditPressed: () {
                setState(() {
                  isEditingCorreo = !isEditingCorreo;
                });
              },
            ),
            SizedBox(height: 10),
            _buildEditableField(
              label: 'Teléfono',
              controller: telefonoController,
              isEditing: isEditingTelefono,
              onEditPressed: () {
                setState(() {
                  isEditingTelefono = !isEditingTelefono;
                });
              },
            ),
            _buildEditableField(
              label: 'Matricula',
              controller: matriculaController,
              isEditing: isEditingMatricula,
              onEditPressed: () {
                setState(() {
                  isEditingMatricula = !isEditingMatricula;
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Género',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: selectedGenero,
                        items: <String>['Masculino', 'Femenino', 'No binario', 'Otro']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedGenero = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            _buildEditableField(
              label: 'Contraseña',
              controller: contrasenaController,
              isEditing: isEditingContrasena,
              onEditPressed: () {
                setState(() {
                  isEditingContrasena = !isEditingContrasena;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEditPressed,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                controller: controller,
                enabled: isEditing,
                decoration: InputDecoration(
                  hintText: label,
                  border: isEditing ? OutlineInputBorder() : InputBorder.none,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: onEditPressed,
          child: Text(
            isEditing ? 'Guardar' : 'Editar',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
