class Fichamedica {
  final String sintomas; // Requerido
  final String tratamiento; // Requerido
  final String medicacion; // Opcional
  final String tiposSangre; // Opcional
  final String enfermedadesSeleccionadas; // Opcional

  Fichamedica({
    required this.sintomas,
    required this.tratamiento,
    required this.medicacion,
    required this.tiposSangre,
    required this.enfermedadesSeleccionadas,
  });
}
