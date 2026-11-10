import 'package:flutter/material.dart';

import '../componentes/componentes_instagram.dart';

// Mensajes: presenta notas y conversaciones con contenido de ejemplo.
class PantallaMensajes extends StatelessWidget {
  const PantallaMensajes({required this.username, super.key});

  final String username;

  // Conversaciones fijas para representar la bandeja de entrada.
  static const _conversations = [
    (
      name: 'TEAM FLORES 🐘🤎',
      preview: '4+ mensajes nuevos · 17 h',
      unread: true,
      colors: [Color(0xFF833AB4), Color(0xFFE1306C)],
    ),
    (
      name: 'Angela Valle C.',
      preview: 'Enviado hace 17 h',
      unread: false,
      colors: [Color(0xFFEF9A3D), Color(0xFFBE405C)],
    ),
    (
      name: 'Roberto Castillo',
      preview: 'Envió un reel · 19 h',
      unread: false,
      colors: [Color(0xFF405DE6), Color(0xFF42A5A0)],
    ),
    (
      name: '❤️🤣watafak 🤣❤️',
      preview: '4+ mensajes nuevos · 20 h',
      unread: true,
      colors: [Color(0xFF31A8A0), Color(0xFF345B8C)],
    ),
    (
      name: 'Ivis Valle',
      preview: '4+ mensajes nuevos · 21 h',
      unread: true,
      colors: [Color(0xFFFCAF45), Color(0xFFE1306C)],
    ),
    (
      name: 'TEAM NENE. 🚀💙',
      preview: '4+ mensajes nuevos · 21 h',
      unread: false,
      colors: [Color(0xFF5869C8), Color(0xFF833AB4)],
    ),
    (
      name: 'rutin_ext',
      preview: 'Enviado ayer',
      unread: false,
      colors: [Color(0xFFE88B54), Color(0xFF9D3A45)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Lista principal con búsqueda, notas rápidas y conversaciones.
    return ListView(
      padding: const EdgeInsets.only(bottom: 12),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: TextField(
            onSubmitted: (query) {
              if (query.trim().isNotEmpty) {
                showInstagramMessage(context, 'Buscando “$query”.');
              }
            },
            decoration: InputDecoration(
              hintText: 'Buscar o preguntar a Meta AI',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFF22262B),
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 154,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            scrollDirection: Axis.horizontal,
            children: [
              _NoteBubble(
                name: username,
                note: 'Deja una nota',
                colors: const [Color(0xFF833AB4), Color(0xFFE1306C)],
                isOwnNote: true,
              ),
              for (final note in [
                ('Osmer Orellana', 'que bárbaros 😂'),
                ('daniel', '🎧 Piénsalo 💚'),
                ('Madelin', '🎧 música nueva'),
              ])
                _NoteBubble(
                  name: note.$1,
                  note: note.$2,
                  colors: const [Color(0xFF405DE6), Color(0xFF833AB4)],
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 8),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Mensajes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              TextButton(
                onPressed: () => showInstagramMessage(
                  context,
                  'Solicitudes de mensajes (simulación).',
                ),
                child: const Text(
                  'Solicitudes',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        // Cada fila indica si hay mensajes sin leer y permite abrir un aviso.
        for (final conversation in _conversations)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leading: InstagramAvatar(
              name: conversation.name,
              radius: 29,
              showStoryRing: conversation.unread,
              colors: conversation.colors,
            ),
            title: Text(
              conversation.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: conversation.unread
                    ? FontWeight.w700
                    : FontWeight.w400,
              ),
            ),
            subtitle: Text(
              conversation.preview,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: conversation.unread
                    ? Colors.white
                    : const Color(0xFF9EA4AD),
                fontWeight: conversation.unread
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
            trailing: conversation.unread
                ? const Icon(Icons.circle, size: 10, color: Color(0xFF5278FF))
                : const Icon(
                    Icons.photo_camera_outlined,
                    color: Color(0xFF9EA4AD),
                  ),
            onTap: () => showInstagramMessage(
              context,
              'Conversación con ${conversation.name} (simulación).',
            ),
          ),
      ],
    );
  }
}

// Burbuja reutilizable para mostrar una nota encima del avatar.
class _NoteBubble extends StatelessWidget {
  const _NoteBubble({
    required this.name,
    required this.note,
    required this.colors,
    this.isOwnNote = false,
  });

  final String name;
  final String note;
  final List<Color> colors;
  final bool isOwnNote;

  @override
  Widget build(BuildContext context) {
    // El avatar y la nota se apilan para imitar la sección de notas.
    return SizedBox(
      width: 92,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 96,
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  InstagramAvatar(
                    name: name,
                    radius: 34,
                    showStoryRing: !isOwnNote,
                    colors: colors,
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 88),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF282D33),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        note,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  if (isOwnNote)
                    Positioned(
                      right: 7,
                      bottom: -1,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF090D12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isOwnNote ? 'Tu nota' : name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
