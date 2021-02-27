import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Map<String, Object> imageParam = {};

class MoreImageSlider extends StatefulWidget {
  @override
  _MoreImageSliderState createState() => _MoreImageSliderState();
}

class _MoreImageSliderState extends State<MoreImageSlider> {
  @override
  Widget build(BuildContext context) {
    imageParam = ModalRoute.of(context).settings.arguments;
    List image_slider = imageParam["images"];
    // print(image_slider[0]["image"]);

    final imagePages = PageView.builder(
      itemCount: image_slider.length,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(image_slider[index]["image"]);
      },
    );
    final loading = Lottie.asset("assets/lottie/loadgin.json");

    final content = image_slider != [] ? imagePages : loading;

    return Scaffold(
      body: SafeArea(child: content),
    );
  }
}
