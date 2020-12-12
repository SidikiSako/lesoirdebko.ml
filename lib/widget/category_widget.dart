import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesoirdebko/models/article.dart';
import 'package:lesoirdebko/models/category.dart';
import 'package:lesoirdebko/provider/article_provider.dart';
import 'package:lesoirdebko/screens/article_detail.dart';
import 'package:lesoirdebko/utils/reformat_title.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CategoryWidget extends StatefulWidget {
  final Category category;
  CategoryWidget({this.category});
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Article> categoryArticleList = new List();
  ScrollController _controller = new ScrollController();
  bool canFetch = false;
  @override
  void initState() {
    // var articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    // if (widget.category.id == 7) {
    //   categoryArticleList = articleProvider.actualitesRegionalesList;
    // } else if (widget.category.id == 6) {
    //   categoryArticleList = articleProvider.actualitesnationnaleList;
    // }

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        fetchNewArticles();
      }
    });
    //updateArticleList();
    super.initState();
  }

  void fetchNewArticles() async {
    var articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    //bool canFetch = false;
    switch (widget.category.id) {
      case 7: //Actualité régionale
        {
          canFetch = articleProvider.canFetchActualiteRegionale;
        }
        break;
      case 6:
        {
          canFetch = articleProvider.canFetchActualiteNationnale;
        }
        break;
      default:
        {}
    }
    if (canFetch == true) {
      articleProvider.fetchCategoryArticles(widget.category);
    }
  }

  // void updateArticleList() {
  //   var articleProvider = Provider.of<ArticleProvider>(context, listen: false);
  //   if (widget.category.id == 7) {
  //     categoryArticleList = articleProvider.actualitesRegionalesList;
  //   } else if (widget.category.id == 6) {
  //     categoryArticleList = articleProvider.actualitesnationnaleList;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var articleProvider = Provider.of<ArticleProvider>(context);
    if (widget.category.id == 7) {
      categoryArticleList = articleProvider.actualitesRegionalesList;
    } else if (widget.category.id == 6) {
      categoryArticleList = articleProvider.actualitesnationnaleList;
    }
    return Container(
      height: 300,
      child: Stack(
        children: [
          Container(
            height: 150,
            color: widget.category.color,
          ),
          Positioned(
            top: 10,
            left: 15,
            child: Text(
              widget.category.name.toUpperCase(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            child: Container(
              height: 230,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryArticleList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < categoryArticleList.length) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ArticleDetailsPage(
                              article: categoryArticleList[index],
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Container(
                                height: 160,
                                width: 152,
                                child: categoryArticleList[index].imageUrl ==
                                        null
                                    ? Image.asset(
                                        'images/no_image.png',
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl:
                                            categoryArticleList[index].imageUrl,
                                        imageBuilder: (context, imageProvider) {
                                          if (imageProvider == null) {
                                            print(
                                                'ImageProvider = $imageProvider');
                                            return Image.asset(
                                              'images/no_image.png',
                                              fit: BoxFit.cover,
                                            );
                                          } else {
                                            return Image(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            );
                                          }
                                        },
                                        //fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) {
                                          print(
                                              'Error in CachedNetworkImage with url = $url');

                                          return Container(
                                            height: double.infinity,
                                            width: 140,
                                            child: Image.asset(
                                              'images/no_image.png',
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 152,
                                child: Text(
                                  reformatTitle(
                                      categoryArticleList[index].title),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      bool canFetch;
                      switch (widget.category.id) {
                        case 7:
                          {
                            canFetch =
                                articleProvider.canFetchActualiteRegionale;
                          }
                          break;
                        case 6:
                          {
                            canFetch =
                                articleProvider.canFetchActualiteNationnale;
                          }
                          break;
                        default:
                          {}
                      }
                      return canFetch
                          ? Container(
                              height: 160,
                              width: 152,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ))
                          : Container(
                              height: 160,
                              width: 152,
                              //color: Colors.grey[200],
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Il n'y a plus d'article dans cette categorie.",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}

Future<Widget> getImage(String url) async {
  http.Response response = await http.get(url).catchError((e) {
    print('error in getImage : ${e.toString()}');
  });
  print('RESPONSE = ${response.body}');
  return response == null
      ? Image.asset(
          'images/no_image.png',
          fit: BoxFit.cover,
        )
      : Image.network(
          url,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loading) {
            return loading == null
                ? child
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        );
}
