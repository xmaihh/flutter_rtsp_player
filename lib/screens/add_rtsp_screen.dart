import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/rtsp_stream.dart';
import '../services/rtsp_service.dart';

class AddRtspScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urlController = TextEditingController();

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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newStream = RtspStream(url: _urlController.text);
                    Provider.of<RtspService>(context, listen: false).addStream(newStream);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Stream'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
