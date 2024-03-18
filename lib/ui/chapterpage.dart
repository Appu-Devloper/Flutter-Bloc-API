
import 'package:bhagvadgita/Constants/Utils.dart';
import 'package:bhagvadgita/ui/postspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bhagvadgita/chapter/bloc/chapter_bloc.dart';
import 'package:provider/provider.dart';

import '../Constants/translationprovider.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({Key? key}) : super(key: key);

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
 
  final ChapterBloc _chapterBloc = ChapterBloc();
  final TextEditingController _searchController = TextEditingController();
  

  @override
  void initState() {
    _chapterBloc.add(ChapterInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {final translationProvider = Provider.of<TranslationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: translationProvider.showTranslation
            ?Text(
                "Bhagavad Gita",
                style: TextStyle(fontWeight: FontWeight.bold),
              ): Text(
                "भगवद गीता",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
           
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              setState(() {
                translationProvider.toggleTranslation();
              });
            },
          ),
        ],
      ),
      body: Container(
        child: BlocConsumer(
          bloc: _chapterBloc,
          buildWhen: (previous, current) => current is! ChapterAction,
          listener: (context, state) {
            if(state is ChapterClickedState)
          
            Navigator.push(context,MaterialPageRoute(builder: (context)=>PostsPage(Chapterid: state.Chapter_id,chapter: state.chapter,)));
          },
          
          listenWhen: (previous, current)=>current is  ChapterAction ,
          builder: (context, state) {
        
            switch (state.runtimeType) {
              case ChapterLoading:
              return Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: CircularProgressIndicator()),Text("Loading..")],));
              case Chaptererror:
              return Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Oops! Something went wrong while fetching the data. Please try again later.")],),);
              case ChapterLoadedState:
                final loadedState = state as ChapterLoadedState;
        
                // Filtered chapters based on search query
                final filteredChapters = loadedState.chapters.where((chapter) {
                  final searchQuery = _searchController.text.toLowerCase();
                  final nameMatches = chapter.name.toLowerCase().contains(searchQuery);
                  final translationMatches = chapter.translation.toLowerCase().contains(searchQuery);
                  return nameMatches || translationMatches;
                }).toList();
        
                return Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: filteredChapters
                              .map((chapter) => GestureDetector(
                                onLongPress: (){_chapterBloc.add(ChapterNavigationEvent(chapter_id: chapter.chapterNumber.toString(),chapter: chapter.name));},
                                child: ExpansionTile(
                                  
                                  trailing: Text(chapter.versesCount.toString(),style: TextStyle(color:myred,fontWeight: FontWeight.bold,fontSize: 16),),
                                      title: Text("${chapter.chapterNumber}. ${
                                     translationProvider.showTranslation
                                            ? chapter.translation
                                            : chapter.name}",
                                        style:  TextStyle(color:  myred,fontWeight: FontWeight.bold,fontSize: 18)
                                      ),
                                      subtitle: Text(   translationProvider.showTranslation?chapter.meaning['en'].toString():chapter.meaning['hi'].toString(), style:  TextStyle(color: myblue,fontWeight: FontWeight.bold,fontSize: 16)),
                                      children: [
                                      
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text( translationProvider.showTranslation?chapter.summary['en'].toString():chapter.summary['hi'].toString(),style: TextStyle(color:  myblue,fontWeight: FontWeight.bold),),
                                       )
                                      ],
                                    ),
                              ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                );
              default:
                return Center(child: Text("Data Unavilable"),);
            }
          },
        ),
      ),
    );
  }
}

