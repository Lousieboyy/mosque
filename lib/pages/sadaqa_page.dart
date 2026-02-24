import 'package:flutter/material.dart';

class SadaqaPage extends StatelessWidget {
  const SadaqaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Sadaqa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Card(
          child: ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Monthly Food Program'),
            subtitle: Text('Help provide meals for families in need.'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.school),
            title: Text('Youth Education Fund'),
            subtitle: Text('Support classes and learning resources.'),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Online payment integration placeholder.')),
            );
          },
          icon: const Icon(Icons.payments),
          label: const Text('Contribute Now'),
        ),
      ],
    );
  }
}
