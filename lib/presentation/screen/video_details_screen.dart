import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsScreen extends StatefulWidget {
  @override
  _VideoDetailsScreenState createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  final videoPlayerController = VideoPlayerController.network(
      'http://localhost/namaz/v1/video/video_1.mp4',
      );

  var chewieController;
  @override
  void initState() {
    super.initState();
    intilize();
  }

  final _url = 'https://flutter.dev';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.lightBrown,
      body: Stack(
        children: [
          Icon(Icons.apps),
          Chewie(
            controller: chewieController,
          ),
        ],
      ),
    );
  }

  void _launchURL() async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  void intilize() async {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      showOptions: false,
      allowFullScreen: false,
      showControlsOnInitialize: true,
    );
    await videoPlayerController.initialize();
  }
}
