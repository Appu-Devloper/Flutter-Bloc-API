import 'package:bhagvadgita/Constants/Utils.dart';
import 'package:bhagvadgita/Posts/bloc/posts_bloc.dart';
import 'package:bhagvadgita/ui/inidividualpostpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../Constants/translationprovider.dart';

class PostsPage extends StatefulWidget {
  final String Chapterid;
  final String chapter;
  const PostsPage({super.key,required this.Chapterid,required this.chapter});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _postsbloc =PostsBloc();
  TextEditingController _searchController =TextEditingController();

  @override
  void initState() {
    super.initState();
    _postsbloc.add(InitialPostEvent(Chapterid:widget.Chapterid ));
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
          bloc: _postsbloc,
          buildWhen: (previous, current) => current is! PostsAction,
          listener: (context, state) {
            if(state is PostClickedState)
          Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualPOst(post:state.post,chapter: state.chapter,)));
          },
          
          listenWhen: (previous, current)=>current is  PostsAction ,
          builder: (context, state) {
        
            switch (state.runtimeType) {
              case PostsInitial:
              return Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: CircularProgressIndicator()),Text("Loading..")],));
              case PostsErrorState:
              return Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Oops! Something went wrong while fetching the data. Please try again later.")],),);
              case PostsLoadedState:
                final loadedState = state as PostsLoadedState;
        
                // Filtered chapters based on search query
                final filteredChapters = loadedState.posts.where((chapter) {
                  final searchQuery = _searchController.text.toLowerCase();
                  final nameMatches = chapter.transliteration.toLowerCase().contains(searchQuery);
                  final translationMatches = chapter.text.toLowerCase().contains(searchQuery);
                  return nameMatches || translationMatches;
                }).toList();
        
                return Column(
                  children: [
                    Text(widget.chapter,style: TextStyle(color: myred,fontSize: 16,fontWeight: FontWeight.bold),),
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
                      child: ListView.builder(
                        itemCount: filteredChapters.length,
                        itemBuilder: (context,index){
                          final post = filteredChapters[index];
                          return InkWell(
                          onTap: (){_postsbloc.add(PostsNavigation(post: post, chapter: widget.chapter));},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(child: Text("${post.slug}",style: TextStyle(color: myred,fontWeight: FontWeight.w500,fontSize: 18),),),
                                  Text( translationProvider.showTranslation?"${post.transliteration}":"${post.text}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),),
                                  Divider()
                                ],
                              ),
                            ),
                          );
                        })
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

