import 'package:flutter/material.dart';

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
                    // Save the RTSP URL
                    // Navigator.pop(context);
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
