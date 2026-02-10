class DigiModel {
  final int id;
  final String tipo;        // Cambiado de 'name' a 'tipo' (Avería/Instalación)
  final String direccion;   // Cambiado de 'href' a 'direccion'
  final String image;

  DigiModel({
    required this.id,
    required this.tipo,
    required this.direccion,
    required this.image,
  });

  factory DigiModel.fromJson(Map<String, dynamic> json) {
    return DigiModel(
      id: json['id'],
      // Aquí simulamos los datos si la API sigue siendo la de Digimon
      // o mapeamos los campos reales de tu nueva API
      tipo: json['name'] ?? 'AVERÍA', 
      direccion: 'Calle Real 123 - No hay internet', 
      image: 'https://i.pinimg.com/originals/ae/c4/9d/aec49d4722f9d85fd668853686259e84.png', // Imagen de Bob
    );
  }
}