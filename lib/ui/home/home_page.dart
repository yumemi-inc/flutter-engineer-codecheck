import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: リポジトリから取得する
    final listItems = ['item1', 'item2', 'item3'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Enter keyword',
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listItems[index]),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: listItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
