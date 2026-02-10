import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:opticcom/screens/my_home_page.dart';
import 'package:opticcom/screens/registro_page.dart';
import 'package:opticcom/screens/notificaciones_page.dart';
import 'package:opticcom/screens/formulario_page.dart';
import 'package:opticcom/screens/detalles_page.dart';
import 'package:opticcom/screens/historial_page.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MyHomePage(title: 'OpticCom Inicio')),
    GoRoute(path: '/registro', builder: (context, state) => const RegistroPage()),
    GoRoute(path: '/notificaciones', builder: (context, state) => const NotificacionesPage()),
    GoRoute(path: '/formulario', builder: (context, state) => const FormularioPage()),
    GoRoute(path: '/detalles', builder: (context, state) => const DetallesPage()),
    GoRoute(path: '/historial', builder: (context, state) => const HistorialPage()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
    );
  }
}