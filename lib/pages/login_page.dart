import 'dart:ffi';

import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/helpers/mostrar_alerta.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('estoy entrando al LoginPage!!!!!!!!');
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            //para que en ios y android parece que rebota
            physics: BouncingScrollPhysics(),
            child: Container(
              //para que x el scrollview no se junten todos los childs
              //tomamos el max de alto de pantalla  *0.9
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(titulo: 'Messenger'),
                  _Form(),
                  Labels(
                    ruta: 'register',
                    titulo: '¿No tienes cuenta?',
                    subTitulo: 'Crea una ahora!',
                  ),
                  Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //aqui en el build voy a poder redibujarlo si esa propiedad cambia
    //o si el provider del AuthService dispara el NotifyListeners
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.mail_outline,
              placeholder: 'Correo',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
              text: 'Ingrese',
              onPressed: authService.autenticando ? null : () async {}
/*             onPressed: () async {
//              //onPressed: authService.autenticando
//              //    ?
//              //    : () async {
//              //oculto teclado y oculto el teclado
              FocusScope.of(context).unfocus();
              print('ingrese');
              print(emailCtrl.text);
              print(passCtrl.text);
//              //usamos nuestro provider para mandar a llamar esto
//              //listen:false para que no intente redibujar el widget
//              //solo necesito la referencia, para llamar el authservice.login
//              //final authService =
//              //    Provider.of<AuthService>(context, listen: false);
//              //authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
              final loginOk = await authService.login(
                  emailCtrl.text.trim(), passCtrl.text.trim());

              if (loginOk) {
                //Conectar a nuestro socket server
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                // Mostara alerta
                mostrarAlerta(context, 'Login incorrecto',
                    'Revise sus credenciales nuevamente');
              }
            }, */
              )
        ],
      ),
    );
  }
}
