import 'dart:async';

import 'package:fisica_01/variables.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PhysiCanva());
  }
}

class PhysiCanva extends StatefulWidget {
  const PhysiCanva({Key? key}) : super(key: key);

  @override
  State<PhysiCanva> createState() => _PhysiCanvaState();
}

class _PhysiCanvaState extends State<PhysiCanva> {
  @override
  void initState() {
    if (updating == true) {
      Timer.periodic(
        const Duration(milliseconds: 35),
        (timer) {
          setState(() {
            segundos = segundos + 0.035;
            deslocamento = (gravidade * segundos * segundos) / 2;
            velocidade = gravidade * segundos;
            alturaRestante = altura - deslocamento;
            enpotencial = massa * gravidade * alturaRestante;
            encinetica = (massa * velocidade * velocidade) / 2;

            if (deslocamento >= 500) {
              timer.cancel();
              Timer.periodic(const Duration(milliseconds: 35), (timer) {
                setState(() {
                  segundos2 = segundos2 + 0.035;
                  deslocamento2 = altura -
                      (velocidade * segundos2) +
                      (gravidade * segundos2 * segundos2) / 2;
                });
              });
            }
          });
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Center(
            child: Stack(
          children: [
            const PhyFloor(),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black)),
                height: size.height * 0.8,
                width: size.width * 0.95,
                child: Stack(
                  children: [PhysicsAnimation(), PhysicsAnimation2()],
                )),
          ],
        )),
        Row(
          children: [
            const SizedBox(
              width: 32,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Segundos: ' + segundos.toStringAsFixed(2) + ' s'),
                Text('Deslocamento: ' + deslocamento.toStringAsFixed(2) + ' m'),
                Text('velocidade: ' + velocidade.toStringAsFixed(2) + ' m/s'),
              ],
            ),
            const SizedBox(
              width: 32,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('En. Cinética: ' + encinetica.toStringAsFixed(2) + ' J'),
                Text('En. Ptncial Grav.: ' +
                    enpotencial.toStringAsFixed(2) +
                    ' J'),
                Text('Massa: ' + massa.toStringAsFixed(2) + ' Kg'),
              ],
            ),
          ],
        )
      ]),
    );
  }
}

class PhysicsAnimation extends StatefulWidget {
  const PhysicsAnimation({Key? key}) : super(key: key);

  @override
  _PhysicsAnimation createState() => _PhysicsAnimation();
}

class _PhysicsAnimation extends State<PhysicsAnimation>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Positioned(
        top: deslocamento,
        left: size.width / 2 - 85,
        height: 10,
        width: 10,
        child: Container(
          color: Colors.redAccent,
        ),
      ),
    ]);
  }
}

class PhyFloor extends StatelessWidget {
  const PhyFloor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 500,
      left: 0,
      right: 0,
      height: 100,
      child: Container(
        color: Colors.amberAccent,
      ),
    );
  }
}

class PhysicsAnimation2 extends StatefulWidget {
  const PhysicsAnimation2({Key? key}) : super(key: key);

  @override
  _PhysicsAnimation2 createState() => _PhysicsAnimation2();
}

class _PhysicsAnimation2 extends State<PhysicsAnimation2>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Positioned(
        top: deslocamento2,
        left: size.width / 2 + 60,
        height: 10,
        width: 10,
        child: Container(
          color: Colors.blueAccent,
        ),
      ),
    ]);
  }
}
