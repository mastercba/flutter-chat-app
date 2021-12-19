import 'dart:io';

//creo una clase que solo va a tener METODOS ESTATICOS
//al tener metodos estaticos significa que yo puedo acceder
//a ellos sin necesidad de instanciar la clase

class Environment {
  //servidor REST
  static String apiUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api';
  //variable de entorno
  //servidor de sockets
  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
