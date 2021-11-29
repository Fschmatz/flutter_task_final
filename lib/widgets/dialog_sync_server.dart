import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DialogSyncServer extends StatefulWidget {
  const DialogSyncServer({Key? key}) : super(key: key);

  @override
  _DialogSyncServerState createState() => _DialogSyncServerState();
}

class _DialogSyncServerState extends State<DialogSyncServer> {
  List<Map<String, dynamic>> usuarioList = [];
  List<Map<String, dynamic>> inscricaoList = [];

  @override
  void initState() {
    super.initState();
    getAllUsuarios();
    getAllInscricoes();
  }

  Future<void> getAllUsuarios() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

    var resp = await db.query('usuario');
    setState(() {
      usuarioList = resp;
    });
    print(usuarioList.toString());
  }

  Future<void> getAllInscricoes() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

    var resp = await db.query('inscricao');
    setState(() {
      inscricaoList = resp;
    });
    print(inscricaoList.toString());
  }

  //2 user padrão
  void syncUsuarios() async {//9091
    Uri apiUrl = Uri.parse("http://localhost:9090/usuario/syncUser/");
    //ID não importa
    for (int i = 2; i < usuarioList.length; i++) {
      final response = await http.post(apiUrl, body: {
        'id_usuario': usuarioList[i]['id_usuario'].toString(),
        'nome': usuarioList[i]['nome'],
        'cpf': usuarioList[i]['cpf'],
        'email': usuarioList[i]['email'],
        'login': usuarioList[i]['login'],
        'senha': usuarioList[i]['senha'],
      });
    }
  }

  //3 insc padrao
  void syncInscricao() async {//9092
    Uri apiUrl =
        Uri.parse("http://localhost:9090/evento/inscricao/syncInscricao/");

    for (int i = 3; i < inscricaoList.length; i++) {
      final response = await http.post(apiUrl, body: {
        'id_inscricao': inscricaoList[i]['id_inscricao'].toString(),
        'id_usuario': inscricaoList[i]['id_usuario'].toString(),
        'id_evento': inscricaoList[i]['id_evento'].toString(),
        'cpf_user': inscricaoList[i]['cpf_user'],
        'checkin': '1',
        'data': '02/12/2021'
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.fromLTRB(16, 25, 0, 24),
      title: const Text('Sincronizar\n\nUSUARIO PRIMEIRO!!!'),
      actions: [
        TextButton(
          child: const Text(
            "Fechar",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      content: SizedBox(
          height: 110.0,
          width: 350.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(75, 20, 60, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      syncUsuarios();
                    },
                    child: Column(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Icon(Icons.people),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text("Usuarios"),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  height: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      syncInscricao();
                    },
                    child: Column(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Icon(Icons.notes),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text("Inscrições"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
