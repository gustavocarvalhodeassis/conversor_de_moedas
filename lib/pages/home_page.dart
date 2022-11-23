import 'package:conversor_de_moedas/data/data.dart';
import 'package:conversor_de_moedas/widgets/text_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? dolar;

  double? euro;

  final TextEditingController reaisController = TextEditingController();

  final TextEditingController dolarController = TextEditingController();

  final TextEditingController euroController = TextEditingController();

  void _realChanged(String text) {
    if (text.isNotEmpty) {
      double real = double.parse(text);
      dolarController.text = (real / dolar!).toStringAsFixed(2);
      euroController.text = (real / euro!).toStringAsFixed(2);
    } else {}
  }

  void _dolarChanged(String text) {
    if (text.isNotEmpty) {
      double dolar = double.parse(text);
      this.dolar;
      reaisController.text = (dolar * this.dolar!).toStringAsFixed(2);
      euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
    } else {}
  }

  void _euroChanged(String text) {
    if (text.isNotEmpty) {
      double euro = double.parse(text);
      this.euro;
      reaisController.text = (euro * this.euro!).toStringAsFixed(2);
      dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de moedas'),
        actions: [
          IconButton(
            onPressed: () {
              dolarController.clear();
              reaisController.clear();
              euroController.clear();
            },
            icon: const Icon(
              Icons.cached,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Ocorreu um erro'),
                );
              } else {
                dolar = snapshot.data!['results']['currencies']['USD']['buy'];
                euro = snapshot.data!['results']['currencies']['EUR']['buy'];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.blue,
                          size: 150,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                          label: 'Reias',
                          preText: 'R\$',
                          controller: reaisController,
                          onChanged: _realChanged,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          label: 'Dolar',
                          preText: 'US\$',
                          controller: dolarController,
                          onChanged: _dolarChanged,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          label: 'Euro',
                          preText: '€',
                          controller: euroController,
                          onChanged: _euroChanged,
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
