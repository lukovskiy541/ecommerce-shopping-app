import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final Product product;
  const Carousel({super.key, required this.product});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _activePage = 0;
  late PageController _pageController;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pages = List.generate(
        widget.product.images.length,
        (index) => Image.network(
              widget.product.images[index],
              fit: BoxFit.cover,
            ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          child: PageView.builder(
            itemCount: widget.product.images.length,
            itemBuilder: (context, index) {
              return _pages[index];
            },
            onPageChanged: (value) {
              setState(() {
                _activePage = value;
              });
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  _pages.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            _pageController.animateToPage(index,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.easeIn);
                          },
                          child: CircleAvatar(
                            child: CircleAvatar(
                              radius: _activePage == index ? 4 : 2,
                              backgroundColor: Colors.grey,
                            ),
                            radius: _activePage == index ? 5 : 3,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )),
            ),
          ),
        )
      ],
    );
  }
}
