import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../Models/postsdatamodel.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<InitialPostEvent>(_initialpostevent);
    on<PostsNavigation>(_postnavigation);
  }

  FutureOr<void> _initialpostevent(
      InitialPostEvent event, Emitter<PostsState> emit) async {
    emit(PostsInitial());
    List<Posts> _posts = [];
    final chapter_id = event.Chapterid;
    final url =
        "https://bhagavad-gita3.p.rapidapi.com/v2/chapters/${chapter_id}/verses/";
    try {
      Map<String, String> headers = {
        'X-RapidAPI-Key': '43f69096f5mshda50b52ffe20737p1d0cfdjsn7d2bb5a5eaff',
        'X-RapidAPI-Host': 'bhagavad-gita3.p.rapidapi.com',
      };
// Make the HTTP GET request with the URL and headers
      var response = await http.get(Uri.parse(url), headers: headers);

      List<int> bytes = response.bodyBytes;
      String decodedBody = utf8.decode(bytes); // Assuming it's UTF-8 encoded
      //print(decodedBody);

      // Parse the JSON response
      List<dynamic> data = jsonDecode(decodedBody);
      for (int i = 0; i < data.length; i++) {
        Posts mypost = Posts.fromJson(data[i] as Map<String, dynamic>);
        _posts.add(mypost);
      }

      emit(PostsLoadedState(posts: _posts));
    } catch (e) {
      //print(e);
      emit(PostsErrorState());
    }
  }

  FutureOr<void> _postnavigation(PostsNavigation event, Emitter<PostsState> emit) {
    emit(PostClickedState(chapter: event.chapter,post: event.post));
  }
}
