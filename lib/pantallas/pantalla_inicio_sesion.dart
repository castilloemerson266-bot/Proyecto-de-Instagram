import 'package:flutter/material.dart';

import '../componentes/navegacion_principal.dart';

// Credenciales estáticas para probar el acceso sin servidor ni base de datos.
const String usuarioCorrecto = 'admin';
const String passwordCorrecta = '123456';

// Pantalla de acceso: conserva los valores de los campos y el estado del formulario.
class PantallaInicioSesion extends StatefulWidget {
  const PantallaInicioSesion({super.key});

  @override
  State<PantallaInicioSesion> createState() => _EstadoPantallaInicioSesion();
}

class _EstadoPantallaInicioSesion extends State<PantallaInicioSesion> {
  // Controladores para leer y liberar los valores escritos por el usuario.
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  // Libera los controladores al cerrar esta pantalla.
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Valida los campos y compara lo escrito con las credenciales de prueba.
  void _login() {
    if (!_formKey.currentState!.validate()) return;

    if (_usernameController.text.trim() != usuarioCorrecto ||
        _passwordController.text != passwordCorrecta) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Usuario o contraseña incorrectos.')),
        );
      return;
    }

    // Si los datos coinciden, reemplaza el login por la navegación principal.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => NavegacionPrincipal(
          username: _usernameController.text.trim(),
          onLogout: (context) {
            // Cerrar sesión elimina las pantallas anteriores y vuelve al login.
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(
                builder: (_) => const PantallaInicioSesion(),
              ),
              (_) => false,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Diseño del formulario de acceso con campos y acciones de demostración.
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    const Icon(
                      Icons.camera_alt_outlined,
                      size: 64,
                      color: Color(0xFFE1306C),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Instagram',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 42),
                    // Campo de usuario; no permite enviar el formulario vacío.
                    TextFormField(
                      key: const ValueKey('usernameField'),
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Usuario o correo electrónico',
                        filled: true,
                        fillColor: Color(0xFF171B20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF30343A)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF30343A)),
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Ingresa tu usuario.'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    // Campo de contraseña con opción para mostrar u ocultar el texto.
                    TextFormField(
                      key: const ValueKey('passwordField'),
                      controller: _passwordController,
                      obscureText: _hidePassword,
                      onFieldSubmitted: (_) => _login(),
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                        filled: true,
                        fillColor: const Color(0xFF171B20),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF30343A)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF30343A)),
                        ),
                        suffixIcon: IconButton(
                          tooltip: _hidePassword
                              ? 'Mostrar contraseña'
                              : 'Ocultar contraseña',
                          onPressed: () {
                            setState(() => _hidePassword = !_hidePassword);
                          },
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Ingresa tu contraseña.'
                          : null,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      // Acción informativa: la recuperación no usa un servicio real.
                      child: TextButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Recuperación de contraseña (simulación).',
                              ),
                            ),
                          ),
                        child: const Text('¿Olvidaste tu contraseña?'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 48,
                      // Ejecuta las validaciones y el inicio de sesión.
                      child: FilledButton(
                        onPressed: _login,
                        child: const Text('Iniciar sesión'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'O',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Acción ilustrativa; no inicia una sesión de Facebook real.
                    TextButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Inicio con Facebook (simulación).'),
                          ),
                        ),
                      icon: const Icon(Icons.facebook),
                      label: const Text('Continuar con Facebook'),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Simulación académica de Instagram',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
