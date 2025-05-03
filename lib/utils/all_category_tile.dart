import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_digest/pages/my_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllCategoryTile extends StatelessWidget {
  final image, description, title, url;
  const AllCategoryTile({super.key, this.image, this.description, this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => MyWebView(url: url)));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(height: 10,),
              Text(title, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
              maxLines: 2, overflow: TextOverflow.ellipsis,),
              Text(description, maxLines: 3,
              overflow: TextOverflow.ellipsis,),
              Divider(thickness: 1,),
            ],
          ),
        ),
      ),
    );
  }
}
