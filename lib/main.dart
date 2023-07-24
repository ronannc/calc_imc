import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? errorEqualZero;

  String resultado = 'Entre com os valores para calcular!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcularadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            onPressed: refreshForm,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.accessibility,
              size: 100,
            ),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (Kg)',
                labelStyle: TextStyle(color: Colors.deepOrangeAccent),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                labelStyle: const TextStyle(color: Colors.deepOrangeAccent),
                errorText: errorEqualZero,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: calcularIMC,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 10)),
              child: const Text(
                'Calcular',
              ),
            ),
            Text(resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.deepOrangeAccent,
                )),
          ],
        ),
      ),
    );
  }

  void setErrorEqualZero() {
    setState(() {
      errorEqualZero = 'Numero deve ser maior que 0!';
    });
  }

  void resetInputs() {
    alturaController.text = '';
    pesoController.text = '';
    errorEqualZero = null;
  }

  void refreshForm() {
    resetInputs();
    setState(() {
      resultado = 'Entre com os valores para calcular!';
    });
  }

  String classifica(imc) {
    String classe = '';
    if (imc < 18.6) {
      classe = 'Abaixo do Peso';
    } else if (imc >= 18.6 && imc < 24.9) {
      classe = 'Peso Ideal';
    } else if (imc >= 24.9 && imc < 29.9) {
      classe = 'Levemente Acima do Peso';
    } else if (imc >= 29.9 && imc < 34.9) {
      classe = 'Obesidade Grau I';
    } else if (imc >= 34.9 && imc <= 39.9) {
      classe = 'Obesidade Grau II';
    } else if (imc >= 40) {
      classe = 'Obesidade Grau III';
    }
    return classe;
  }

  calcularIMC() {
    if (alturaController.text.isEmpty ||
        double.parse(alturaController.text) <= 0) {
      setErrorEqualZero();
    } else {
      double altura = double.parse(alturaController.text) / 100;
      double peso = double.parse(pesoController.text);
      double imc = peso / (altura * altura);

      setState(() {
        resultado = '${classifica(imc)}: IMC ${imc.toStringAsPrecision(2)}';
      });
      resetInputs();
    }
  }
}
