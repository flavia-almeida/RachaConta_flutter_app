import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _tValor = TextEditingController(); // controle de campo de texto editável
  final _tPessoas = TextEditingController();
  final _tGorgeta = TextEditingController();
  var _infoText = "Informe a conta!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de BUTECO"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tValor.text = "";
    _tPessoas.text = "";
    _tGorgeta.text = "";
    setState(() {
      _infoText = "INFORME A CONTA";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor total", _tValor),
              _editText("Pessoas", _tPessoas),
              _editText("Porcentagem da gorgeta", _tGorgeta),
              _buttonCalcular(),
              _textInfo(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 18,
        color: Colors.redAccent,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.redAccent,
        child:
        Text(
          "DIVIDIR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR O IMC
  void _calculate(){
    setState(() {
      double valor = double.parse(_tValor.text);
      double pessoas = double.parse(_tPessoas.text);
      double PGorgeta = double.parse(_tGorgeta.text);
      double Gorgeta = (PGorgeta * valor) /100;
      double ContaT = Gorgeta + valor;
      double total = ContaT / pessoas;

      String totalStr = total.toStringAsPrecision(4);
      String totalGorg = Gorgeta.toStringAsPrecision(4);
      String totalCont = ContaT.toStringAsPrecision(4);

      _infoText = "TOTAL PARA CADA ($totalStr)\nVALOR TOTAL DA GORGETA: ($totalGorg)\nVALOR TOTAL DA CONTA: ($totalCont) ";




    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.redAccent, fontSize: 20.0),
    );
  }
}
