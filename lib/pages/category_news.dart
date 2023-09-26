import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/show_category.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/show_category_news.dart';

// ignore: must_be_immutable
class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ShowCategory(
                  Image: categories[index].urlToImage!,
                  desc: categories[index].description!,
                  title: categories[index].title!,
                  url: categories[index].url!
                );
              }),
        ));
  }
}

// ignore: must_be_immutable
class ShowCategory extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String Image, desc, title, url;
  // ignore: non_constant_identifier_names
  ShowCategory({super.key, required this.Image, required this.desc, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: Image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            title,
            maxLines: 2,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Text(desc, maxLines: 3,),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }
}
