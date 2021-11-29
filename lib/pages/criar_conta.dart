import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  _CriarContaState createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {

  TextEditingController textControllerNome = TextEditingController();
  TextEditingController textControllerCpf = TextEditingController();
  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerLogin = TextEditingController();
  TextEditingController textControllerSenha = TextEditingController();

  int getRamdonValue(){
    Random rnd;
    int min = 500;
    int max = 1500;
    rnd = Random();
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  void salvarConta() async {
    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

    await db.insert('usuario', {
      'id_usuario': getRamdonValue(),
      'nome': textControllerNome.text,
      'cpf': textControllerCpf.text,
      'email': textControllerEmail.text,
      'login': textControllerLogin.text,
      'senha': textControllerSenha.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Conta Rápida"),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                icon: const Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  salvarConta();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(200, 10, 200, 0),
          child: ListView(children: [

            const SizedBox(height: 30,),
            TextField(
              minLines: 1,
              controller: textControllerNome,
              decoration: InputDecoration(
                helperText: "NOME",
                focusColor: Theme.of(context).accentColor,
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30,),
            TextField(
              minLines: 1,
              controller: textControllerCpf,
              decoration: InputDecoration(
                helperText: "CPF",
                focusColor: Theme.of(context).accentColor,
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30,),
            TextField(
              minLines: 1,
              controller: textControllerEmail,
              decoration: InputDecoration(
                helperText: "EMAIL",
                focusColor: Theme.of(context).accentColor,
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30,),
            TextField(
              minLines: 1,
              controller: textControllerLogin,
              decoration: InputDecoration(
                helperText: "LOGIN",
                focusColor: Theme.of(context).accentColor,
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30,),
            TextField(
              minLines: 1,
              controller: textControllerSenha,
              decoration: InputDecoration(
                helperText: "SENHA",
                focusColor: Theme.of(context).accentColor,
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          const SizedBox(height:100),
          ]),
        ));
  }
}
