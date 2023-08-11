import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/data_model.dart';

ValueNotifier<List<VideoModel>> videoListNotifier = ValueNotifier([]);
List checklist = [];
//add video to database!!!
Future<void> addVideo(VideoModel value) async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  if (checklist.contains(value.path)) {
    //allready added
  } else {
    final id = await videoDB.add(value);
    value.id = id;
    videoDB.put(id, value);
  }
}
//get videos from database!!!

Future<void> getAllVideos() async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  videoListNotifier.value.clear();
  videoListNotifier.value.addAll(videoDB.values);
  videoListNotifier.notifyListeners();
  //print all videos through notify listeners!!!
}

Future<void> deleteDatabase() async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  await videoDB.clear();
}

Future<void> checkVideo() async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  for (var video in videoDB.values) {
    checklist.add(video.path);
  }
}
