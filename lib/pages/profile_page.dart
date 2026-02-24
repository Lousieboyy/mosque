import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(userName),
            subtitle: const Text('Role: Administrator'),
          ),
        ),
        const SizedBox(height: 8),
        const Card(
          child: ListTile(
            leading: Icon(Icons.security),
            title: Text('Security Status'),
            subtitle: Text('Password hashing enabled\n2-step verification enabled\nOTP required'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            subtitle: Text('Prayer alerts, reports, and announcements are supported.'),
          ),
        ),
      ],
    );
  }
}
