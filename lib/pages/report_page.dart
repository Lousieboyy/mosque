import 'package:flutter/material.dart';

import '../models/report_item.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<ReportItem> _reports = [];

  void _simulateVoiceToText() {
    setState(() {
      _descriptionController.text =
          'Voice transcript: Water dispenser in prayer hall needs maintenance.';
    });
  }

  void _submit() {
    if (_titleController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      _reports.insert(
        0,
        ReportItem(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          createdAt: DateTime.now(),
          voiceSource: _descriptionController.text.contains('Voice transcript'),
        ),
      );
      _titleController.clear();
      _descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Report Issue', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
        const SizedBox(height: 8),
        TextField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: _simulateVoiceToText,
              icon: const Icon(Icons.mic),
              label: const Text('Voice to Text'),
            ),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              label: const Text('Submit Report'),
            ),
          ],
        ),
        const Divider(height: 24),
        const Text('Recent Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ..._reports.map(
          (report) => Card(
            child: ListTile(
              title: Text(report.title),
              subtitle: Text('${report.description}\n${report.createdAt}'),
              trailing: report.voiceSource ? const Icon(Icons.record_voice_over) : null,
            ),
          ),
        ),
      ],
    );
  }
}
