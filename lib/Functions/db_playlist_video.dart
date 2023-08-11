import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project1/Functions/db_playlist.dart';
import 'package:project1/model/data_model.dart';


ValueNotifier<List<PlaylistVideoModel>>playlistVideoNotifier=ValueNotifier([]);

Future<void> addtoPlaylist(PlaylistVideoModel value) async{
  final playlistVideoDB=await Hive.openBox<PlaylistVideoModel>('playlistvideo_db');
  final id=await playlistVideoDB.add(value);
  value.id=id;
  playlistVideoDB.put(id, value);
}

Future<void> getAllPlaylistVideo()async{
  final playlistVideoDB=await Hive.openBox<PlaylistVideoModel>('playlistvideo_db');
  playlistVideoNotifier.value.clear();
  playlistVideoNotifier.value.addAll(playlistVideoDB.values);
  playlistNotifier.notifyListeners();
}
Future<void>deleteFromPlaylist(int id)async{
  final playlistVideoDB=await Hive.openBox<PlaylistVideoModel>('playlistvideo_db');
  PlaylistVideoModel playlistvideo=playlistVideoDB.values.firstWhere((playlistvideo) => playlistvideo.id==id);
  playlistVideoDB.delete(playlistvideo.id);
  await getAllPlaylistVideo();
}