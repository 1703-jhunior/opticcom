import 'package:flutter/material.dart';
import 'package:opticcom/models/digi_model.dart';
import 'package:opticcom/services/digi_service.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  final DigiService _digiService = DigiService();
  Future<List<DigiModel>>? _historialList;

  @override
  void initState() {
    super.initState();
    _historialList = _digiService.getDigimons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Mi perfil", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SECCIÓN PERFIL: ROY OCAÑO CON TU IMAGEN ---
              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFFF5F5F5),
                    // AQUÍ ESTÁ TU IMAGEN DE FLATICON
                    backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/1198/1198293.png'),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Roy Ocaño", 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Técnico", 
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // --- SECCIÓN ESTADÍSTICAS ---
              const Text("Estadísticas", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text("Trabajo completado", 
                style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Total", style: TextStyle(color: Colors.grey)),
                    Text("25", 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- FILTRAR POR MES ---
              const Text("Filtrar por mes", 
                style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ["Enero", "Febrero", "Marzo", "Abril", "Mayo"]
                      .map((mes) => Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: ActionChip(
                              label: Text(mes),
                              onPressed: () {},
                              backgroundColor: const Color(0xFFF2F2F2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 25),

              // --- LISTA DE TRABAJOS (ESTILO IMAGEN) ---
              const Text("Historial de trabajo", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              FutureBuilder<List<DigiModel>>(
                future: _historialList,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  final lista = snapshot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lista.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = lista[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF2ECC71), // Verde del check
                            shape: BoxShape.circle),
                          child: const Icon(Icons.check, 
                            color: Colors.white, size: 16),
                        ),
                        title: Text("Orden  #${item.id}", 
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          "Completado el 2026-09-15\n${item.tipo}"),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 30),

              // --- BOTÓN SALIR ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Salir", 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}