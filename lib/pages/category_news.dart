import 'package:daily_digest/models/show_category_model.dart';
import 'package:daily_digest/services/show_categories_service.dart';
import 'package:flutter/material.dart';

import '../utils/all_category_tile.dart';
import '../utils/category_tile.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _isLoading = true;

  getCategoriesNews() async {
    ShowCategoriesService showCategoriesService = ShowCategoriesService();
    await showCategoriesService.fetchCategoryNewsFromApi(widget.name);
    categories = showCategoriesService.categoriesList;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoriesNews();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.name[0].toUpperCase() + widget.name.substring(1), style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return AllCategoryTile(
              image: categories[index].urlToImage,
              title: categories[index].title,
              description: categories[index].description,
              url: categories[index].url,
            );
          },
        ),
      ),
    );
  }
}
