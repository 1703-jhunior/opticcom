import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:opticcom/models/digi_model.dart';
import 'package:opticcom/services/digi_service.dart';

class NotificacionesPage extends StatefulWidget {
  const NotificacionesPage({super.key});

  @override
  State<NotificacionesPage> createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  final DigiService _digiService = DigiService();
  Future<List<DigiModel>>? _digiList;

  @override
  void initState() {
    super.initState();
    _digiList = _digiService.getDigimons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Órdenes de Trabajo", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.blue),
            onPressed: () => context.push('/historial'),
          )
        ],
      ),
      body: FutureBuilder<List<DigiModel>>(
        future: _digiList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final lista = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final item = lista[index]; // Definición de item para evitar error
              final bool esAveria = index % 2 == 0;

              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/790/715/png-transparent-bob-the-builder-bob-the-builder-t-shirt-child-boy-toy-construction-worker-game-child-toddler-thumbnail.png'),
                    ),
                    title: Text(
                      esAveria ? "AVERÍA" : "INSTALACIÓN",
                      style: TextStyle(
                        color: esAveria ? Colors.red : Colors.green, 
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          esAveria ? "Calle Real 123 - No hay internet" : "Av. Huancavelica 456 - Cable roto",
                          style: const TextStyle(color: Colors.black87),
                        ),
                        Text("ID de Orden: ${item.id}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () => context.push('/formulario'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}