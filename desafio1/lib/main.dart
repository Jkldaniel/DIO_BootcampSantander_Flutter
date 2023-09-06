import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraIMCApp());
}

class CalculadoraIMCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true, // Centraliza o título
        ),
        backgroundColor: Colors.grey, // Define a cor de fundo
        body: Center(
          child: CalculadoraIMC(),
        ),
      ),
    );
  }
}

class CalculadoraIMC extends StatefulWidget {
  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(200.0), // Define o espaço ao redor do ListView
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Peso (kg)'),
                  ),
                  TextField(
                    controller: alturaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Altura (m)'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0), // Adiciona um espaço entre a entrada de dados e o botão
            ElevatedButton(
              onPressed: () {
                calcularIMC();
              },
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20.0), // Adiciona um espaço entre o botão e o resultado
            Text(
              resultado,
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center, // Centraliza o texto do resultado
            ),
          ],
        ),
      ),
    );
  }

  void calcularIMC() {
    double peso = double.tryParse(pesoController.text) ?? 0.0;
    double altura = double.tryParse(alturaController.text) ?? 0.0;

    if (peso > 0 && altura > 0) {
      double imc = peso / (altura * altura);
      setState(() {
        resultado = 'IMC: ${imc.toStringAsFixed(2)}\nClassificação: ${classificarIMC(imc)}';
      });
    } else {
      setState(() {
        resultado = 'Por favor, insira valores válidos para peso e altura.';
      });
    }
  }

  String classificarIMC(double imc) {
    if (imc < 16) {
      return "Magreza grave";
    } else if (imc >= 16 && imc < 17) {
      return "Magreza moderada";
    } else if (imc >= 17 && imc < 18.5) {
      return "Magreza leve";
    } else if (imc >= 18.5 && imc < 25) {
      return "Saudável";
    } else if (imc >= 25 && imc < 30) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc < 35) {
      return "Obesidade Grau I";
    } else if (imc >= 35 && imc < 40) {
      return "Obesidade Grau II (severa)";
    } else {
      return "Obesidade Grau III (mórbida)";
    }
  }
}
