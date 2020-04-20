//import 'dart:html';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seventh_erudition/helper/data.dart';
import 'package:seventh_erudition/helper/widgets.dart';
import 'package:seventh_erudition/models/category_model.dart';
import 'package:seventh_erudition/views/category_news.dart';
import '../helper/news.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class Home extends StatefulWidget{
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<Home>{
  bool loading;
  var newslist;
  List<CategoryModel> categories = new List<CategoryModel>();
   void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      loading = false;
    });
  }
  @override
  void initState(){
    loading = true;
    super.initState();
    categories = getCategories();
    getNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), 
          onPressed: (){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          }),
        ],
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Seventh",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "Erudition",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),),
      ),
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                              child: CategoryCard(
                                //imageUrl: categories[index].imageUrl;
                                imageUrl: "https://wallpaperplay.com/walls/full/0/d/d/380283.jpg#.Xp2TK-qI4-c.link`",
                                categoryName: categories[index].categoryName,
                              ));
                            }),
                      ),

                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ListView.builder(
                            itemCount: newslist.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}


class CategoryCard extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryCard({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            newsCategory: categoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
 
}