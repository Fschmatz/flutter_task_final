import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ListaEventos extends StatefulWidget {

  int idUsuarioLogado;
  int cpfUsuarioLogado;
  ListaEventos({Key? key,required this.idUsuarioLogado,required this.cpfUsuarioLogado}) : super(key: key);

  @override
  _ListaEventosState createState() => _ListaEventosState();
}

class _ListaEventosState extends State<ListaEventos> {

  List<Map<String, dynamic>> eventosList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAll();
  }

  Future<void> getAll() async {

    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

    var resp = await db.query('evento');
    setState(() {
      eventosList = resp;
      loading = false;
    });
  }

  int getRamdonValue(){
    Random rnd;
    int min = 500;
    int max = 1500;
    rnd = Random();
    int r = min + rnd.nextInt(max - min);
    return r;
  }


  void fazerCheckin(int idEvento) async {
    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

    await db.insert('inscricao', {
    'id_inscricao': getRamdonValue(),
    'id_usuario': widget.idUsuarioLogado,
    'id_evento': idEvento,
    'cpf_user': widget.cpfUsuarioLogado,
    'checkin': 1,
    'data': '02/12/2021'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Evento para Check-In'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: loading
            ? const Center(child: SizedBox.shrink())
            : ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: eventosList.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: SizedBox(
                      height: 120,
                      child: Card(
                        key: UniqueKey(),
                        margin:  const EdgeInsets.fromLTRB(200, 50, 200, 0),
                       child: InkWell(
                         onTap: (){
                           fazerCheckin(eventosList[index]['id_evento']);
                           Navigator.of(context).pop();
                         },
                         child: ListTile(
                           title: Text('\n'+
                               eventosList[index]['nome']
                           ),
                           trailing: const Text(
                             'Fazer Check-In'
                           ),
                         ),
                       ),

                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 100,
              ),
            ]),
      ),
    );
  }
}

/*

note: Note(
eventosList[index]['id'],
eventosList[index]['title'],
eventosList[index]['text'],
eventosList[index]['pinned'] ?? 0,
),*/
