import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randon Number Generator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Random Number Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _random = new Random();

  int validated = 0;
  int num = 0;
  int min = 1;
  int max = 6;

  final minController = TextEditingController();
  final maxController = TextEditingController();

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  void _incrementCounter() {

    if (minController.text.isEmpty || maxController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Both text fields must be filled with valid numbers'),
          backgroundColor: Colors.deepPurple,
        )
      );
    }

    int? nmin = int.tryParse(minController.text);
    int? nmax = int.tryParse(maxController.text);

    if (nmin == null || nmax == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Both min and max text fields must be valid integers'),
          backgroundColor: Colors.deepPurple,
        )
      );
    } else if (nmin > nmax) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Min value must be lesser than max'),
          backgroundColor: Colors.deepPurple,
        )
      );
    } else {
      min = nmin;
      max = nmax;
      setState(() {
        num = min + _random.nextInt(max - min);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical:128.0),
              child: Text(
                '$num',
                style: TextStyle(fontSize:64.0),
                //Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Min',
                ),
                controller: minController
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Max',
                ),
                controller: maxController
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Generate',
        child: const Text("Next")
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
