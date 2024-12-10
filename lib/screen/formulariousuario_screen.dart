import 'package:flutter/material.dart';
import 'package:myapp/entities/fichamedica.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/screen/login_screen.dart';

class FormularioScreen extends StatefulWidget {
  static const name = 'FormularioScreen';

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  // Controladores para los campos de texto
  TextEditingController sintomasController = TextEditingController();
  TextEditingController tratamientoController = TextEditingController();
  TextEditingController medicacionController = TextEditingController();
  
  // Lista de enfermedades comunes
  final List<String> enfermedades = [
    'Diabetes', 'Hipertensión', 'Cáncer', 'Enfermedad de corazón', 'Asma', 
    'Alergias', 'Artritis', 'Enfermedad renal', 'Migrañas', 'Enfermedad pulmonar',
    'Osteoporosis', 'Depresión', 'Enfermedad de la tiroides', 'Gastritis', 'Enfermedad hepática',
    'VIH/SIDA', 'Alzheimer', 'Parkinson', 'Anemia', 'Epilepsia', 'Otro'
  ];

  // Lista de tipos de sangre
  final List<String> tiposSangre = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  
  String? selectedTipoSangre; // Variable para almacenar el tipo de sangre seleccionado
  List<Map<String, dynamic>> enfermedadesSeleccionadas = []; // Lista para almacenar las enfermedades seleccionadas
  
  // Función para agregar una nueva enfermedad
  void _addEnfermedad() {
    setState(() {
      enfermedadesSeleccionadas.add({'enfermedad': null, 'controladorOtro': TextEditingController()});
    });
  }

  @override
  void initState() {
    super.initState();
    _addEnfermedad(); // Añadir la primera enfermedad por defecto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Salud'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lista dinámica de enfermedades seleccionadas
            ...enfermedadesSeleccionadas.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> enfermedadData = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: enfermedadData['enfermedad'],
                    items: enfermedades.map((String enfermedad) {
                      return DropdownMenuItem<String>(
                        value: enfermedad,
                        child: Text(enfermedad),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        enfermedadesSeleccionadas[index]['enfermedad'] = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enfermedad que padece',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  if (enfermedadData['enfermedad'] == 'Otro')
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        controller: enfermedadData['controladorOtro'],
                        decoration: const InputDecoration(
                          labelText: 'Especifique otra enfermedad',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                ],
              );
            }).toList(),
            
            // Botón para agregar otra enfermedad
            GestureDetector(
              onTap: _addEnfermedad,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.add, color: Colors.blue),
                  SizedBox(width: 4),
                  Text('Agregar otra enfermedad', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Campo para los síntomas
            TextField(
              controller: sintomasController,
              decoration: const InputDecoration(
                labelText: 'Síntomas',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Campo para seleccionar el tipo de sangre
            DropdownButtonFormField<String>(
              value: selectedTipoSangre,
              items: tiposSangre.map((String tipo) {
                return DropdownMenuItem<String>(
                  value: tipo,
                  child: Text(tipo),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTipoSangre = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Tipo de sangre',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Campo para el tratamiento
            TextField(
              controller: tratamientoController,
              decoration: const InputDecoration(
                labelText: '¿Cómo lo tratas?',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Campo para la medicación
            TextField(
              controller: medicacionController,
              decoration: const InputDecoration(
                labelText: '¿Qué medicación utilizas?',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Botón para enviar el formulario
            ElevatedButton(
              onPressed: () {
                // Validar que todos los campos requeridos estén completos
                if (sintomasController.text.isEmpty || tratamientoController.text.isEmpty ||
                    medicacionController.text.isEmpty || selectedTipoSangre == null || 
                    enfermedadesSeleccionadas.any((element) => element['enfermedad'] == null)) {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, completa todos los campos')),
                  );
                } else {
                  // Crear la ficha médica
                  Fichamedica ficha = Fichamedica(
                    sintomas: sintomasController.text,
                    tratamiento: tratamientoController.text,
                    medicacion: medicacionController.text,
                    tiposSangre: selectedTipoSangre!,
                    enfermedadesSeleccionadas: enfermedadesSeleccionadas
                        .map((e) => e['enfermedad'] == 'Otro' ? e['controladorOtro'].text : e['enfermedad'])
                        .join(', '),
                  );
                  context.goNamed(LoginScreen.name);
                  // Aquí puedes implementar la lógica para guardar en la base de datos o continuar a otra pantalla
                }
              },
              
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
