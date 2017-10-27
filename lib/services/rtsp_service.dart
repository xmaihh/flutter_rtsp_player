import '../models/rtsp_stream.dart';

class RtspService {
  final List<RtspStream> _streams = [];

  List<RtspStream> get streams => _streams;

  void addStream(RtspStream stream) {
    _streams.add(stream);
  }

  void removeStream(RtspStream stream) {
    _streams.remove(stream);
  }
}
