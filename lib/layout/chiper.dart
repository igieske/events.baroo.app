import 'package:flutter/material.dart';


class Chiper extends StatelessWidget {
  final List<String> children;
  const Chiper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('AlertDialog Title'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: [],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(3),
          child: Wrap(
            children: children.map((String value) {
              return ChiperItem(
                value: value,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ChiperItem extends StatelessWidget {
  final String value;

  const ChiperItem({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(3),
      child: Text(value),
    );
  }
}

