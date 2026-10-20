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

  //1.1 Crear el cerebro de la animación
  StateMachineController? _controller;

  //paso 1.2 SMI: StateMachineInput / Entrada de maquina de estado
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;
  SMINumber? _numLook;

  @override
  Widget build(BuildContext context) {
    //Obtener el tamaño de la pantalla del dispositivo
    final Size size = MediaQuery.of(context).size;


    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20 ),
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: 200,
                  child: RiveAnimation.asset(
                  'assets/login-bear-animation.riv', 
                  stateMachines: ['Login Machine'],
                  //1.3 Vincular la animacion
                  onInit: (artboard) {
                    _controller = StateMachineController.fromArtboard(
                      artboard, 
                      'Login Machine',
                      );
                    //1.4 Verificar que inicio bien
                    if (_controller == null) return;


                    //Agregar el controlador al tablero
                    artboard.addController(_controller!);

                    //Vincular las variables
                    _isChecking = _controller!.findSMI('isCheking');
                    _isHandsUp = _controller!.findSMI('isHandsUp');
                    _trigSuccess = _controller!.findSMI('trigSuccess');
                    _trigFail = _controller!.findSMI('trigFail');
                    _numLook = _controller!.findSMI('numLook');




                  }

                  )
                  ),
                  //Para separar
                  const SizedBox(height: 10),
                  //Email
                  TextField(
                    onChanged: (value){
                      if (_isHandsUp != null){
                        //no tapes los ojos
                        _isHandsUp!.change(false);
                      }

                      //si isCheking es null
                      if (_isChecking == null) return;

                      //Activar el modo chismoso
                      _isChecking!.change(true);
                    },


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
                    onChanged: (value){
                      //1.5 Vincular a campos de texto
                      if (_isChecking != null){
                        //no tapes los ojos
                        _isChecking!.change(false);
                      }

                      //si isCheking es null
                      if (_isHandsUp == null) return;

                      //Activar el modo chismoso
                      _isHandsUp!.change(true);
                    },
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                    ),
                  )
              ],
            ),
          )
        ),
      ),
    );
  }
}