import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/rtsp_stream.dart';
import '../services/rtsp_service.dart';

class AddRtspScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddRtspScreenState();
}

class _AddRtspScreenState extends State<AddRtspScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add RTSP Stream'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(labelText: 'RTSP URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title (optional)'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add Stream'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final rtspUrl = _urlController.text;
      final title = _titleController.text;

      final newStream = RtspStream(url: rtspUrl, title: title.isNotEmpty ? title : _generateTitleFromRTSP(rtspUrl));
      Provider.of<RtspService>(context, listen: false).addStream(newStream);
      Navigator.pop(context);
    }
  }

  String _generateTitleFromRTSP(String rtspUrl) {
    try {
      final uri = Uri.parse(rtspUrl);
      final path = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'Stream';
      return '${uri.host} - $path';
    } catch (e) {
      // Log the error and return a default title
      print('Error parsing RTSP URL: $e');
      return 'Invalid RTSP Stream';
    }
  }
}
