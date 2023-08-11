import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project1/model/data_model.dart';
import 'package:project1/screens/bottom_navigation_bar.dart';
import 'package:fetch_all_videos/fetch_all_videos.dart';

import '../Functions/db_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    notifylisteners();
    super.initState();
    

    Future.delayed(Duration(seconds: 10)).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomNavigationBar1(),
      ));
    });
  }

  Future notifylisteners() async {
    await getVideos();
    getAllVideos();
  }

  getVideos() async {
    await checkVideo();
    FetchAllVideos ob = FetchAllVideos();
    List videos = await ob.getAllVideos();
    for (var i = 0; i < videos.length; i++) {
      String path = videos[i];
      final video = VideoModel(path: path);
      addVideo(video);
      

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    child: Padding(padding: EdgeInsets.only(right: 10)),
                    maxRadius: 250.0,
                    backgroundImage: AssetImage(
                        'assets/_27fde0b2-1752-41cf-af61-2ffc9038a182.jpeg.jpg'),
                  )),
              // Image(

              //   image: AssetImage(
              //       'assets/_27fde0b2-1752-41cf-af61-2ffc9038a182.jpeg.jpg'),
              //   width: 200,
              // ),

              SizedBox(
                height: 60,
                child: SpinKitWaveSpinner(
                  //waveColor: Colors.purple,
                  color: Colors.cyan,
                  size: 100.0,
                ),
              )
            ],
          ),
        ));
  }
}
