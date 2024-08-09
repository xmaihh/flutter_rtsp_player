import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rtsp_player/screens/home_screen.dart';
import 'package:flutter_rtsp_player/services/rtsp_service.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  final rtspService = RtspService();
  await rtspService.loadStreams();
  runApp(MyApp(
    rtspService: rtspService,
  ));
}

class MyApp extends StatelessWidget {
  final RtspService rtspService;

  const MyApp({required this.rtspService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: rtspService,
        child: MaterialApp(
          title: 'RTSP Player',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: HomeScreen(),
        ));
  }
}