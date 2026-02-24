import 'package:flutter/material.dart';

import 'pages/announcement_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/report_page.dart';
import 'pages/sadaqa_page.dart';
import 'services/auth_service.dart';
import 'services/data_refresh_service.dart';
import 'services/notification_service.dart';

void main() {
  runApp(const MosqueSupportApp());
}

class MosqueSupportApp extends StatelessWidget {
  const MosqueSupportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mosque Support',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A6FFF),
          primary: const Color(0xFF4A6FFF),
          secondary: const Color(0xFF8A52FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FF),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'admin@mosque.app');
  final _passwordController = TextEditingController(text: 'SecurePass123');
  final _otpController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _loading = false;
  String _message = '';
  bool _otpRequested = false;

  Future<void> _requestOtp() async {
    setState(() {
      _loading = true;
      _message = '';
    });

    final result = await _authService.requestOtp(_emailController.text.trim());

    setState(() {
      _loading = false;
      _otpRequested = result.success;
      _message = result.message;
    });
  }

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _message = '';
    });

    final loginResult = await _authService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      otp: _otpController.text.trim(),
    );

    setState(() {
      _loading = false;
      _message = loginResult.message;
    });

    if (!mounted || !loginResult.success) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => MosqueShell(userName: loginResult.userName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A6FFF), Color(0xFF8A52FF)],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Mosque Support Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    TextField(controller: _otpController, decoration: const InputDecoration(labelText: 'OTP')),                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: _loading ? null : _requestOtp,
                          child: const Text('Request OTP'),
                        ),
                        FilledButton(
                          onPressed: _loading || !_otpRequested ? null : _login,
                          child: _loading ? const CircularProgressIndicator() : const Text('Login (2FA)'),
                        ),
                      ],
                    ),
                    if (_message.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(_message, style: const TextStyle(fontSize: 12)),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MosqueShell extends StatefulWidget {
  const MosqueShell({super.key, required this.userName});

  final String userName;

  @override
  State<MosqueShell> createState() => _MosqueShellState();
}

class _MosqueShellState extends State<MosqueShell> {
  int _selectedIndex = 0;
  final _refreshService = DataRefreshService();
  final _notificationService = NotificationService();

  late final List<Widget> _pages = [
    HomePage(
      onPrayerReminder: (message) => _notificationService.push(message),
    ),
    const ReportPage(),
    const AnnouncementPage(),
    const SadaqaPage(),
    ProfilePage(userName: widget.userName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mosque Support'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _refreshService.refreshPage(_selectedIndex);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Reloaded current page: ${_selectedIndex + 1}')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () {
              final msg = _notificationService.peek();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg ?? 'No new notifications')),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.report), label: 'Report'),
          NavigationDestination(icon: Icon(Icons.campaign), label: 'Announcements'),
          NavigationDestination(icon: Icon(Icons.volunteer_activism), label: 'Sadaqa'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
