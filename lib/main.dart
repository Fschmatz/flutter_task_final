import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_task_final/pages/criar_conta.dart';
import 'widgets/dialog_sync_server.dart';
import 'package:flutter_task_final/pages/lista_eventos.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  int getRamdonValue() {
    Random rnd;
    int min = 500;
    int max = 1500;
    rnd = Random();
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  await db.execute('''    
           CREATE TABLE usuario (
             id_usuario INTEGER PRIMARY KEY,
             nome TEXT NOT NULL,
             cpf TEXT NOT NULL,
             email TEXT,
             login TEXT NOT NULL,
             senha TEXT NOT NULL
          )          
          ''');
  await db.execute('''       
          CREATE TABLE evento (
            id_evento INTEGER PRIMARY KEY,
            nome TEXT NOT NULL,
            data TEXT NOT NULL
          )
          ''');
  await db.execute(''' 
          CREATE TABLE inscricao (
            id_inscricao INTEGER PRIMARY KEY,
            id_usuario INTEGER NOT NULL,
            id_evento INTEGER NOT NULL,
            cpf_user TEXT NOT NULL,
            checkin INTEGER,
            data TEXT NOT NULL
          )
          ''');

  await db.insert('usuario', {
    'id_usuario': 1,
    'nome': 'Fernando',
    'cpf': '191919',
    'email': 'hahahahahahah@eu',
    'login': '42',
    'senha': '43'
  });

  await db.insert('usuario', {
    'id_usuario': 2,
    'nome': 'Korolev',
    'cpf': '151515',
    'email': 'hahahahahahah@euaaaa.com',
    'login': '86',
    'senha': '99'
  });

  await db.insert(
      'evento', {'id_evento': 1, 'nome': 'Show de Hoje', 'data': '32/13/1920'});
  await db.insert('evento',
      {'id_evento': 2, 'nome': 'Show de Amanha', 'data': '33/13/1920'});
  await db.insert('evento',
      {'id_evento': 3, 'nome': 'Show do Futuro', 'data': '33/13/1920'});

  await db.insert('inscricao', {
    'id_inscricao': 66,
    'id_usuario': 1,
    'id_evento': 1,
    'cpf_user ': '191919',
    'checkin': 0,
    'data': '01/01/1920'
  });

  await db.insert('inscricao', {
    'id_inscricao': 67,
    'id_usuario': 1,
    'id_evento': 2,
    'cpf_user ': '191919',
    'checkin': 0,
    'data': '01/01/1921'
  });

  await db.insert('inscricao', {
    'id_inscricao': 68,
    'id_usuario': 2,
    'id_evento': 2,
    'cpf_user ': '151515',
    'checkin': 0,
    'data': '01/01/1920'
  });

  //     'synced': 0,

  /* var resultEV = await db.query('evento');
  print(resultEV);
  var resultUs = await db.query('usuario');
  print(resultUs);
  var resultIns = await db.query('inscricao');
  print(resultIns);*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo Check-in V 0.2.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Aplicativo Check-in V 0.2.0'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textControllerLogin = TextEditingController();
  TextEditingController textControllerSenha = TextEditingController();

  showAlertLogin(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alerta = AlertDialog(
      title: Text("Erro"),
      content: Text("Usuario inválido"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  void printData(int option) async {
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    if (option == 1) {
      var res = await db.query('usuario');
      print(res);
    }
    if (option == 2) {
      var res = await db.query('inscricao');
      print(res);
    }
  }

  Future<int> login(String login, String senha) async {
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    int? idUsuario = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT id_usuario FROM usuario WHERE login= $login AND senha= $senha'));
    return idUsuario ?? 0;
  }

  Future<int> getCpf(int idUsuario) async {
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    int? cpf = Sqflite.firstIntValue(await db
        .rawQuery('SELECT cpf FROM usuario WHERE id_usuario=$idUsuario'));
    return cpf ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplicativo Check-in V 0.2.0"),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
              icon: const Icon(Icons.notes_outlined),
              tooltip: 'PRINT INSCRICOES',
              onPressed: () {
                printData(2);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
              icon: const Icon(Icons.people),
              tooltip: 'PRINT USUARIOS',
              onPressed: () {
                printData(1);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Sync DB',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const DialogSyncServer();
                    });
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 50),
              child: TextField(
                minLines: 1,
                controller: textControllerLogin,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  focusColor: Theme.of(context).accentColor,
                  helperText: "Login",
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 50),
              child: TextField(
                minLines: 1,
                controller: textControllerSenha,
                decoration: InputDecoration(
                  icon: const Icon(Icons.password),
                  focusColor: Theme.of(context).accentColor,
                  helperText: "Senha",
                ),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    //NAO ACEITAR OS CAMPOS VAZIOS
                    if (textControllerLogin.text.isNotEmpty &&
                        textControllerSenha.text.isNotEmpty) {
                      int user = await login(
                          textControllerLogin.text, textControllerSenha.text);
                      int cpf = await getCpf(user);
                      if (user != 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ListaEventos(
                                idUsuarioLogado: user,
                                cpfUsuarioLogado: cpf,
                              ),
                              fullscreenDialog: true,
                            ));
                        //LIMPA CAMPOS
                        textControllerLogin.text = '';
                        textControllerSenha.text = '';
                      } else {
                        showAlertLogin(context);
                      }
                    } else {
                      showAlertLogin(context);
                    }
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const CriarConta(),
                          fullscreenDialog: true,
                        ));
                  },
                  child: const Text(
                    "CRIAR CONTA",
                    style: TextStyle(fontSize: 18),
                  )),
            ),

            const SizedBox(
              height: 30,
            ),
            //TextButton(onPressed: (){_saveEvento();}, child: Text("TESTE",style: TextStyle(fontSize: 18),)),
          ],
        ),
      ),
    );
  }
}
