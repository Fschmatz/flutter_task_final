import 'package:flutter/material.dart';

class DialogSyncServer extends StatefulWidget {
  const DialogSyncServer({Key? key}) : super(key: key);

  @override
  _DialogSyncServerState createState() => _DialogSyncServerState();
}

class _DialogSyncServerState extends State<DialogSyncServer> {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.fromLTRB(16, 25, 0, 24),
      title: const Text('Sincronizar'),
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
        height: 100.0,
        width: 350.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(75,20,60,20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},

                child: Column(

                  children: const <Widget>[
                    Icon(Icons.people),
                    Text("Usuarios")
                  ],
                ),
              ),
              const SizedBox(width: 50,),
              TextButton(
                onPressed: () {},

                child: Column(
                  children: const <Widget>[
                    Icon(Icons.notes),
                    Text("Inscrições")
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
