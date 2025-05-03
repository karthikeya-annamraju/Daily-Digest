import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_digest/models/article_model.dart';
import 'package:daily_digest/models/category_model.dart';
import 'package:daily_digest/models/slider_model.dart';
import 'package:daily_digest/pages/my_web_view.dart';
import 'package:daily_digest/services/api_service.dart';
import 'package:daily_digest/services/data.dart';
import 'package:daily_digest/services/slider_data.dart';
import 'package:daily_digest/utils/category_tile.dart';
import 'package:daily_digest/utils/trending_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  int activeIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    categories = getCategories();
    getNews();
    getSliders();
    super.initState();
  }

  getNews() async {
    ApiService apiService = ApiService();
    await apiService.fetchNewsFromApi();
    articles = apiService.news;
    setState(() {
      _isLoading = false;
    });
  }

  getSliders() async {
    SliderApiService sliderApiService = SliderApiService();
    await sliderApiService.fetchSliderData();
    sliders = sliderApiService.sliders;
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Daily'),
            Text(
              'Digest',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body:
          _isLoading
              ? Center(child: CupertinoActivityIndicator())
              : SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            image: categories[index].image,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Breaking News!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'View all',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CarouselSlider.builder(
                      itemCount: 6,
                      itemBuilder: (context, index, realIndex) {
                        String? imageResult = sliders[index].urlToImage;
                        String? nameResult = sliders[index].title;
                        String? url = sliders[index].url;
                        return buildImage(imageResult!, index, nameResult!, url!);
                      },
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildIndicator(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trending News!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'View all',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return TrendingTile(
                            image: articles[index].urlToImage!,
                            title: articles[index].title!,
                            description: articles[index].description!,
                            url: articles[index].url!,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  // Indicator Builder
  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 6,
    effect: JumpingDotEffect(
      dotWidth: 15,
      dotHeight: 15,
      activeDotColor: Colors.blue,
      dotColor: Colors.grey.shade300,
    ),
  );

  // Carousel Image builder
  Widget buildImage(String image, int index, String name, String url) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => MyWebView(url: url)));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 7, top: 5),
            margin: EdgeInsets.only(top: 140),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
