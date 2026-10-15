import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  //Control para mostrar/ocultar contraseña
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    //Obtener el tamaño de la pantalla del dispositivo
    final Size size = MediaQuery.of(context).size;


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 ),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset('assets/login-bear-animation.riv')
                ),
                //Para separar
                const SizedBox(height: 10),
                //Email
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    
                    ),
                ),
                SizedBox(height: 10),
                //Constraseña
                TextField(
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ), // El icono se cierra aquí correctamente
                    onPressed: () {
                      // Para refrescar el icono
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  ),
                )
            ],
          ),
        )
      ),
    );
  }
}