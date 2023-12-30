import 'package:flutter/material.dart';
import 'package:gestion_stock_flutter/client/client.dart';
import 'package:gestion_stock_flutter/service/client_service.dart';
import 'package:gestion_stock_flutter/widget/drawer_widget.dart';
import 'package:gestion_stock_flutter/widget/row_item_widget.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  ClientService _clientService = ClientService();
  List<Client> Clients = [];
  bool isLoading = false;
  final String appBarTitle = 'Listes des clients';

  void setIsloadingClient(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  Future<void> getData() async {
    setIsloadingClient(true);
    Clients = await _clientService.getClientsFromFirebase();
    setIsloadingClient(false);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text(appBarTitle),
        ),
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: Clients.map((e) => ListTile(
                        leading: Icon(Icons.person),
                        title: Text(e.nom),
                        subtitle: Text(e.adresse),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          child: Text(
                                            e.nom.toUpperCase().substring(0, 2),
                                            style: TextStyle(
                                                fontSize: 60,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: SingleChildScrollView(
                                            child: Column(children: [
                                          RowItem(
                                              title: 'Nom :', content: e.nom),
                                          RowItem(
                                              title: 'Adresse :',
                                              content: e.adresse),
                                          RowItem(
                                              title: 'Telephone :',
                                              content: e.adresse),
                                        ])),
                                      )
                                    ],
                                  ),
                                );
                              });
                        })).toList(),
                  ),
          ),
        )),
        drawer: DrawerWidget(),
      ),
    );
  }
}
