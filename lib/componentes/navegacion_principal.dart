import 'package:flutter/material.dart';

import '../pantallas/pantalla_inicio.dart';
import '../pantallas/pantalla_mensajes.dart';
import '../pantallas/pantalla_perfil.dart';
import 'componentes_instagram.dart';

// Contenedor de las tres secciones disponibles después de iniciar sesión.
class NavegacionPrincipal extends StatefulWidget {
  const NavegacionPrincipal({
    required this.username,
    required this.onLogout,
    super.key,
  });

  final String username;
  final VoidCallback onLogout;

  @override
  State<NavegacionPrincipal> createState() => _EstadoNavegacionPrincipal();
}

class _EstadoNavegacionPrincipal extends State<NavegacionPrincipal> {
  // La opción elegida determina la pantalla visible en la barra inferior.
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // IndexedStack conserva el estado de cada pantalla al cambiar de sección.
    final screens = [
      PantallaInicio(username: widget.username),
      PantallaMensajes(username: widget.username),
      PantallaPerfil(username: widget.username),
    ];

    return Scaffold(
      // La barra superior ofrece acciones relacionadas con la sección actual.
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Instagram' : widget.username,
          style: TextStyle(
            fontSize: _selectedIndex == 0 ? 27 : 20,
            fontWeight: FontWeight.w600,
            letterSpacing: _selectedIndex == 0 ? -1 : 0,
          ),
        ),
        actions: [
          if (_selectedIndex == 0) ...[
            IconButton(
              tooltip: 'Crear publicación',
              onPressed: () => showInstagramMessage(
                context,
                'Crear publicación (simulación).',
              ),
              icon: const Icon(Icons.add_box_outlined),
            ),
            IconButton(
              tooltip: 'Notificaciones',
              onPressed: () => showInstagramMessage(
                context,
                'No tienes notificaciones nuevas.',
              ),
              icon: const Icon(Icons.favorite_border),
            ),
          ] else
            IconButton(
              tooltip: _selectedIndex == 1
                  ? 'Nuevo mensaje'
                  : 'Crear publicación',
              onPressed: () => showInstagramMessage(
                context,
                _selectedIndex == 1
                    ? 'Nuevo mensaje (simulación).'
                    : 'Crear publicación (simulación).',
              ),
              icon: Icon(
                _selectedIndex == 1
                    ? Icons.edit_square
                    : Icons.add_box_outlined,
              ),
            ),
          PopupMenuButton<String>(
            tooltip: 'Opciones de cuenta',
            onSelected: (value) {
              if (value == 'logout') widget.onLogout();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'logout',
                child: Text('Cerrar sesión'),
              ),
            ],
          ),
        ],
      ),
      // Presenta la sección seleccionada y conserva las demás en memoria.
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
      ),
      // Navegación entre inicio, mensajes y perfil.
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        backgroundColor: const Color(0xFF090D12),
        indicatorColor: const Color(0xFF272B30),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.send_outlined),
            selectedIcon: Icon(Icons.send),
            label: 'Mensajes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
