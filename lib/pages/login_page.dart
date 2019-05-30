import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/service/firebase_service.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_app/utils/alert.dart';
import 'package:flutter_app/utils/nav.dart';
import 'package:flutter_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tEmail = TextEditingController(text: "lucas@gmail.com");
  final _tSenha = TextEditingController(text: "abc123");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.getToken().then((s) {
      print("Token: $s");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Container(
            height: 15,
            child: Text(
              "E-mail",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _tEmail,
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            height: 15,
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Senha",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 10),
            child: TextField(
              controller: _tSenha,
              obscureText: true,
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {
                _onClickLoginFirebase(context);
              },
              child: Text("Login",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: GoogleSignInButton(
              onPressed: () {
                _onClickLoginGoogle(context);
              },
            ),
          ),
          Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: (){
                _onClickCadastrar(context);
              },
              child: Text(
                "Cadastre-se",
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onClickLoginGoogle(context) async{
    print('google button clicked');
    final service = FirebaseService();
    final response = await service.loginGoogle();
    if(response.isOk()){
      print("logou google");
      pushReplacement(context,HomePage());
    }else{
      alert(context, msg: "Erro ao efetuar o login", title: "Erro");
    }
  }
  _onClickLoginFirebase(context) async{
    print("login firebase button clicked");
    final service = FirebaseService();
    final email = _tEmail.text;
    final senha = _tSenha.text;
    final response = await service.login(email, senha);
    if(response.isOk()) {
      alert("logged firebase");
      pushReplacement(context,HomePage());
    }else{
      alert(context, msg: "Erro ao efetuar o login", title: "Erro");
    }
  }
  _onClickCadastrar(context) async{
    print("cadastrar button clicked");
  }
}
