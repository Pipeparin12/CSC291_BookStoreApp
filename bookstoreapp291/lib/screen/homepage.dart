import 'package:bookstoreapp291/model/book.dart';
import 'package:bookstoreapp291/screen/cart/cart_screen.dart';
import 'package:bookstoreapp291/screen/detail_book.dart';
import 'package:bookstoreapp291/service/api/book.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:bookstoreapp291/widget/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainScreen> {
  var listBook = [];
  String name = '';

  Future<void> getAllBook() async {
    try {
      var result = await BookApi.getAllBook();
      setState(() {
        listBook = result.data['book'].toList();
      });
      print(listBook);
    } on DioError catch (e) {
      print(e);
    }
  }

  void showDetail(String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookDetail(id: id)));
  }

  @override
  void initState() {
    getAllBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BookAround'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: IconButton(
            icon: Icon(Icons.sell),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SellerNavBar();
              }));
            }),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CartScreen();
              }));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 30)),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      fillColor: LightColor.lightGrey.withAlpha(100),
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding:
                          EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 5),
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onTap: () => Navigator.push(
                      context, CupertinoPageRoute(builder: (_) => Search())),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                top: 30,
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.02),
                child: SectionTitle(title: 'Best Seller', press: () {}),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listBook.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDetail(listBook[index]['_id']);
                        },
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 2,
                                child: Container(
                                    color: LightColor.lightGrey,
                                    child: Image(
                                      image: NetworkImage(DioInstance.getImage(
                                          listBook[index]['bookImage'])),
                                      fit: BoxFit.contain,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: Text(
                                  listBook[index]['bookName'],
                                  style: GoogleFonts.abel(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(listBook[index]['bookAmount'].toString()),
                            ],
                          ),
                        ),
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
