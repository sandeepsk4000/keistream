import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:project1/Functions/db_favourite.dart';
import 'package:project1/screens/home_screen.dart';
import 'package:project1/screens/playing_screen.dart';

import '../model/data_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    getAllFavourites();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height;
    final b=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text('favourites',style:GoogleFonts.lobster(
            color: Colors.white,fontSize: 35
          )),
          centerTitle: true,
          backgroundColor: Colors.black,
          shadowColor: null,
          toolbarHeight: 100,
          shape:const  RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(20),bottomStart: Radius.circular(20))),
        
          
        
           
          ),
      ),
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
              valueListenable: favouriteListNotifier,
               builder: (BuildContext context, List<FavouriteModel>videoList, child) {
                if (videoList.isEmpty) {
                  return Center(
                    child: Text('Favourite list is empty ',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.black

                    ),),
                  );

                  
                }
                return ListView.builder(
                  itemBuilder: (_, index) {
                    final data=videoList[index];
                    var title=data.path.toString().split('/').last;
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayingScreen(videopath: data.path),
                          ),
                        );
                      },
                      child: Padding(
                        padding:const EdgeInsets.only(
                          top: 10,left: 10,right: 10
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 17, 15, 15),
                          ),height: 80,
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
                                        image: DecorationImage(
                                          image: AssetImage('assets/thumbnail.png'))
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(width: 150,
                                child: Text(title,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 18,
                                  
                                ),
                                ),
                                ),
                                IconButton(
                                  onPressed: (){
                                  showDialog(
                                    context: context,
                                   builder: (context) => SimpleDialog(
                                    title: Text('Select One',style: GoogleFonts.roboto(
                                      fontSize: 24,
                                      color: Colors.black
                                    ),),
                                    children: [
                                      SimpleDialogOption(
                                        padding: const EdgeInsets.all(8),
                                        onPressed: () {
                                          deleteFromFavourites(data.id!);
                                          final videoBox=Hive.box<VideoModel>('video_db');
                                          VideoModel video=videoBox.get(data.id)!;
                                          video.isFavourite=false;
                                          videoBox.put(data.id, video);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            backgroundColor: Color.fromARGB(255, 38, 38, 38),
                                            
                                            content: Text('Video has been removed from favourites',textAlign: TextAlign.center,style: GoogleFonts.roboto(
                                            fontSize: 0.042*b,color: Colors.black
                                          ),),
                                          duration: Duration(seconds: 3),),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                          color: const Color.fromARGB(255, 212, 235, 255),
                                          
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              child: Text('Remove from favourites',
                                              style: GoogleFonts.roboto(
                                                color: Color.fromARGB(255, 26, 26, 26),
                                                fontSize: 19
                                              ),),),
                                              Icon(Icons.favorite_rounded,
                                              color: Color.fromARGB(255, 252, 97, 97),)


                                            ],
                                          ),

                                        ),

                                      )
                                    ],

                                   ),);
                                }, icon:Icon(Icons.more_vert,color: Colors.white,) )

                              ],
                            ),),
                        ),
                         ),
                      
                    );
                    
                  },
                  itemCount: videoList.length
                  ,
                  );
                  
                 
               },
               ),
               ),
        ],
      ),
    );
  }
}