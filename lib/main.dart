// ignore_for_file: prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var items = ['Kelvin', 'Reamur'];

  String dropdownvalue = 'Kelvin';
  String? selectedValue;
  double _celcius = 0;
  double _output = 0;
  TextEditingController inputCelsius = TextEditingController();

  konversi() {
    setState(() {
      _celcius = double.parse(inputCelsius.text);
      if (dropdownvalue == 'Kelvin') {
        _output = 273.15 + _celcius;
        listViewItem.add("Kelvin : " + _output.toString());
      } else if (dropdownvalue == 'Reamur') {
        _output = 4 / 5 * _celcius;
        listViewItem.add("Reamur : " + _output.toString());
      }
    });
  }

  // ignore: deprecated_member_use
  List<String> listViewItem = <String>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konversi Suhu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Konversi Suhu'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(child: input()),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 15.0),
                      child: dropdown(),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 15.0),
                      child: output(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: submit(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                child: Text(
              "History",
              style: TextStyle(fontSize: 20),
            )),
            Expanded(
                child: ListView(
              children: listViewItem.map((String value) {
                return Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 20),
                    ));
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }

  input() {
    // bagian ini adalah bagian input text dengan satuan celcius yang nantinya akan dikonversi menjadi reamur dan kelvin sesuai dengan rumus konversi suhu
    // bagian keyboardtype menggunakan type number dan inputformatters menggunakan digitonly agar inputan user hanya berupa angka
    return TextFormField(
      controller: inputCelsius,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Masukan Suhu Dalam Celcius',
      ),
    );
  }

  dropdown() {
    return DropdownButton(
      value: dropdownvalue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }

  output() {
    // output disini nilainya akan berubah karena text yang ditampilkan merupakan sebuah variabel
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const Text('Hasil',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Text(
                "$_output",
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ],
    );
  }

  submit() {
    // button submit disini akan menjalankan method konversi yang nantinya akan mengambil nilai input dari textform
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          child: const Text('Conversion'),
          onPressed: () => konversi(),
        ));
  }
}
