import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/category_news.dart';

class CategoryTile extends StatelessWidget {
  final image;
  final categoryName;
  const CategoryTile({super.key, required this.image, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => CategoryNews(name: categoryName.toString().toLowerCase(),)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),),
            )
          ],
        ),
      ),
    );
  }
}
