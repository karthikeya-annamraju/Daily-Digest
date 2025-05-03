// import 'package:daily_digest/models/slider_model.dart';
//
// List<SliderModel> getSliders() {
//   List<SliderModel> sliders = [];
//
//   SliderModel sliderModel = new SliderModel();
//
//   sliderModel.sliderName = "Sample data Sample data Sample data Sample data";
//   sliderModel.image = "assets/images/business.jpg";
//   sliders.add(sliderModel);
//   sliderModel = new SliderModel();
//
//   sliderModel.sliderName = "Sample dataSample data Sample data";
//   sliderModel.image = "assets/images/entertainment.jpg";
//   sliders.add(sliderModel);
//   sliderModel = new SliderModel();
//
//   sliderModel.sliderName = "Sample data Sample data Sample dataSample data";
//   sliderModel.image = "assets/images/general.jpg";
//   sliders.add(sliderModel);
//   sliderModel = new SliderModel();
//
//   sliderModel.sliderName = "Sample data Sample data Sample data";
//   sliderModel.image = "assets/images/health.jpg";
//   sliders.add(sliderModel);
//   sliderModel = new SliderModel();
//
//   sliderModel.sliderName = "Sample data Sample data Sample dataSample data";
//   sliderModel.image = "assets/images/sports.jpg";
//   sliders.add(sliderModel);
//   sliderModel = new SliderModel();
//
//   return sliders;
// }

import 'dart:convert';

import 'package:daily_digest/models/article_model.dart';
import 'package:daily_digest/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SliderApiService {

  List<SliderModel> sliders = [];

  Future<void> fetchSliderData() async {
    String url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=3dd5fdf498ba48e294791ec690f6d5de";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description']!= null) {
          SliderModel sliderData = SliderModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          sliders.add(sliderData);
        }
      });
    }
  }
}