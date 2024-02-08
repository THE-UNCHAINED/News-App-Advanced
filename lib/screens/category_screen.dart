import 'package:first_app/model/categoryNews.dart';
import 'package:first_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ApiService service = ApiService();
  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';

  List<String> categoryList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        categoryName = categoryList[index];
                        print(categoryName.toString());
                        setState(() {

                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: categoryName == categoryList[index]
                                ? Colors.purple
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            categoryList[index].toString(),
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: FutureBuilder<CategoryNews>(
                  future: service.fetchCategoryNews(categoryName),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          color: Colors.red,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    height: height * .18,
                                    width: width * .3,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return const SpinKitCircle(
                                        color: Colors.redAccent,
                                        size: 50,
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.error_outline);
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: Container(

                                  height: height * .18,
                                  margin: EdgeInsets.symmetric(vertical: 6),
                                  padding: EdgeInsets.only(left: 12),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.black45),
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),

                                        ],
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
