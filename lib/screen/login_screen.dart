import 'package:flutter/material.dart';
import 'package:myapp/entities/user.dart';
import 'package:myapp/screen/eligerol_screen.dart';
import 'package:myapp/screen/home_screen.dart';
import 'package:myapp/screen/homedoc_screen.dart';

class LoginScreen extends StatefulWidget {
  static const name = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false; // Estado del botón
  bool isUsernameValid = true; // Estado del campo de usuario
  bool isPasswordValid = true; // Estado del campo de contraseña

  // Lista simulada de usuarios registrados
  final List<User> registeredUsers = [
    User(
      username: 'usuario1',
      password: 'contraseña1',
      firstName: 'Juan',
      lastName: 'Pérez',
      email: 'juan@example.com',
      phone: '+34123456789',
      gender: 'Masculino',
      birthDate: DateTime(1990, 5, 23),
    ),
    // Simulación del médico registrado
    User(
      username: 'doctor1',
      password: 'doctorpass',
      firstName: 'Ana',
      lastName: 'López',
      email: 'ana@example.com',
      phone: '+34987654321',
      gender: 'Femenino',
      birthDate: DateTime(1985, 3, 14),
      isDoctor: true, // Indicador de rol médico
    ),
  ];

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isButtonEnabled = usernameController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  // Función para validar el login
  void _loginUser() {
    String enteredUsername = usernameController.text;
    String enteredPassword = passwordController.text;

    User? foundUser;
    try {
      foundUser = registeredUsers.firstWhere(
        (user) => user.username == enteredUsername && user.password == enteredPassword,
      );
    } catch (e) {
      foundUser = null; // Usuario no encontrado
    }

    setState(() {
      if (foundUser != null) {
        isUsernameValid = true;
        isPasswordValid = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('¡Bienvenido, ${foundUser.firstName}!')),
        );

        // Redirige según el tipo de usuario
        if (foundUser.isDoctor == true) {
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeDocScreen()),
                );
        } else {
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
        }
      } else {
        isUsernameValid = false;
        isPasswordValid = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nombre de usuario o contraseña incorrectos')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Iniciar sesión',
              style: TextStyle(fontFamily: 'InknutAntiqua', fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 66),
            // Campo de texto del nombre de usuario con sombreado y fondo blanco
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Fondo blanco del recuadro
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(4), // Bordes redondeados (opcional)
              ),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  labelStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: isUsernameValid ? Colors.black : Colors.red,
                    fontWeight: isUsernameValid ? FontWeight.normal : FontWeight.bold, // Más grueso si es incorrecto
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // Sin borde visible, para que se vea el contorno del Container
                  ),
                ),
              ),
            ),
            const SizedBox(height: 29),
            // Campo de texto de la contraseña con sombreado y fondo blanco
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Fondo blanco del recuadro
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(4), // Bordes redondeados (opcional)
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true, // Ocultar el texto para la contraseña
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: isPasswordValid ? Colors.black : Colors.red,
                    fontWeight: isPasswordValid ? FontWeight.normal : FontWeight.bold, // Más grueso si es incorrecto
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // Sin borde visible, para que se vea el contorno del Container
                  ),
                ),
              ),
            ),
            const SizedBox(height: 65),
            // Botón de ingresar con texto blanco
            ElevatedButton(
              onPressed: isButtonEnabled ? _loginUser : null, // Botón habilitado solo si los campos no están vacíos
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonEnabled ? Colors.blue[800] : Colors.grey, // Un tono más oscuro de azul
              ),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.white), // Texto blanco en el botón
              ),
            ),
            const SizedBox(height: 29),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EligeRol()),
                );
              },
              child: const Text('¿No tienes una cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
