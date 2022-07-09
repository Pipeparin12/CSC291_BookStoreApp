import 'package:bookstoreapp291/service/dio.dart';
import 'package:flutter/material.dart';

import '../screen/detail_book.dart';
import 'package:bookstoreapp291/service/api/book.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String inputText = "";

  void showDetail(String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookDetail(id: id)));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                },
              ),
              Expanded(
                  child: Container(
                child: inputText == ""
                    ? Container()
                    : StreamBuilder(
                        stream: BookApi.searchBook(inputText).asStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Center(
                              child: Text("Something went wrong"),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text("Loading"),
                            );
                          }

                          return ListView(
                            children: snapshot.data!.data
                                .map<Widget>((dynamic document) {
                              Map<String, dynamic> data =
                                  document as Map<String, dynamic>;
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(data['bookName']),
                                  leading: Image(
                                      image: NetworkImage(DioInstance.getImage(
                                          data['bookImage']))),
                                  onTap: () {
                                    showDetail(data['_id']);
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
