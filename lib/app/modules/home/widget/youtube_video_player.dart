import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const YoutubeVideoPlayerScreen({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _YoutubeVideoPlayerScreenState createState() =>
      _YoutubeVideoPlayerScreenState();
}

class _YoutubeVideoPlayerScreenState extends State<YoutubeVideoPlayerScreen> {
  late YoutubePlayerController _controller;

  String? value;

  @override
  void initState() {
    super.initState();
    value = _cleanId(widget.videoUrl) ?? "";
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: false,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    _controller.loadPlaylist(
      list: [value ?? "", ""],
      listType: ListType.playlist,
      index: 0,
      startSeconds: 136,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.close();
    super.dispose();
  }

  String? _cleanId(String source) {
    if (source.startsWith('http://') || source.startsWith('https://')) {
      return YoutubePlayerController.convertUrlToId(source);
    }
    return source;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
