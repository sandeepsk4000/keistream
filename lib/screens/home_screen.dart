import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:project1/Functions/db_favourite.dart';
import 'package:project1/Functions/db_playlist.dart';
import 'package:project1/Functions/db_playlist_video.dart';
import 'package:project1/screens/playing_screen.dart';

import '../Functions/db_functions.dart';
import '../model/data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getAllPlaylist();
    getAllFavourites();
    super.initState();
  }




  String? favouriteButton;
  Widget? favouriteicon;
  
  @override
  Widget build(BuildContext context) {
    final b = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Kei',
              style: GoogleFonts.lobster(color: Colors.white, fontSize: 35)),
          centerTitle: true,
          backgroundColor: Colors.black,
          shadowColor: null,
          toolbarHeight: 100,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(20),
                  bottomStart: Radius.circular(20))),
         
          leading: IconButton(
              onPressed: () {
                if (scaffoldkey.currentState!.isDrawerOpen) {
                  scaffoldkey.currentState!.closeDrawer();
                  //close drawer,if drawer is open
                } else {
                  scaffoldkey.currentState!.openDrawer();
                }
              },
              icon: const Padding(
                padding: EdgeInsets.only(top: 5, left: 18),
                child: Icon(Icons.menu),
              )),
        ),
        drawer: Drawer(
          width: 0.65 * b,
          child: Container(
            color: const Color.fromARGB(255, 212, 235, 255),
            child: ListView(
              children: [
                DrawerHeader(
                    child: Center(
                  child: Text(
                    'kei',
                    style:
                        GoogleFonts.lobster(fontSize: 35, color: Colors.black),
                  ),
                )),
                ListTile(
                  iconColor: Colors.black,
                  leading: const Icon(Icons.info_outline),
                  title: Text(
                    'About Kei',
                    style: GoogleFonts.roboto(fontSize: 19),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                       builder: (context) => SizedBox(
                        width: 0.9*b,
                        height: 0.8*h,
                        child: SimpleDialog(
                          title: Text('About Kei',
                          softWrap: true,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            
                          ),
                          textAlign: TextAlign.center,),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5
                              ),
                              child: SizedBox(
                                height: 0.45*h,
                                width: 0.9*b,
                                child: SingleChildScrollView(
                                  child: Text(
                                    aboutUserText()!,
                                    style: GoogleFonts.roboto(
                                      fontSize: 16
                                    ),
                                  ),
                                ),
                              ),),
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                 child: Text('Dismiss',
                                 style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 77, 49, 137)
                                 ),))
                          ],

                        )
                       ),);


                  },
                ),
                ListTile(
                  iconColor: Colors.black,
                  leading: const Icon(Icons.lock_outline),
                  title: Text(
                    'Privacy Policy',
                    style: GoogleFonts.roboto(fontSize: 19),
                  ),
                  onTap: () {
                    showDialog(context: context,
                     builder: (context) => SizedBox(
                      width: 0.9*b,
                      height: 0.8*h,
                      child: SimpleDialog(
                        title: Text('Privacy policy',
                        softWrap: true,
                        style: GoogleFonts.roboto(
                          fontSize: 20
                        ),
                        textAlign: TextAlign.center,),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5
                            ),
                            child: SingleChildScrollView(
                              child: Text(privacytext()!,
                              style: GoogleFonts.roboto(
                                fontSize: 16
                              ),
                              )
                              ,
                              
                            ),
                            
                            ),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            },
                             child: Text('Dismiss',style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Color.fromARGB(255, 77, 49, 137)
                             ),))
                        ],
                        
                      ),
                     ),);
                  },
                ),
                ListTile(
                  iconColor: Colors.black,
                  leading: const Icon(Icons.notes_outlined),
                  title: Text(
                    'Terms & Conditions',
                    style: GoogleFonts.roboto(fontSize: 19),
                  ),
                  onTap: () {
                    showDialog(context: context,
                     builder: (context) => SizedBox(
                      width: 0.9*b,
                      height: 0.8*h,
                      child: SimpleDialog(
                        title: Text('Terms & Condition',
                        softWrap: true,
                        style: GoogleFonts.roboto(
                          fontSize: 20
                        ),
                        textAlign: TextAlign.center,),
                        children: [
                          Padding(padding: EdgeInsets.only(
                            left: 10,right: 10,
                            top: 5
                          ),
                          child: SizedBox(
                            height: 0.6*h,
                            width: 0.9*b,
                            child: SingleChildScrollView(
                              child: Text(termsandcondText()!,
                              style: GoogleFonts.roboto(
                                fontSize: 16
                              ),
                                
                              ),
                            ),

                          ),),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          },
                           child: Text('Dismiss',
                           style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Color.fromARGB(255, 77, 49, 137)
                           ),))
                        ],
                      ),
                     ),
                     );
                  },
                ),
                SizedBox(
                  height: 0.25*h,
                ),
                Center(
                  child: Text('Version 1.0.0',
                  style: TextStyle(
                    fontSize: 15
                  ),),
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: videoListNotifier,
              builder: (BuildContext context,
               List<VideoModel> videoList, child) {
                return ListView.builder(
                  itemBuilder: (_, int index) {
                  final data = videoList[index];
                  var title = data.path.toString().split("/").last;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                          return PlayingScreen(videopath: data.path);
                        }),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:const  Color.fromARGB(255, 17, 1, 1)),
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
                                        image:const DecorationImage(
                                            image: AssetImage(
                                                'assets/thumbnail.png'))),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 0.42 * b,
                                child: Text(
                               
                               
                                  title,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.roboto(fontSize: 19,color: Colors.white),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if(data.isFavourite==true){
                                      favouriteButton='Remove from favourites';
                                      favouriteicon=const Icon(Icons.favorite_rounded,
                                      color: Color.fromARGB(255, 252, 97, 97),
                                      );
                                    }else{
                                      favouriteButton='Add to Favourites';
                                      favouriteicon=const Icon(Icons.favorite_outline,
                                      color: Color.fromARGB(255, 252, 97, 97),
                                      );
                                    }
                                    showDialog(context: context,
                                     builder: (context) => SimpleDialog(
                                       title:  Text('Select One',
                                       textAlign: TextAlign.center,
                                       style: GoogleFonts.roboto(
                                        fontSize: 24,fontWeight: FontWeight.w500
                                       ),),
                                       children: [
                                        SimpleDialogOption(
                                          padding: const EdgeInsets.all(8),
                                          onPressed: () {
                                            if(data.isFavourite==true){
                                              deleteFromFavourites(data.id!);
                                              final videoBox=Hive.box<VideoModel>('video_db');
                                              VideoModel video=videoBox.get(index)!;
                                              video.isFavourite=false;
                                              videoBox.put(index, video);
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                backgroundColor:Color.fromARGB(255, 38, 38, 38) ,
                                                content: Text(
                                                  'Video has been removed from favourites',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.roboto(
                                                    color: const Color.fromARGB(255, 254, 253, 255),
                                                    fontSize: 0.042*b
                                                  ),
                                                  // style: TextStyle(
                                                  //   color: const Color.fromARGB(255, 254, 253, 255),
                                                  //   fontSize: 0.042*b,
                                                    
                                                  // ),
                                                ),
                                                duration: const Duration(seconds: 3),
                                              ));
                                            }else{
                                              final favouritePath=data.path;
                                              final favouriteVideo=FavouriteModel(
                                                path: favouritePath,isFavourite: true,id: data.id
                                              );
                                              addToFavourite(favouriteVideo);
                                              final videoBox=Hive.box<VideoModel>('Video_db');
                                              VideoModel video=videoBox.get(index)!;
                                              video.isFavourite=true;
                                              videoBox.put(index, video);
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(backgroundColor: Color.fromARGB(255, 38, 38, 38),
                                                  content: Text('Video has been added to favourites',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.roboto(
                                                   color: Color.fromARGB(255, 254, 253, 255),
                                                    fontSize: 0.042*b,

                                                  ),),duration: Duration(seconds: 3),
                                                  ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Color.fromARGB(255, 212, 235, 255),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: Text(favouriteButton!,
                                                style: GoogleFonts.roboto(
                                                  color: Color.fromARGB(255, 26, 26, 26),
                                                  fontSize: 19,
                                                ),),),
                                                favouriteicon!
                                              ],
                                            ),
                                          ),
                                        ),
                                        //  Add to playlist
                                        SimpleDialogOption(
                                          padding: EdgeInsets.all(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Color.fromARGB(255, 212, 235, 255),
                                            ),
                                            padding: EdgeInsets.all(10),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                                  child: Text('Add to playlist',
                                                  style: GoogleFonts.roboto(
                                                    color: Color.fromARGB(255, 26, 26, 26),
                                                    fontSize: 19
                                                  ),
                                                  ),
                                                  ),
                                                  Icon(Icons.add)
                                              ]
                                              ),
                                          ),
                                          onPressed: (){
                                            Navigator.pop(context);
                                            showModalBottomSheet(
                                              backgroundColor: Color.fromARGB(255, 212, 235, 255),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15)),
                                            
                                              context: context, 
                                            builder: (context) {
                                              return Padding(
                                                padding: EdgeInsets.only(top: 25,
                                                left: 18,
                                                right: 18),
                                                child: Column(
                                                  children: [
                                                    Text('Add to playlist',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black
                                                    ),
                                                    ),
                                                    const SizedBox(height: 20,),
                                                    Expanded(
                                                      child:ValueListenableBuilder(
                                                        valueListenable: playlistNotifier,
                                                         builder: ( BuildContext context,List<PlaylistModel>playList,child) {
                                                          return ListView.builder(
                                                            itemBuilder: (_, int index) {
                                                              final data1=playList[index];
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  final model=PlaylistVideoModel(path: data.path,playlistId: data1.playlistId,isFavourite: data.isFavourite,name: data1.name);
                                                                  checkVideo(model);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(bottom: 10),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(5),color: Colors.white,

                                                                    ),
                                                                    height: 0.06*h,
                                                                    width: 0.7*b,
                                                                    child: Center(
                                                                      child: Text(data1.name!,
                                                                      style: GoogleFonts.roboto(
                                                                        fontSize: 19,
                                                                        color: Colors.black,
                                                                      ),),
                                                                    ),
                                                                    
                                                                  ),
                                                                  ),
                                                              );
                                                              
                                                            },
                                                            itemCount: playList.length,
                                                            );
                                                           
                                                         },) 
                                                  )
                                                  ],
                                                ),
                                                );
                                            },);
                                          },

                                        )
                                        
                                       ],
                                     ),
                                     
                                     );


                                  }, icon: Icon(Icons.more_vert,color: Colors.white,)
                                  ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount:videoList.length ,
                );
              },
            )
            )
          ],
        ),
      ),
    );
  }
  void checkVideo(PlaylistVideoModel model)async{
    final playlistVideoDB=await Hive.openBox<PlaylistVideoModel>('playlistvideo_db');
    final List<PlaylistVideoModel>playlistvideos=playlistVideoDB.values.toList();
    for(var video in playlistvideos){
      if(video.path==model.path&&video.playlistId==model.playlistId){
        showDialog(
          context: context,
         builder: (context) => SimpleDialog(
          children: [
            Padding(
              padding: EdgeInsets.all(14),
              child: Text('The video is already in ${model.name} playlist',
              style:GoogleFonts.roboto(
                fontSize: 20,
              ) ,
              ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.black ),
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: Text('ok, got it',
                  style: GoogleFonts.roboto(
                    fontSize: 18
                  ),
                  )
                  )
                  ,)
          ],
         ),);
         print('this video is already in the playlist');
         return;
      }
      
    }
    addtoPlaylist(model);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 38, 38, 38),
        content: Text('Video has been added to${model.name}',
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: 18,color: Color.fromARGB(255, 254, 253, 255)
        ),
        )
        ),
        );
  }
  String? privacytext(){
    return 'Introduction : \n This  privacy policy outlines how our video player app collects, uses, and protects personal information provided by users. We take the privacy of our users seriously and strive to ensure that their personal information is protected.\n\n Data Collected :\n Our video player app does not collect any personal information from users unless explicitly provided.\nUse of Data \nWe use the collected data to:\na. Provide and maintain our video player app.\nb. Improve and optimize the app performance.\nc. Personalize the app experience based on user preferences.\nd. Communicate with users, including sending updates and notifications about the app.\ne. Respond to user inquiries and support requests.\nf. Protect the security and integrity of the app and its users.\n\nData Sharing :\nWe do not share or sell user data to any third parties, except when required by law or in response to a valid legal request.\n\nData Security :\nWe take appropriate technical and organizational measures to protect user data from unauthorized access, disclosure, alteration, or destruction. However, no data transmission over the internet or electronic storage system can be guaranteed to be 100% secure.\n\nChanges to Privacy Policy :\nWe reserve the right to modify this privacy policy at any time. If we make any material changes, we will notify users by email or through the app.\n\nContact Information :\nIf you have any questions or concerns about our privacy policy, please contact us at [insert contact information].'; 

  }
  String? aboutUserText(){
    return 'Kei Stream app is an application that allows users to watch videos on their mobile devices. It supports various video formats, including MP4, AVI, and MKV, and can play videos stored on the device. The app typically provides features such as playback controls, favourites and playlist. Overall, dhekho is a convenient tool for users to watch their favourite videos on-the-go, offering a range of features to enhance the viewing experience.';

  }
  String? termsandcondText(){
    return 'By using this app, you agree to these terms and conditions. The app is provided "as is" and without warranty of any kind. We are not liable for any damages that may arise from your use of the app. You may not use the app for any illegal or unauthorized purpose. You are responsible for any content that you upload or share through the app, and you must have all necessary rights to do so. We reserve the right to terminate your access to the app at any time and for any reason. By using the app, you agree to indemnify and hold us harmless from any claims or damages that may arise from your use of the app.';

  }
  
}
