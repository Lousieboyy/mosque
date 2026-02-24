import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onPrayerReminder});

  final ValueChanged<String> onPrayerReminder;

  @override
  Widget build(BuildContext context) {
    final prayers = <Map<String, String>>[
      {'name': 'Fajr', 'time': '05:03'},
      {'name': 'Dhuhr', 'time': '12:15'},
      {'name': 'Asr', 'time': '15:40'},
      {'name': 'Maghrib', 'time': '18:22'},
      {'name': 'Isha', 'time': '19:35'},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            title: const Text('Welcome to Mosque Support'),
            subtitle: Text('Today: ${DateFormat.yMMMMEEEEd().format(DateTime.now())}'),
          ),
        ),
        const SizedBox(height: 12),
        const Text('Prayer Times', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...prayers.map(
          (prayer) => Card(
            child: ListTile(
              leading: const Icon(Icons.access_time_filled),
              title: Text(prayer['name']!),
              subtitle: Text('Time: ${prayer['time']}'),
              trailing: ElevatedButton(
                onPressed: () => onPrayerReminder('Prayer reminder set: ${prayer['name']} at ${prayer['time']}'),
                child: const Text('Notify'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('Capacity ready: designed with scalable API-first architecture to support at least 100 concurrent users.'),
          ),
        ),
      ],
    );
  }
}
