import 'package:flutter/material.dart';

class MyListWidget extends StatelessWidget {
  const MyListWidget({super.key, required this.items, required this.callback});

  final List items;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    // Llista d’exemple amb separadors
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.label_outline),
            title: Text(items[index]["titol"]),
            subtitle: Text(items[index]["director"]),
            onTap: () {
              callback(items[index]);
            },
          );
        },
      ),
    );
  }
}
