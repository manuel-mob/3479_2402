class Feriado {
  String nombre;
  String? comentarios;
  DateTime fecha;
  bool irrenunciable;
  String tipo;

  Feriado({
    required this.nombre,
    this.comentarios,
    required this.fecha,
    required this.irrenunciable,
    required this.tipo,
  });

  factory Feriado.fromJson(Map<String, dynamic> json) {
    return Feriado(
      nombre: json['nombre'],
      comentarios: json['comentarios'],
      fecha: DateTime.parse(json['fecha']),
      irrenunciable: json['irrenunciable'] == '1',
      tipo: json['tipo'],
    );
  }
}