import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  final String nomUser;

  Menu({Key? key, required this.nomUser}) : super(key: key);
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  List listTransport = [];

  Future getTransport() async {
    //Définition de l'URL PHP de la page transport
    var url = Uri.parse("http://10.0.2.2/bdvavite/php/transport.php");

    //Appel de la requête HTTP
    var response = await http.get(url);

    //Vériification du status de la requête HTTP
    if (response.statusCode == 200) {
      setState(() {
        listTransport = jsonDecode(response.body);
      });
      return (listTransport);
    } else {
      print('Vous n' 'avez pas de transport(s) prévus');
    }
  }

  /*A l'initialisation des widgets, appel de la méthode pour charger
    la liste des transports */
  @override
  void initState() {
    getTransport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bonjour ${widget.nomUser}"),
          actions: const <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () {}),
        body: ListView.builder(
            itemCount: listTransport.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: GestureDetector(
                  onTap: () {
                    debugPrint('Bouton modifier cliqué');
                  },
                  child: const Icon(Icons.edit),
                ),
                title: Text('Date /heure :' +
                    listTransport[index]['date'] +
                    ' ' +
                    listTransport[index]['heure']),
                subtitle: Text(listTransport[index]['typeOffre']),
              );
            }));
  }
}
