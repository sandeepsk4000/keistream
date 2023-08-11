import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/Functions/db_playlist.dart';
import 'package:project1/screens/screen_for_playlist.dart';

import '../model/data_model.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _editnameController= TextEditingController();
  @override
  void initState() {
    getAllPlaylist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final b=MediaQuery.of(context).size.width;
    final h=MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Playlist',style:GoogleFonts.lobster(
            color: Colors.white,fontSize: 35
          )),
          centerTitle: true,
          backgroundColor: Colors.black,
          shadowColor: null,
          toolbarHeight: 100,
            shape:const RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(bottomEnd: Radius.circular(20),bottomStart: Radius.circular(20)))),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: (){
          showDialog(
            context: context,
             builder: (context) {
              return SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                
                )
                ,
                title: Text('Create playlist',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w500
                ),),
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                       child: TextFormField(
                        style: GoogleFonts.roboto(
                          fontSize: 20,

                        ),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        controller: _titleController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Name is required';
                          }else if(value.contains('@')||value.contains('.')){
                            return 'Enter valid Name';

                          }else{
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          
                        ),
                        labelText: 'Title',
                        hintText: 'Title'),
                        


                       ), 
                       ),
                       SimpleDialogOption(
                        child: Container(
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black
                          ),
                          padding: const EdgeInsets.all(10),
                          child:  Center(
                            child: Text('ADD',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white

                            ),
                            ),
                          ),
                          
                        ),
                        onPressed: (){
                          onAddButton();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                              content: Text('New playlist created successfully',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 0.045*b,

                              ),
                              ),
                              duration: Duration(
                                seconds: 3
                              ), )
                          );
                        },
                       ),
                    ],
                  ),
                ],
              );
               
             },);
        },
         label:  Text('Create playlist',
         style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400
         ),
         ),
         icon: Icon(Icons.add),
         
         ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         backgroundColor: Color.fromARGB(255, 212, 235, 255),
         body: SafeArea(
          child:ValueListenableBuilder(
            valueListenable: playlistNotifier,
             builder: (BuildContext context, List<PlaylistModel> playlistList, Widget? child) {
               if (playlistList.isEmpty) {
                    return Center(
                      child: Text('Playlist  is empty',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.black
                      ),),
                    );
                    
                  }
              return Padding(
                padding:const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children:List.generate(playlistList.length, 
                  (index){
                    final data = playlistList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ScreenForPlaylist(name: data.name!, playlistID: data.playlistId!);
                          },));
                      },
                      child: Card(
                        
                        
                        
                        shape: RoundedRectangleBorder(
                          
                          borderRadius: BorderRadius.circular(10)
                        ),
                        color: const Color.fromARGB(255, 250, 250, 250),
                        elevation: 3,
                        child: Center(
                          child: Padding(
                            padding:const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:<Widget> [
                                SizedBox(
                                  height: 0.08*b,),
                                   Image(
                                    image: AssetImage(
                                      
                            
                                      'assets/play-button-icon-png-25.png'),
                                      width: 80,
                                      
                                  ),
                                  SizedBox(
                                    height: 0.02*b,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child:Center(
                                          child: Text(
                                            data.name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ) ,
                            
                                      ),
                                      IconButton
                                      (
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                             builder: (context) {
                                               return SimpleDialog(
                                                shape: 
                                                RoundedRectangleBorder(

                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                title: Text('Choose One',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                ),
                                                textAlign: TextAlign.center,),
                                                children: [
                                                  //delete playlist//
                                                  SimpleDialogOption(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                      showModalBottomSheet

                                                      ( enableDrag: true,
                                                        
                                                        shape: RoundedRectangleBorder(
                                                          
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        context: context,
                                                        isScrollControlled: true,
                                                         builder: (context) {
                                                          
                                                          return SizedBox(
                                                            height: 0.2*h,
                                                            child: 
                                                            Padding(
                                                              padding:EdgeInsets.all(25),
                                                              child: Column(
                                                                
                                                                children: [
                                                                  Text('Do you want to delete this playlist ?',
                                                                  style: GoogleFonts.roboto(
                                                                    fontSize: 0.05*b,
                                                                    fontWeight: FontWeight.w400
                                                                  ),),
                                                                  SizedBox(
                                                                    height: 0.02*h,
                                                                    
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      ElevatedButton(
                                                                        style:ElevatedButton.styleFrom(
                                                                          backgroundColor:  Color.fromARGB(255, 212, 235, 255)
                                                                        ) ,
                                                                        onPressed: () {
                                                                          deletePlaylist(data.playlistId!);
                                                                          Navigator.pop(context);
                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                            SnackBar(
                                                                              duration: Duration(seconds: 3),
                                                                              backgroundColor: Colors.white,
                                                                              content: Text('${data.name} has been Deleted successfully',
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.roboto(
                                                                                color: Colors.black,
                                                                                fontSize: 0.04*b
                                                                              ),)));
                                                                          
                                                                        },
                                                                         child: Container(
                                                                          color: Color.fromARGB(255, 212, 235, 255),
                                                                          width: 80,
                                                                          child: Center(
                                                                            child: Text('Yes',
                                                                            style: GoogleFonts.roboto(
                                                                              color: Color.fromARGB(255, 26, 26, 26),
                                                                              fontSize: 20
                                                                            ),)),
                                                                         )),
                                                                         ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 212, 235, 255)),
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop();
                                                                          }, 
                                                                           child: Container(
                                                                          color: Color.fromARGB(255, 212, 235, 255),
                                                                          width: 80,
                                                                          child: Center(
                                                                            child: Text('No',
                                                                            style: GoogleFonts.roboto(
                                                                              color: Color.fromARGB(255, 26, 26, 26),
                                                                              fontSize: 20
                                                                            ),
                                                                            )
                                                                            ),
                                                                         )
                                                                         )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              ),
                                                          );
                                                           
                                                         },);
                                                    },
                                                    padding: EdgeInsets.all(8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Color.fromARGB(255, 212, 235, 255),),
                                                        padding:  EdgeInsets.all(10),
                                                        child: Center(
                                                          child: Text(
                                                            'Delete',
                                                            style: GoogleFonts.roboto(
                                                              color: Color.fromARGB(255, 26, 26, 26),
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w400
                                                            ),
                                                          ),
                                                          ),
                                                    ),
                                                  ),
                                                  //rename playlist//
                                                  SimpleDialogOption(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      _editnameController.text=data.name!;
                                                      showModalBottomSheet(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        context: context,
                                                        isScrollControlled: true,
                                                        builder: (context) {
                                                          return Padding(
                                                            padding: EdgeInsets.only(
                                                              bottom: MediaQuery.
                                                              of(context).
                                                              viewInsets.bottom
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                 Padding(padding: 
                                                                EdgeInsets.only(
                                                                  left: 20,
                                                                  right: 20,
                                                                  top: 20
                                                                ),
                                                                child: 
                                                                TextFormField(
                                                                  style: GoogleFonts.roboto(
                                                                    fontSize: 18
                                                                  ),
                                                                  keyboardType: TextInputType.text,
                                                                  textCapitalization: TextCapitalization.sentences,
                                                                  controller: _editnameController,
                                                                  validator: (value) {
                                                                    if(value!.isEmpty){
                                                                      return 'Name is required';
                                                                    }else if(value.contains('@')||value.contains('.')){
                                                                      return 'Enter valid name';
                                                                    }else{
                                                                      return null;
                                                                    }
                                                                    
                                                                  },
                                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                  decoration: InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      
                                                                    ),
                                                                    labelText: 'Title',
                                                                    hintText: 'Title'
                            
                                                                  ),
                                                                )
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(bottom: 20),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 212, 235, 255)),
                            
                                                                        onPressed: (){
                                                                          Navigator.pop(context);
                                                                        },
                                                                         child: Container(
                                                                          color: Color.fromARGB(255, 212, 235, 255),
                                                                          width: 0.2*h,
                                                                          child: Center(
                                                                            child: Text('Cancel',
                                                                            style: GoogleFonts.roboto(
                                                                              color: Color.fromARGB(255, 26, 26, 26),
                                                                              fontSize: 20
                                                                            ),),
                                                                          ),
                                                                         )),
                                                                         ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 212, 235, 255)),
                                                                          onPressed: (){
                                                                            Navigator.of(context).pop();
                                                                            playlistUpdate(data.playlistId!);
                            
                            
                                                                          },
                                                                           child: Container(
                                                                            color: Color.fromARGB(255, 212, 235, 255),
                                                                            width: 0.25*b,
                                                                            child: Center(
                                                                              child: Text(
                                                                                'Rename',
                                                                                style: GoogleFonts.roboto(
                                                                                  color: Color.fromARGB(255, 26, 26, 26),
                                                                                  fontSize: 20
                                                                                ),
                                                                              ),
                                                                            ),
                                                                           ))
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),);
                                                        },
                                                         );
                            
                                                    },
                                                    padding: EdgeInsets.all(8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Color.fromARGB(255, 212, 235, 255),
                                                      ),
                                                      padding: EdgeInsets.all(10),
                                                      child: Center(
                                                        child: Text('Rename',
                                                        style: GoogleFonts.roboto(
                                                          color: Color.fromARGB(255, 26, 26, 26),
                                                          fontSize: 20,
                                                          fontWeight:FontWeight.w400 
                                                        ),)),
                                                    ),
                                                  )
                                                ],
                                               );
                                             },
                                             );
                                        },
                                         icon: Icon(Icons.more_vert,color: Colors.black,)
                                         )
                                    ],
                                  )
                                
                            
                              ],
                            ), 
                          ),
                        ),
                      ),

                    );
                  })
                  ), 
              );

               
             },
             ) 
         
         ),
      
        
     
    
    );
  }
   Future<void> onAddButton() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      return;
    }
    final playlist = PlaylistModel(name: title);
    await addPlaylist(playlist);
  }

  Future<void> playlistUpdate(int id) async {
    final name = _editnameController.text.trim();
    final playlist = PlaylistModel(name: name, playlistId: id);
    await updatePlaylist(playlist);
  }

}