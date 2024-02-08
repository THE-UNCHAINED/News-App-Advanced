import 'package:first_app/model/categoryNews.dart';
import 'package:first_app/model/new_headLine.dart';
import 'package:first_app/screens/category_screen.dart';
import 'package:first_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Filterlist { bbcNews, aryNews, cnn, alJazeera }

class _HomePageState extends State<HomePage> {
  ApiService service = ApiService();

  Filterlist? selectedValue;
  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    TextStyle actionbuttonstyle = GoogleFonts.poppins(color: Colors.black54);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryScreen()));
          },
          icon: Image.asset(
            "assets/images/category_icon.png",
            height: 25,
            width: 25,
          ),
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: .5),
        ),
        actions: [
          PopupMenuButton<Filterlist>(
            initialValue: selectedValue,
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (Filterlist item) {
              if (Filterlist.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (Filterlist.aryNews.name == item.name) {
                name = 'ary-news';
              }
              if (Filterlist.cnn.name == item.name) {
                name = 'cnn';
              }
              if (Filterlist.alJazeera.name == item.name) {
                name = 'al-jazeera-english';
              }
              setState(() {});
            },
            itemBuilder: (context) => <PopupMenuEntry<Filterlist>>[
              PopupMenuItem<Filterlist>(
                value: Filterlist.bbcNews,
                child: Text(
                  "BBC News",
                  style: actionbuttonstyle,
                ),
              ),
              PopupMenuItem<Filterlist>(
                value: Filterlist.aryNews,
                child: Text(
                  "ARY News",
                  style: actionbuttonstyle,
                ),
              ),
              PopupMenuItem<Filterlist>(
                value: Filterlist.cnn,
                child: Text(
                  "CNN News",
                  style: actionbuttonstyle,
                ),
              ),
              PopupMenuItem<Filterlist>(
                value: Filterlist.alJazeera,
                child: Text(
                  "AlJazeera News",
                  style: actionbuttonstyle,
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: height * .50,
            width: width,
            child: FutureBuilder<NewHeadLine>(
                future: service.fetchNewsHeadline(name),
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
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return const SpinKitCircle(
                                        color: Colors.redAccent,
                                        size: 50,
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.running_with_errors_rounded,size: 50,);
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    height: height * .22,
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * .7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black87),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString()
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black87),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
          FutureBuilder<CategoryNews>(
              future: service.fetchCategoryNews("General"),
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
                    shrinkWrap: true,
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
        ],
      ),
    );
  }
}
