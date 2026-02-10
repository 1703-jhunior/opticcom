import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Asegúrate de que este nombre 'opticcom' sea el que pusiste en tu pubspec.yaml
import 'package:opticcom/services/person_service.dart'; 

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  // CORREGIDO: Usamos 'final' y no 'nal'
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // CORREGIDO: Controladores con 'final'
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // CORREGIDO: Instancia del servicio con nombre correcto
  final PersonService _personService = PersonService();
  bool _isLoading = false; 

  // Lógica de guardado basada en tu captura de pantalla
  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() => _isLoading = true);
      
      try {
        // Llamada al servicio según tu imagen de código
        dynamic dataLogin = await _personService.save(
          _nombreController.text, 
          _emailController.text
        );

        if (dataLogin["login"] == true) {
          print("Loding valido");
          if (mounted) context.go('/notificaciones');
        } else {
          print("Loding invalido");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error en las credenciales")),
          );
        }
      } catch (e) {
        print("Error: $e");
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      print("Formulario inválido");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9839), // El naranja de tu diseño
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Imagen del trabajador de tu archivo image_a2dfa6.png
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/1198/1198293.png'),
                ),
                const SizedBox(height: 20),
                const Text("OPTICCOM S.A.C", 
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF8B1D1D))),
                const SizedBox(height: 30),

                // Inputs
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    hintText: "Nombre", 
                    fillColor: Colors.white, 
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  validator: (value) => value!.isEmpty ? "Ingrese nombre" : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email", 
                    fillColor: Colors.white, 
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  validator: (value) => value!.isEmpty ? "Ingrese email" : null,
                ),
                const SizedBox(height: 30),

                // Botón Registrar
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: _isLoading ? null : _handleRegister,
                    child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("REGISTRAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}