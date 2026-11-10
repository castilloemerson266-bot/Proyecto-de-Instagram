import 'package:flutter/material.dart';

import '../componentes/componentes_instagram.dart';

// Perfil: muestra información estática, publicaciones y pestañas de contenido.
class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({required this.username, super.key});

  final String username;

  @override
  State<PantallaPerfil> createState() => _EstadoPantallaPerfil();
}

class _EstadoPantallaPerfil extends State<PantallaPerfil> {
  // Índice de la pestaña seleccionada y estado del botón de edición simulado.
  int _selectedTab = 0;
  bool _isEditing = false;

  // Colores e iconos que representan publicaciones estáticas del perfil.
  static const _profilePosts = [
    (Icons.landscape, [Color(0xFF31A8A0), Color(0xFF345B8C)]),
    (Icons.coffee, [Color(0xFFE88B54), Color(0xFF9D3A45)]),
    (Icons.wb_sunny, [Color(0xFFFCAF45), Color(0xFFE1306C)]),
    (Icons.park, [Color(0xFF91B35B), Color(0xFF255B50)]),
    (Icons.palette, [Color(0xFFE75D84), Color(0xFF8A4CAB)]),
    (Icons.music_note, [Color(0xFF5869C8), Color(0xFF42A5A0)]),
  ];

  @override
  Widget build(BuildContext context) {
    // Contenido desplazable del perfil: datos, acciones, pestañas y cuadrícula.
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
          child: Row(
            children: [
              InstagramAvatar(
                name: widget.username,
                radius: 40,
                colors: const [Color(0xFF833AB4), Color(0xFFE1306C)],
              ),
              const SizedBox(width: 28),
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ProfileStat(value: '6', label: 'publicaciones'),
                    _ProfileStat(value: '3.1 mill.', label: 'seguidores'),
                    _ProfileStat(value: '310', label: 'seguidos'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            widget.username,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(18, 3, 18, 12),
          child: Text('Compartiendo momentos ✨, six seven 6🫲🥴🫱7'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.tonal(
                  key: const ValueKey('editProfileButton'),
                  onPressed: () => setState(() => _isEditing = !_isEditing),
                  child: Text(_isEditing ? 'Guardar perfil' : 'Editar perfil'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => showInstagramMessage(
                    context,
                    'Enlace del perfil copiado (simulación).',
                  ),
                  child: const Text('Compartir perfil'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        Row(
          children: [
            _profileTab(Icons.grid_on, 0),
            _profileTab(Icons.video_library_outlined, 1),
            _profileTab(Icons.person_pin_outlined, 2),
          ],
        ),
        if (_selectedTab == 0)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 0.9,
            ),
            itemCount: _profilePosts.length,
            itemBuilder: (context, index) {
              final post = _profilePosts[index];
              return GestureDetector(
                onTap: () => showInstagramMessage(
                  context,
                  'Publicación ${index + 1} de ${widget.username}.',
                ),
                child: InstagramArtwork(icon: post.$1, colors: post.$2),
              );
            },
          )
        else
          Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              children: [
                Icon(
                  _selectedTab == 1
                      ? Icons.video_library_outlined
                      : Icons.person_pin_outlined,
                  size: 38,
                  color: Colors.white54,
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedTab == 1
                      ? 'Aún no hay reels.'
                      : 'Aún no hay fotos en las que apareces.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Pestaña seleccionable para alternar entre publicaciones, reels y menciones.
  Widget _profileTab(IconData icon, int index) {
    final selected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? Colors.white : Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
          child: Icon(icon, color: selected ? Colors.white : Colors.white54),
        ),
      ),
    );
  }
}

// Elemento que muestra una cifra y su descripción en las estadísticas del perfil.
class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
