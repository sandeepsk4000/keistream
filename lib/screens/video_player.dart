import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart' show BuildContext, Colors, Container, EdgeInsets, FontWeight, State, StatefulWidget, Text, TextStyle, Widget;
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController videoplayercontroller;
  const VideoPlayerWidget({super.key, required this.videoplayercontroller});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late ChewieController _chewieController;
  @override
  void initState() {
    

    _chewieController = ChewieController(
      videoPlayerController: widget.videoplayercontroller,
      aspectRatio: 9/16,
      autoPlay: true,
      looping: true,allowFullScreen: true,
      fullScreenByDefault: true,
      subtitle: Subtitles([
        Subtitle(
          index: 0,
           start: Duration.zero,
            end: const Duration(seconds: 3), 
            text: 'flutter video player'),
            Subtitle(
          index: 1,
           start:const Duration(seconds: 4),
            end: const Duration(seconds: 7), 
            text: 'flutter video player'),
            Subtitle(
          index: 1,
           start:const Duration(seconds: 8),
            end: const Duration(seconds: 11), 
            text: 'flutter video player'),
            Subtitle(
          index: 1,
           start: const Duration(seconds: 12),
            end: const Duration(seconds: 15), 
            text: 'flutter video player')
      ]),
      subtitleBuilder: (context, subtitle) => Container(
        width: 100,
        padding:  const EdgeInsets.only(
          //left: 30,
          bottom: 100
        ),
        child: Text(subtitle,
        style: const TextStyle(
          backgroundColor: Colors.black,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),

      ),
      
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.videoplayercontroller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}
