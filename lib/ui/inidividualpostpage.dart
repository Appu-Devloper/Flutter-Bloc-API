import 'package:bhagvadgita/Models/postsdatamodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Utils.dart';
import '../Constants/translationprovider.dart';

class IndividualPOst extends StatelessWidget {
  final Posts post;
  final String chapter;
  const IndividualPOst({super.key, required this.post, required this.chapter});


  @override
  Widget build(BuildContext context) {
    final translationProvider = Provider.of<TranslationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: translationProvider.showTranslation
            ? Text(
                "Bhagavad Gita",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                "भगवद गीता",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
             
                translationProvider.toggleTranslation();
            
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                chapter,
                style: TextStyle(
                    color: myred, fontSize: 18, fontWeight: FontWeight.bold),
              )),
              Divider(),
              Center(
                  child: Text(
              post.text,
                style: TextStyle(
                    color: myred, fontSize: 18, fontWeight: FontWeight.w400),
              )),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                   post.wordsmeaning.replaceAll(';', '\n'),
                    style: TextStyle(
                        color: myblue, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(width: MediaQuery.sizeOf(context).width,
              color: Colors.grey[200],
                child: Center(
                    child: Text(
                      "Descriptions",
                      style: TextStyle(
                          color: myblue, fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                  ),
              ),
              SizedBox(height: 20,),
              ListView.builder(physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                 itemCount: translationProvider.showTranslation
      ? post.translations.where((translation) => translation.language == 'english').length
      : post.translations.where((translation) => translation.language != 'english').length,
  itemBuilder: (context, index) {
    final translation = translationProvider.showTranslation
        ? post.translations.where((translation) => translation.language == 'english').toList()[index]
        : post.translations.where((translation) => translation.language != 'english').toList()[index];

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: (Container(
                          decoration: BoxDecoration(color: Colors.white,
                            border: Border(top: BorderSide( color: myblue,width: 1)),borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${translation.description}",style: TextStyle(color: Colors.black),),
                              ),
                                 Row(mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.only(right:8.0,left: 8),
                                       child: Text("${translation.author}  ",style: TextStyle(color: myblue,fontWeight: FontWeight.bold),textAlign: TextAlign.end,),
                                     ),
                                   ],
                                 ),
                              
                            ],
                          ),
                        )),
                      ),
                    );
                  }),
                  SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}
