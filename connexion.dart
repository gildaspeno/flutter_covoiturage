import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_connexion/menu.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Connexion extends StatefulWidget {
  @override
  ConnexionState createState() => ConnexionState();
}

class ConnexionState extends State<Connexion> {
  late TextEditingController clogin;
  late TextEditingController cmdp;

  var nom = '';
  List unUser = [];
  Future login() async {
    var url = Uri.parse("http://10.0.2.2/bdvavite/php/login.php");

    var response =
        await http.post(url, body: {"login": clogin.text, "mdp": cmdp.text});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data == "Erreur") {
        Fluttertoast.showToast(
            msg: "Problème d'authentification",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Accès autorisé",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        //Récupération des valeurs de la requête
        unUser = data;
        nom = unUser[0]['nomUser'] + ' ' + unUser[0]['prenUser'];

        //Navigation vers la page Menu en transmettant les noms et prénoms
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Menu(nomUser: nom)));
      }
    } else {
      print('Erreur d' 'accès à la base de données');
    }
  }

  @override
  void initState() {
    super.initState();
    clogin = TextEditingController();
    cmdp = TextEditingController();
  }

  @override
  void dispose() {
    clogin.dispose();
    cmdp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: [
        Card(
          child: TextField(
            controller: clogin,
            decoration: const InputDecoration(hintText: "Entrez votre login"),
          ),
        ),
        Card(
          child: TextField(
            controller: cmdp,
            obscureText: true,
            decoration:
                const InputDecoration(hintText: "Entrez votre mot de passe"),
          ),
        ),
        Row(
          children: [
            Expanded(
                child: MaterialButton(
              color: Colors.deepOrange.shade300,
              child: Text(
                'Connexion',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                login();
              },
            ))
          ],
        )
      ]),
    );
  }
}
