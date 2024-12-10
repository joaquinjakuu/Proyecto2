import 'package:flutter/material.dart';
import 'package:myapp/entities/userdoc.dart';
import 'package:myapp/screen/esperadoc_screen.dart';

class RegisterDocScreen extends StatefulWidget {
  static const name = 'RegisterDocScreen';

  @override
  _RegisterDocScreenState createState() => _RegisterDocScreenState();
}

class _RegisterDocScreenState extends State<RegisterDocScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController matriculaController = TextEditingController();

  String? selectedGender;
  String? selectedCountryCode;
  final List<String> genders = ['Masculino', 'Femenino', 'No binario', 'Otro'];
  final List<String> countryCodes = ['+54', '+1', '+44', '+91', '+34'];

  bool _isUsernameValid = true;
  bool _isFirstNameValid = true;
  bool _isLastNameValid = true;
  bool _isEmailValid = true;
  bool _isPhoneValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isMatriculaValid = true;
  bool _isBirthDateValid = true;

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  bool validateFields() {
    setState(() {
      _isUsernameValid = usernameController.text.isNotEmpty &&
          RegExp(r'^[a-z]+$').hasMatch(usernameController.text);

      _isFirstNameValid = firstNameController.text.isNotEmpty &&
          RegExp(r'^[a-zA-Z\s]{1,30}$').hasMatch(firstNameController.text);

      _isLastNameValid = lastNameController.text.isNotEmpty &&
          RegExp(r'^[a-zA-Z\s]{1,30}$').hasMatch(lastNameController.text);

      _isEmailValid = emailController.text.isNotEmpty &&
          (emailController.text.endsWith('@gmail.com') ||
              emailController.text.endsWith('@hotmail.com') ||
              emailController.text.endsWith('@yahoo.com') ||
              emailController.text.endsWith('@outlook.com'));

      _isPhoneValid = phoneController.text.isNotEmpty &&
          RegExp(r'^\d{1,16}$').hasMatch(phoneController.text);

      _isPasswordValid = passwordController.text.isNotEmpty &&
          passwordController.text.length >= 8;

      _isConfirmPasswordValid = confirmPasswordController.text == passwordController.text;

      _isMatriculaValid = matriculaController.text.isNotEmpty &&
          RegExp(r'^\d{1,10}$').hasMatch(matriculaController.text);

      _isBirthDateValid = birthDateController.text.isNotEmpty;
    });

    return _isUsernameValid &&
        _isFirstNameValid &&
        _isLastNameValid &&
        _isEmailValid &&
        _isPhoneValid &&
        _isPasswordValid &&
        _isConfirmPasswordValid &&
        _isMatriculaValid &&
        _isBirthDateValid;
  }

  void _registerUserDoc() {
    if (validateFields()) {
      // Si todos los campos son válidos, crea el objeto Userdoc y navega
      DateTime? birthDate = DateTime.tryParse(
        birthDateController.text.split('/').reversed.join('-'),
      );

      Userdoc newUserDoc = Userdoc(
        username: usernameController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: '$selectedCountryCode${phoneController.text}',
        gender: selectedGender!,
        matricula: matriculaController.text,
        birthDate: birthDate!,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EsperaDocScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Crear cuenta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
                border: OutlineInputBorder(),
                errorText: _isUsernameValid ? null : 'Obligatorio. Solo minúsculas sin espacios ni números',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
                errorText: _isFirstNameValid ? null : 'Obligatorio. Solo letras, máx 30 caracteres',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
                errorText: _isLastNameValid ? null : 'Obligatorio. Solo letras, máx 30 caracteres',
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedGender,
              items: genders.map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Género',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento (dd/mm/aaaa)',
                border: OutlineInputBorder(),
                errorText: _isBirthDateValid ? null : 'Campo obligatorio',
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    birthDateController.text = formatDate(pickedDate);
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
                errorText: _isEmailValid ? null : 'Obligatorio. Debe ser un correo válido',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: selectedCountryCode,
                    items: countryCodes.map((String code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountryCode = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Código',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Celular',
                      border: OutlineInputBorder(),
                      errorText: _isPhoneValid ? null : 'Obligatorio. Solo números, máx 16 dígitos',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: matriculaController,
              decoration: InputDecoration(
                labelText: 'Número de Matrícula',
                border: OutlineInputBorder(),
                errorText: _isMatriculaValid ? null : 'Obligatorio. Solo números, máx 10 dígitos',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                errorText: _isPasswordValid ? null : 'Obligatorio. Mínimo 8 caracteres',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                border: OutlineInputBorder(),
                errorText: _isConfirmPasswordValid ? null : 'Las contraseñas no coinciden',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUserDoc,
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
