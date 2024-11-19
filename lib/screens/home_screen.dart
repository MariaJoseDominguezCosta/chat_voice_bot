import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Practice ChatBot'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de Universidad (placeholder)
              const FlutterLogo(size: 120),
              
              const SizedBox(height: 20),
              
              const Text(
                'English Voice ChatBot',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              
              const SizedBox(height: 20),
              
              _buildInfoCard(
                'Carrera: Ingeniería en Software',
                Icons.school
              ),
              
              _buildInfoCard(
                'Materia: Programacion para Moviles II',
                Icons.book
              ),
              
              _buildInfoCard(
                'Grupo: 9B',
                Icons.group
              ),
              
              _buildInfoCard(
                'Nombre: María José Domínguez Costa',
                Icons.person
              ),
              
              _buildInfoCard(
                'Matrícula: 213457',
                Icons.numbers
              ),
              
              const SizedBox(height: 20),
              
              ElevatedButton.icon(
                onPressed: () {
                  // Abrir enlace de repositorio
                },
                icon: const Icon(Icons.link),
                label: const Text('Ver Repositorio GitHub'),
              ),
              
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: () {
                  // Navegar a Chat Screen
                  Navigator.pushNamed(context, '/chat');
                },
                child: const Text('Iniciar Práctica de Inglés'),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoCard(String text, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}