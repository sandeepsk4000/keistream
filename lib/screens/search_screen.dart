import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:project1/Functions/db_favourite.dart';
import 'package:project1/Functions/db_functions.dart';
import 'package:project1/screens/playing_screen.dart';

import '../model/data_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
String? favouriteButton;
Widget? favouriteicon;
String search= '';
  @override
  Widget build(BuildContext context) {
    final b=MediaQuery.of(context).size.width;
    final h=MediaQuery.of(context).size.height;
    List findlist=[];

    return Scaffold(
      
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(80),
        
        child:  AppBar(
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(20),bottomStart: Radius.circular(20))),
          centerTitle: true,
          title: Padding(padding: const EdgeInsets.only(
            top: 8,left: 5,right: 5
          ),child: TextField(
            autocorrect: true,
            textAlign: TextAlign.center,
            maxLines: 1 ,
            style: GoogleFonts.roboto(
              fontSize: 20,color: Colors.white
            ),
            onChanged: (value) => setState(() {
              search=value;
              
            }),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(225,212,235, 255),width: 1.0
                ),
                
                
              ),
              focusedBorder: UnderlineInputBorder(
                
                borderSide: BorderSide(color: Color.fromARGB(255,181,220, 254),width: 1.5)
              ),
              hintText: 'Search here',
              hintStyle: TextStyle(
                color: Color.fromARGB(255,212, 235, 255),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
            ),
          ),),
          backgroundColor: Colors.black,
        ), 
        ),
        body: SafeArea(
          child:ValueListenableBuilder(
            valueListenable: videoListNotifier, 
            builder: (BuildContext context, List<VideoModel>videoList, child) {
             if(videoList.isEmpty){
              return const Center(
                child: Text('No video found'),
              );
             } 
             if (search.isEmpty) {
              findlist=videoList;
               
             }else{
              findlist=videoList.where((element) => element.path.toString().split('/').last.toString().toLowerCase().contains(search.toLowerCase())).toList();
              
             }
             if (findlist.isEmpty) {
              return const Center(
                child: Text('No video found'),
              );
               
             }
             return ListView.builder(
              itemBuilder: ((_,int index){
                final data=findlist[index];
                var title=data.path.toString().split('/').last;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                      return PlayingScreen(videopath: data.path);
                    },
                    )
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                    child: Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black
                      ) ,
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
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
                                image: const DecorationImage(
                                  image: AssetImage('assets/thumbnail.png'))
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
                          ),),

                        ),
                        IconButton(
                          onPressed: (){
                          if (data.isFavourite==true) {
                            favouriteButton='Remove from favourites';
                            favouriteicon=const Icon(Icons.favorite_rounded,
                            color: Color.fromARGB(255, 252, 97, 97),);
                            
                          }else{
                            favouriteButton='Add to favourites';
                            favouriteicon=const Icon(Icons.favorite_outline,
                            color:Color.fromARGB(255, 252, 97, 97)
                            );
                          }
                          showDialog(
                            context: context,
                             builder: (context) => SimpleDialog(
                              title:  Text('Select one',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w500
                              )),
                              children: [
                                SimpleDialogOption(
                                  padding: const EdgeInsets.all(8),
                                  onPressed: (){
                                    if(data.isFavourite=true){
                                      deleteFromFavourites(data.id);
                                      final videoBox=Hive.box<VideoModel>('Video_db');
                                      final VideoModel video=videoBox.get(index)!;
                                      video.isFavourite=false;
                                      videoBox.put(index,video);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Video has been removed from favourites',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            color: Color.fromARGB(255, 254, 253, 255)
                                          ),
                                          ),
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Color.fromARGB(255, 38, 38, 38) ,
                                          )
                                          );
                                    }
                                    else{
                                      final favouritePath=data.path;
                                      final favouriteVideo=FavouriteModel(
                                        path: favouritePath,isFavourite: true,id: data.id
                                      );
                                      addToFavourite(favouriteVideo);
                                      final videoBox=Hive.box<VideoModel>('video_db');
                                      VideoModel video=videoBox.get(index)!;
                                      video.isFavourite=true;
                                      videoBox.put(index,video);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Color.fromARGB(255, 38, 38, 38),
                                          content: Text('Video has been added to favourites',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color:  Color.fromARGB(255, 254, 253, 255),
                                            fontSize: 0.042*b,
                                          ),),
                                          duration: const Duration(seconds: 3),
                                          )
                                          );
                                    
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                    color: const Color.fromARGB(255, 212, 235, 255),
                                    
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            
                                            
                                          ),
                                          child: Text(favouriteButton!,
                                          style: GoogleFonts.roboto(
                                            color: const Color.fromARGB(255, 26, 26, 26),
                                            fontSize: 19
                                          ),),),
                                          favouriteicon!
                                      ],
                                    ),
                                  ),
                                  
                                ),
                                
                              ],
                             ),);

                        },
                         icon: Icon(Icons.more_vert,
                         color: Colors.white,))
                      ],
                    ),

                      ),
                      


                      
                    )
                    
                    
                    ),
                );
              }),
              itemCount: findlist.length,
              );

            },) ),
      
    
    );
  }
}