import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
//  final _storage = new FlutterSecureStorage();

  //bloquear el boton de ingrese p/ k no se pueda hacer doble posteo
//  bool _autenticando = false; //propiedad indica cuando se esta autenticando
  //como es privada entonces tengo que hacer con getters y setters;
  //y asi cuando se cambie la propiedad _autenticando a true o false,
  //=> notficara a los listeners es decir que cualquier persona o widget
  //que este escuchando los cambios de mi AuthService va a ser notificado
  //cuando cambie esa propiedad....este es uno de los usos de provider!!!!!
  //con guion bajo es privada solo aqui, y sin guion bajo aparce afuera!!!
//  bool get autenticando => this._autenticando;
//  set autenticando(bool valor) {
//    this._autenticando = valor;
//    notifyListeners(); //notifica a todos los k estan escuchando _autenticando
  //para que se redibuje
//  }

  // Getters del token de forma estática
  //acceder al token en otra pantalla
//  static Future<String?> getToken() async {
//    final _storage = new FlutterSecureStorage();
//    final token = await _storage.read(key: 'token');
//    return token;
//  }

//  static Future<void> deleteToken() async {
//    final _storage = new FlutterSecureStorage();
//    await _storage.delete(key: 'token');
//  }

  //tengo que crear un metodo  future recibe email y password
  Future login(String email, String password) async {
    //var url = Uri.parse('http://10.0.2.2:3000/api/login');
    var urlLogin = Uri.parse('${Environment.apiUrl}/login');
//    this.autenticando = true;

    //payload que mandare al backend
    final data = {'email': email, 'password': password};

    final resp = await http.post(urlLogin,
        body: jsonEncode(data), //convert la data(objeto) a su forma de json
        headers: {'Content-Type': 'application/json'});

    //necesitamos que esta repuesta, mapear a un tipo de modelo
    //propio de nuestra aplicacion! usamos https://quicktype.io
    print(resp.body);

//    this.autenticando = false;

    //necesito saber si la peticion se hace correctamente?
    //que statusCode me devuelve?400:; 401:;404:no se encontro
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

//      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

/*   Future register(String nombre, String email, String password) async {
//    this.autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    //final resp = await http.post('${Environment.apiUrl}/login/new',
    var urlRegister = Uri.parse('${Environment.apiUrl}/login/new');
    final resp = await http.post(urlRegister,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

//    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
//      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body); //mapeo un json string a un mapa
      return respBody['msg'];
    }
  } */

  //verificamos el token que esta guardado en el storage mi celular,
  //comprobamos si es valido con el que esta guardado en el backend!
  //
/*   Future<bool> isLoggedIn() async {
//    final token = await this._storage.read(key: 'token');
//    print(token);

    //var urlIsLogged = Uri.parse('${Environment.apiUrl}/login/renew');
    final resp = await http
        .get(Uri.parse('${Environment.apiUrl}/login/renew'), headers: {
      'Content-Type': 'application/json',
//          'x-token': token.toString()
    });

    print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
//      await this._guardarToken(loginResponse.token);
      return true;
    } else {
//      this.logout(); //token no sirve, entonces lo borro!
      return false;
    }
  } */

//  Future _guardarToken(String token) async {
//    return await _storage.write(key: 'token', value: token);
//  }

//  Future logout() async {
//    await _storage.delete(key: 'token');
//  }
}
