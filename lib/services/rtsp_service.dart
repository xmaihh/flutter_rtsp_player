import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/rtsp_stream.dart';

class RtspService extends ChangeNotifier {
  final List<RtspStream> _streams = [];
  final String _storageKey = 'rtsp_streams';

  List<RtspStream> get streams => _streams;

  Future<void> addStream(RtspStream stream) async {
    _streams.add(stream);
    await _saveStreams();
    notifyListeners();
  }

  Future<void> removeStream(RtspStream stream) async {
    _streams.removeWhere((s) => s.url == stream.url);
    await _saveStreams();
    notifyListeners();
  }

  Future<void> loadStreams() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _streams.clear();
      _streams.addAll(jsonList.map((json) => RtspStream.fromJson(json)).toList());
      notifyListeners();
    }
  }

  Future<void> _saveStreams() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _streams.map((stream) => stream.toJson()).toList();
    prefs.setString(_storageKey, json.encode(jsonList));
  }
}
