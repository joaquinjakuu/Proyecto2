import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screen/registro_screen.dart';
import 'package:myapp/screen/registrodoctor_screen.dart';

class EligeRol extends StatefulWidget {
  static const name = 'EligeRol';

  @override
  _EligeRolState createState() => _EligeRolState();
}

class _EligeRolState extends State<EligeRol> {
  String? selectedRole;
  bool isButtonEnabled = false;

  final List<String> roles = ['Usuario', 'Doctor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '¡Bienvenido!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 200),
            const Text(
              '¿Qué rol vas a cumplir en la aplicación?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: selectedRole,
              items: roles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole = newValue;
                  isButtonEnabled = selectedRole != null;
                });
              },
              hint: const Text('Selecciona un rol'),
            ),
            const SizedBox(height: 200),
            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                      if (selectedRole == 'Usuario') {
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
                      } else if (selectedRole == 'Doctor') {
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterDocScreen()),
            );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonEnabled ? Colors.blue : Colors.grey,
              ),
              child: const Text(
                'Confirmar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
