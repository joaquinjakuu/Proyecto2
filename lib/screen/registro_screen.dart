import 'package:flutter/material.dart';
import 'package:myapp/entities/user.dart';
import 'package:myapp/screen/formulariousuario_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const name = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  String? selectedGender;
  String? selectedCountryCode;

  final List<String> genders = ['Masculino', 'Femenino', 'No binario', 'Otro'];
  final List<String> countryCodes = ['+54', '+1', '+44', '+91', '+34'];

  bool usernameError = false;
  bool firstNameError = false;
  bool lastNameError = false;
  bool emailError = false;
  bool phoneError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;
  bool birthDateError = false;
  bool genderError = false;
  bool countryCodeError = false;

 String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
  
  bool _validateUsername(String username) {
    final usernamePattern = RegExp(r'^[a-z]{1,30}$');
    return usernamePattern.hasMatch(username);
  }

  bool _validateName(String name) {
    final namePattern = RegExp(r'^[a-zA-Z\s]{1,30}$');
    return namePattern.hasMatch(name) && name.trim().split(' ').length <= 3;
  }

  bool _validateEmail(String email) {
    final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com|outlook\.com|yahoo\.com)$');
    return emailPattern.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    return RegExp(r'^[0-9]{1,16}$').hasMatch(phone);
  }

  bool _validatePassword(String password) {
    return password.length >= 8;
  }

  void _registerUser() {
    setState(() {
      usernameError = !_validateUsername(usernameController.text);
      firstNameError = !_validateName(firstNameController.text);
      lastNameError = !_validateName(lastNameController.text);
      emailError = !_validateEmail(emailController.text);
      phoneError = !_validatePhone(phoneController.text);
      passwordError = !_validatePassword(passwordController.text);
      confirmPasswordError = passwordController.text != confirmPasswordController.text;
      birthDateError = birthDateController.text.isEmpty;
      genderError = selectedGender == null;
      countryCodeError = selectedCountryCode == null;
    });

    bool hasError = usernameError ||
                    firstNameError ||
                    lastNameError ||
                    emailError ||
                    phoneError ||
                    passwordError ||
                    confirmPasswordError ||
                    birthDateError ||
                    genderError ||
                    countryCodeError;

    if (hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos correctamente')),
      );
      return;
    }

    DateTime? birthDate = DateTime.tryParse(
      birthDateController.text.split('/').reversed.join('-'),
    );

    User newUser = User(
      username: usernameController.text,
      password: passwordController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phone: '$selectedCountryCode${phoneController.text}',
      gender: selectedGender!,
      birthDate: birthDate!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormularioScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Crear cuenta',
              style: TextStyle(fontFamily: 'InknutAntiqua', fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildTextField(usernameController, 'Nombre de usuario', usernameError, 'Debe ser sin espacios, minúsculas y sin números'),
            const SizedBox(height: 10),
            _buildTextField(firstNameController, 'Nombre', firstNameError, 'Solo letras y hasta 30 caracteres'),
            const SizedBox(height: 10),
            _buildTextField(lastNameController, 'Apellido', lastNameError, 'Solo letras y hasta 30 caracteres'),
            const SizedBox(height: 10),
            _buildDropdown('Género', selectedGender, genders, (String? newValue) {
              setState(() {
                selectedGender = newValue;
              });
            }, genderError),
            const SizedBox(height: 10),
            _buildTextField(emailController, 'Correo Electrónico', emailError, 'Debe terminar en gmail.com, hotmail.com, outlook.com o yahoo.com'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildDropdown('Código', selectedCountryCode, countryCodes, (String? newValue) {
                    setState(() {
                      selectedCountryCode = newValue;
                    });
                  }, countryCodeError),
                ),
                const SizedBox(width: 10),
                Expanded(flex: 5, child: _buildTextField(phoneController, 'Celular', phoneError, 'Solo números, hasta 16')),
              ],
            ),
            const SizedBox(height: 10),
           _buildDateField(birthDateController, 'Fecha de Nacimiento (dd/mm/aaaa)', birthDateError),
            const SizedBox(height: 10),
            _buildTextField(passwordController, 'Contraseña', passwordError, 'Mínimo 8 caracteres', obscureText: true),
            const SizedBox(height: 10),
            _buildTextField(confirmPasswordController, 'Confirmar Contraseña', confirmPasswordError, 'Las contraseñas deben coincidir', obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool hasError, String errorMessage, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        errorText: hasError ? errorMessage : null,
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items, ValueChanged<String?> onChanged, bool hasError) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        errorText: hasError ? 'Seleccione una opción' : null,
      ),
    );
  }
  Widget _buildDateField(TextEditingController controller, String label, bool hasError) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        errorText: hasError ? 'Este campo es obligatorio' : null,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
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
            controller.text = formatDate(pickedDate);
          });
        }
      },
    );
  }
}
