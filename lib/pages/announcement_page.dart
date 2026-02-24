import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = [
      'Community iftar this Friday at 6:00 PM.',
      'Quran class registration opens tomorrow.',
      'Parking area section B closed for cleaning.',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: announcements.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.campaign),
          title: Text('Announcement ${index + 1}'),
          subtitle: Text(announcements[index]),
        ),
      ),
    );
  }
}
