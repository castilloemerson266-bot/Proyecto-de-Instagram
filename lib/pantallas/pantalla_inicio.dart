import 'package:flutter/material.dart';

import '../componentes/componentes_instagram.dart';

// Inicio: muestra historias y publicaciones de ejemplo para la cuenta activa.
class PantallaInicio extends StatefulWidget {
  const PantallaInicio({required this.username, super.key});

  final String username;

  @override
  State<PantallaInicio> createState() => _EstadoPantallaInicio();
}

class _EstadoPantallaInicio extends State<PantallaInicio> {
  // Guarda los índices de publicaciones marcadas con Me gusta.
  final Set<int> _likedPosts = {};

  // Datos de muestra; no se descargan imágenes ni publicaciones de Internet.
  static const _posts = [
    (
      username: 'Emerson.viaja',
      location: 'Costa Rica',
      caption: 'Un lugar para guardar en la memoria. 🌴',
      likes: '1,284',
      icon: Icons.beach_access,
      colors: [Color(0xFF31A8A0), Color(0xFFB4D86A)],
    ),
    (
      username: 'marco.cocina',
      location: 'En casa',
      caption: 'Domingo de algo rico. ¿Quién se apunta? 🍝',
      likes: '846',
      icon: Icons.restaurant,
      colors: [Color(0xFFE88B54), Color(0xFF9D3A45)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Lista desplazable de historias y publicaciones.
    return ListView(
      padding: const EdgeInsets.only(bottom: 12),
      children: [
        _buildStories(),
        const Divider(height: 1),
        for (var index = 0; index < _posts.length; index++)
          _buildPost(context, index),
      ],
    );
  }

  // Construye la fila desplazable de historias.
  Widget _buildStories() {
    final stories = [
      (widget.username, const [Color(0xFF833AB4), Color(0xFFE1306C)]),
      ('sofia.viaja', const [Color(0xFFF77737), Color(0xFFE1306C)]),
      ('luis.photo', const [Color(0xFF405DE6), Color(0xFF833AB4)]),
      ('ana.art', const [Color(0xFFFCAF45), Color(0xFFE1306C)]),
      ('marco.cocina', const [Color(0xFF833AB4), Color(0xFF405DE6)]),
    ];

    return SizedBox(
      height: 116,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final story = stories[index];
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  InstagramAvatar(
                    name: story.$1,
                    radius: 32,
                    showStoryRing: index != 0,
                    colors: story.$2,
                  ),
                  if (index == 0)
                    Positioned(
                      right: -1,
                      bottom: -1,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF090D12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 66,
                child: Text(
                  index == 0 ? 'Tu historia' : story.$1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Construye una publicación y sus acciones básicas.
  Widget _buildPost(BuildContext context, int index) {
    final post = _posts[index];
    final isLiked = _likedPosts.contains(index);
    final likeCount =
        int.parse(post.likes.replaceAll(',', '')) + (isLiked ? 1 : 0);
    final formattedLikeCount = likeCount >= 1000
        ? '${likeCount ~/ 1000},${(likeCount % 1000).toString().padLeft(3, '0')}'
        : '$likeCount';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          dense: true,
          leading: InstagramAvatar(
            name: post.username,
            radius: 20,
            showStoryRing: true,
            colors: post.colors,
          ),
          title: Text(
            post.username,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          subtitle: Text(post.location, style: const TextStyle(fontSize: 12)),
          trailing: IconButton(
            tooltip: 'Más opciones',
            onPressed: () => showInstagramMessage(
              context,
              'Publicación guardada en la simulación.',
            ),
            icon: const Icon(Icons.more_horiz),
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: GestureDetector(
            key: ValueKey('postImage$index'),
            onDoubleTap: () => _toggleLike(index),
            child: InstagramArtwork(
              icon: post.icon,
              colors: post.colors,
              label: post.location,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
          child: Row(
            children: [
              IconButton(
                key: ValueKey('likeButton$index'),
                tooltip: isLiked ? 'Quitar Me gusta' : 'Me gusta',
                onPressed: () => _toggleLike(index),
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                ),
              ),
              IconButton(
                tooltip: 'Comentar',
                onPressed: () => showInstagramMessage(
                  context,
                  'La sección de comentarios es una demostración.',
                ),
                icon: const Icon(Icons.mode_comment_outlined),
              ),
              IconButton(
                tooltip: 'Compartir',
                onPressed: () => showInstagramMessage(
                  context,
                  'Publicación compartida en la simulación.',
                ),
                icon: const Icon(Icons.send_outlined),
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Guardar',
                onPressed: () =>
                    showInstagramMessage(context, 'Publicación guardada.'),
                icon: const Icon(Icons.bookmark_border),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$formattedLikeCount Me gusta',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 14),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${post.username} ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: post.caption),
              ],
            ),
            style: const TextStyle(fontSize: 13),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  // Alterna el Me gusta y actualiza el contador al reconstruir la pantalla.
  void _toggleLike(int index) {
    setState(() {
      if (!_likedPosts.add(index)) _likedPosts.remove(index);
    });
  }
}
