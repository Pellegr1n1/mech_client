import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-page_background.png'), // Background da página de login
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Olá!',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFFF5C00)),
                    ),
                    SizedBox(height: 8), // Espaço entre os textos
                    Text(
                      'Seja bem-vindo!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 225.0,
                  height: 90.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(top: 100.0),
                  child: TextField(
                    obscureText: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      suffixIcon: const Icon(
                        Icons.email,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Senha',
                      suffixIcon: const Icon(
                        Icons.lock,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 35.0),
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica de autenticação aqui
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5C00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0), // Arredondamento da borda
                      ),
                    ),
                    child: const Text('Entrar',
                     style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35.0, bottom: 100),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Não tem conta? ',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Registre-se aqui!',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFFF5C00)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}