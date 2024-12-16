import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/carousel.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _activePage = 0;
  late PageController _pageController;
  late List<Widget> _pages;
  int _selectedButtonIndex = -1;
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
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Carousel(product: widget.product),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.brand,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    '\$ ${widget.product.price}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(widget.product.category.name),
              SizedBox(
                height: 10,
              ),
              Text('Колір: ${widget.product.availableColors[0]}'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Доступні розміри'),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.summarize_outlined))
                ],
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.product.availableSizes.length,
                  itemBuilder: (context, index) => ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedButtonIndex = index;
                      });
                      
                    },
                    style: ElevatedButton.styleFrom(
                       splashFactory: NoSplash.splashFactory,
                       shadowColor: Colors.transparent,
                       enableFeedback: false,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      backgroundColor: _selectedButtonIndex == index
                          ? Colors.black
                          : Colors.white,
                      foregroundColor: _selectedButtonIndex == index
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: Text(widget.product.availableSizes[index]),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
