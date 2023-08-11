import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:project1/Functions/db_favourite.dart';
import 'package:project1/Functions/db_playlist.dart';
import 'package:project1/Functions/db_playlist_video.dart';
import 'package:project1/screens/home_screen.dart';
import 'package:project1/screens/playing_screen.dart';

import '../model/data_model.dart';

// ignore: must_be_immutable
class ScreenForPlaylist extends StatefulWidget {
  String name;
  int playlistID;
   ScreenForPlaylist({super.key,required this.name,required  this.playlistID});

  @override
  State<ScreenForPlaylist> createState() => _ScreenForPlaylistState();
}

class _ScreenForPlaylistState extends State<ScreenForPlaylist> {
  @override
  void initState() {
    getAllPlaylist();
    getAllPlaylistVideo();
    super.initState();
  }
  String? favouriteButton;
  Widget? favoutiteicon;
  @override
  Widget build(BuildContext context) {
    final b=MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(
              top: 30
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios)),
                  Text(
                    widget.name,
                    style: GoogleFonts.lobster(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    ),
                    
                  ),
                  SizedBox(
                    width: 0.1*b,
                  )
              ],
            ),
            ),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
        ),
         preferredSize: const Size.fromHeight(80)),
         floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),));
          },
           label: Text('Add',style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.white
           ),),
           icon: Icon(Icons.add,
           color: Colors.white,),
           backgroundColor: Colors.black,),
         body: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: playlistVideoNotifier,
                 builder: (BuildContext context, List<PlaylistVideoModel>playlistvideo, child) {
                  if (playlistvideo.isEmpty) {
                    return Center(
                      child: Text('Playlist video is empty',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.black
                      ),),
                    );
                    
                  }
                   return ListView.builder(
                    itemCount: playlistvideo.length,
                    itemBuilder: (_, index) {
                      // if (playlistvideo.isEmpty) {
                      //   Center(child: Text('Video playlist is empty',
                      //   style: GoogleFonts.roboto(
                      //     fontSize: 13,
                      //     color: Colors.black
                      //   ),),);
                        
                      // }
                      if(playlistvideo[index].playlistId==widget.playlistID){
                        final data=playlistvideo[index];
                        var title=data.path.toString().split('/').last;


                        // open box of video model
                        final videoBox=Hive.box<VideoModel>('video_db');
                        VideoModel? videoFound= videoBox.values.firstWhere((element) => element.path==data.path);
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) {
                                return PlayingScreen(videopath: data.path);
                              },
                              ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,left: 10,right: 10
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black,
                              ),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: AssetImage('assets/thumbnail.png'),)
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 0.42*b,
                                      child: Text(title,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.roboto(
                                        fontSize: 19,
                                        color: Colors.white
                                      ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        
                                        if(videoFound.isFavourite==true){
                                          favouriteButton='Remove from favourites';
                                          favoutiteicon= const Icon(Icons.favorite_rounded,
                                          color: Color.fromARGB(255, 252, 97, 97),
                                          );
                                                                                   
                                        }
                                        else{
                                          favouriteButton='Add to favourite';
                                          favoutiteicon=Icon(Icons.favorite_outline,
                                          color: Color.fromARGB(255, 252, 97, 97),);
                                         
                                        }
                                        showDialog(context: context,
                                         builder: (context) => SimpleDialog(
                                          title: Text('Select one ',textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500
                                          ),),
                                          children: [
                                            //add to favourites
                                            SimpleDialogOption(
                                              padding: EdgeInsets.all(8),
                                              onPressed: () {
                                                if(videoFound.isFavourite==true){
                                                  deleteFromFavouritesUsingPath(data.path);
                                                  videoFound.isFavourite==false;
                                                  videoBox.put(videoFound.id, videoFound);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      duration: Duration(seconds: 3),
                                                      backgroundColor: Color.fromARGB(255, 38, 38, 38),
                                                      
                                                      content: Text('Videohas been removed from favorites',
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.roboto(
                                                        color: Color.fromARGB(255, 254, 253, 255),
                                                        fontSize: 0.042*b

                                                      ),)));
                                                }else{
                                                  final favouritePath=data.path;
                                                  final favouriteVideo=
                                                  FavouriteModel(
                                                    path: favouritePath,
                                                  isFavourite: true,
                                                  id: videoFound.id
                                                  
                                                  );
                                                  addToFavourite(favouriteVideo);
                                                  videoFound.isFavourite=true;
                                                  videoBox.put(videoFound.id, videoFound);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: Color.fromARGB(255, 38, 38, 38),
                                                      duration: Duration(seconds: 3),
                                                    content: Text('Video has been added to favourites',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                      color: Color.fromARGB(255, 254, 253, 255),
                                                      fontSize: 0.042*b
                                                    ),
                                                    )
                                                    )
                                                    );
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Color.fromARGB(255, 212, 235, 255),
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 12
                                                      ),
                                                      child: Text(favouriteButton!,
                                                      style: GoogleFonts.roboto(
                                                        color: Color.fromARGB(255, 26, 26, 26),
                                                        fontSize: 19
                                                      ),
                                                      ),
                                                      ),
                                                      favoutiteicon!
                                                  ],
                                                ),
                                              ),
                                            ),
                                            //add to playlist
                                            SimpleDialogOption(
                                              padding: EdgeInsets.all(8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Color.fromARGB(255, 212, 235, 255),
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 12
                                                      ),
                                                      child: Text(
                                                        'Remove from playlist',
                                                        style:GoogleFonts.roboto(
                                                          color: Color.fromARGB(255, 26, 26, 26),
                                                          fontSize: 19

                                                        ) ,
                                                        
                                                      ),
                                                      
                                                      
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                          bottom: 12
                                                        ),
                                                        child: Icon(Icons.minimize),)
                                                      ],
                                                ),
                                              ),
                                              onPressed: (){
                                                Navigator.pop(context);
                                                deleteFromPlaylist(data.id!);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                  duration: Duration(seconds: 3),
                                                  backgroundColor: Color.fromARGB(255, 38, 38, 38),
                                                  content: Text('$title is removed from ${widget.name}',
                                                textAlign: TextAlign.center
                                                ,style: GoogleFonts.roboto(
                                                  color: Color.fromARGB(255, 254, 253, 255),
                                                  fontSize: 0.045*b

                                                ),)));
                                              },
                                            )
                                            
                                          ],
                                         ),
                                         );
                                      },
                                     icon: Icon(Icons.more_vert,
                                     color: Colors.white,)
                                     )
                                  ],
                                ),
                                ),

                              ),
                              ),
                        );
                      }else{
                        return SizedBox(
                          width: 1,
                        );
                      }
                    },);
                 },

                 )
              )
          ],
         ),
    );
  }
}