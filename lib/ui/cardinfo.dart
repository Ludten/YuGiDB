import 'package:flutter/material.dart';
import 'package:yugidb/models/card.dart';

class NewScreen extends StatelessWidget {
  final YGOcard data;
  final Color color;

  const NewScreen({Key? key, required this.data, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(data.cardName)),
      ),
      backgroundColor: color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(5)),
            Image.network(
              data.imageUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.white, spreadRadius: 3),
                ],
              ),
              child: Column(
                children: [
                  (data.cardType.contains('Spell') ||
                          data.cardType.contains('Trap'))
                      ? const SizedBox()
                      : Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                'Attribute',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                data.attribute ?? 'N/A',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                data.cardType.contains('XYZ')
                                    ? 'Rank'
                                    : 'Level',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                data.cardType.contains('XYZ')
                                    ? 'Rank ${data.cardLevel.toString()}'
                                    : 'Level ${data.cardLevel.toString()}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                  (data.cardType.contains('Spell') ||
                          data.cardType.contains('Trap'))
                      ? const SizedBox()
                      : const SizedBox(
                          height: 10,
                        ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: Colors.black)),
                        child: const Text(
                          'Type',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          data.cardType,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: Colors.black)),
                        child: const Text(
                          'Archetype',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          data.archetype ?? 'N/A',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  (data.cardType.contains('Spell') ||
                          data.cardType.contains('Trap'))
                      ? const SizedBox()
                      : const SizedBox(
                          height: 10,
                        ),
                  (data.cardType.contains('Spell') ||
                          data.cardType.contains('Trap'))
                      ? const SizedBox()
                      : Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                'ATK',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                data.atk.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                'DEF',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                data.def.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                  (data.cardType.contains('Spell') ||
                          data.cardType.contains('Trap') ||
                          !data.cardType.contains('Pendulum'))
                      ? const SizedBox()
                      : const SizedBox(
                          height: 10,
                        ),
                  (data.cardType.contains('Spell') ||
                          data.cardType.contains('Trap') ||
                          !data.cardType.contains('Pendulum'))
                      ? const SizedBox()
                      : Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                'Scale',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                data.cardScale.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: Colors.black)),
                        child: const Center(
                          child: Text(
                            'Card Text',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          data.description,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
