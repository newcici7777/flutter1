import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop/viewmodels/home.dart';

class MySlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  MySlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  CarouselSliderController _carouselSliderController =
      CarouselSliderController();
  int _currentPage = 0;
  Widget _getDots() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 10,
        child: SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.bannerList.length, (index) {
                return GestureDetector(
                    onTap: () {
                      _carouselSliderController.jumpToPage(index);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color:
                            index == _currentPage ? Colors.red : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ));
              }),
            )));
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 50,
          child: Text("搜索", style: TextStyle(color: Colors.white)),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _getSlider() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
        carouselController: _carouselSliderController,
        items: List.generate(widget.bannerList.length, (index) {
          return Image.network(
            widget.bannerList[index].imgUrl,
            fit: BoxFit.cover,
            width: screenWidth,
          );
        }),
        options: CarouselOptions(
            autoPlayInterval: Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            },
            height: 300,
            viewportFraction: 1,
            autoPlay: true));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getSlider(),
        _getSearch(),
        _getDots(),
      ],
    );
  }
}
