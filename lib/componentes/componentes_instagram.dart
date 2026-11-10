import 'package:flutter/material.dart';

// Avatar reutilizable; puede mostrar un anillo de historia con degradado.
class InstagramAvatar extends StatelessWidget {
  const InstagramAvatar({
    required this.name,
    this.radius = 24,
    this.showStoryRing = false,
    this.colors = const [Color(0xFF833AB4), Color(0xFFE1306C)],
    super.key,
  });

  final String name;
  final double radius;
  final bool showStoryRing;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    // Se ajustan los radios para que el borde no cambie el tamaño exterior.
    final avatar = CircleAvatar(
      radius: radius - (showStoryRing ? 2 : 0),
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: radius - (showStoryRing ? 4 : 0),
        backgroundColor: colors.last.withValues(alpha: 0.18),
        child: Text(
          name.isEmpty ? '?' : name.characters.first.toUpperCase(),
          style: TextStyle(
            color: colors.first,
            fontSize: radius * 0.8,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    if (!showStoryRing) return avatar;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: colors),
      ),
      child: avatar,
    );
  }
}

// Ilustración local con icono y degradado para publicaciones de ejemplo.
class InstagramArtwork extends StatelessWidget {
  const InstagramArtwork({
    required this.icon,
    required this.colors,
    this.label,
    super.key,
  });

  final IconData icon;
  final List<Color> colors;
  final String? label;

  @override
  Widget build(BuildContext context) {
    // Composición decorativa que evita depender de imágenes externas.
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -34,
            right: -24,
            child: Icon(
              icon,
              size: 190,
              color: Colors.white.withValues(alpha: 0.13),
            ),
          ),
          Center(
            child: Icon(
              icon,
              size: 76,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          if (label != null)
            Positioned(
              left: 18,
              bottom: 18,
              child: Text(
                label!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  shadows: [Shadow(blurRadius: 8, color: Colors.black38)],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Muestra confirmaciones breves para acciones que solo se simulan.
void showInstagramMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
}
