import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/screens/video_player.dart';
import 'package:video_player/video_player.dart';

List videos = [];
var pathvideo;

class PlayingScreen extends StatefulWidget {
  final videopath;
  const PlayingScreen({super.key, required this.videopath});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  @override
  Widget build(BuildContext context) {
    pathvideo = widget.videopath;
    final videoplayerwidget = VideoPlayerWidget(
        videoplayercontroller: VideoPlayerController.file(File(pathvideo)));
    var title = pathvideo.toString().split('/').last;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: FittedBox(
            child: Stack(
          children: [
            videoplayerwidget,
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Text(
                  title,
                  style: GoogleFonts.roboto(fontSize: 25, color: Colors.white),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
