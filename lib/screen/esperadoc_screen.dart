import 'package:flutter/material.dart';

class EsperaDocScreen extends StatelessWidget {
  static const name = 'EsperaDocScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Esperando confirmación',
                style: TextStyle(
                  fontFamily: 'InknutAntiqua',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Esto puede demorar un tiempo',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Icon(
                Icons.lock_clock_rounded,
                size: 300,
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 30),
              const Text(
                'Revisaremos tu número de matrícula para comprobar tu doctorado',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
