import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields(){
    //Controladores fazem o setState sozinho
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(weight);
      print(height);
      print(imc);
      if(imc < 18.5){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }
      else if(imc >= 18.5 && imc <= 24.9){
        _infoText = "Peso normal (${imc.toStringAsPrecision(3)})";
      }
      else if(imc >= 25 && imc <= 29.9){
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      }
      else if(imc >= 30 && imc <= 34.9){
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      }
      else if(imc >= 35 && imc <= 39.9){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      }
      else if(imc >= 40){
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //O Scaffold pode ser usado para criar barras. Esta cria a barra superior do app
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //Com isso, podemos rolar a tela enquanto estamos preenchendo um campo, evitande que o teclado tampe algo
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person, size: 120, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) { //O TextFormField tem um campo validator para fazer alidações. Neste caso, usamos para ver se não há campo vazio
                    if(value!.isEmpty){
                      return "Insira sua altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                  child: Container(
                    //Para o botão não ficar muito "estreito", ele foi colocado dentro de um Container onde podemps setar as dimensões
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){ //Antes de chaamr a função para calcular o IMC, é feito uma validação para ver se há valores nos campos
                          _calculate();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                      child: Text("Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
