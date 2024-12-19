import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/blocs/navigation/navigation_cubit.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/brand_model.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/brands_repository.dart';

import 'package:ecommerce_app/screens/catalog/carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Brand> _brands = [];
  bool _inCart = false;
  bool _sizeSelected = false;
  int _selectedSize = 0;
  late PageController _pageController;
  late ScrollController _scrollController;
  int _selectedButtonIndex = -1;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pageController = PageController(initialPage: 0);
    _initializeBrands();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _initializeBrands() async {
    final brands = await context.read<BrandsRepository>().getBrands();
    print('success loaded brands');
    setState(() {
      _brands = brands;
    });
  }

  void _showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).size.height - 200,
        ),
        content: Text('Необхідно обрати розмір'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _scrollToSizes() {
    _scrollController.animateTo(
      800,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              IconButton(
                onPressed: () {
                  context
                      .read<ProfileCubit>()
                      .addFavorite(product: widget.product);
                },
                icon: state.user.favoriteProducts.contains(widget.product.id)
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: 390,
            height: 50,
            child: FloatingActionButton.extended(
              onPressed: () {
                if (!_inCart) {
                  if (_sizeSelected) {
                    setState(() {
                      _inCart = !_inCart;
                    });
                  } else {
                    _showErrorMessage();
                    _scrollToSizes();
                  }
                } else {
                  if (context.read<CartBloc>().state.cart.items.any(
                      (element) => element.product.id == widget.product.id &&
                          element.selectedSize == _selectedSize.toString())) {
                    context.read<CartBloc>().add(CartUpdateItemQuantityEvent(
                        productId: widget.product.id, quantity: 1, selectedSize: _selectedSize.toString()));
                    context.read<NavigationCubit>().switchTab(2);
                  } else
                    context.read<CartBloc>().add(CartAddItemEvent(
                        cartItem: CartItem(
                            id: '',
                            product: widget.product,
                            quantity: 1,
                            selectedSize: _selectedSize.toString(),
                            selectedColor: widget.product.availableColors[0],
                            price: widget.product.price * 1,
                            bonusPoints: widget.product.bonusPoints,
                            bonusPointsForSubscribers:
                                widget.product.bonusPointsForSubscribers),
                        currentCartState: context.read<CartBloc>().state));
                  context.read<NavigationCubit>().switchTab(2);
                }
              },
              label: Text(
                _inCart ? 'Перейти до кошика' : 'Додати в кошик',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.black,
              elevation: 0,
              highlightElevation: 0,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Stack(children: [
                    Carousel(product: widget.product),
                    if (_inCart)
                      Positioned(
                        bottom: 25,
                        left: 5,
                        child: Container(
                          width: 100,
                          height: 30,
                          color: Colors.grey,
                          child: Center(
                              child: Text(
                            'У кошику',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                  ]),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product.brand,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            Text(
                              '\$ ${widget.product.price}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(widget.product.category.name),
                        SizedBox(height: 10),
                        Text('Колір: ${widget.product.availableColors[0]}'),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Доступні розміри'),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.summarize_outlined),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.product.availableSizes.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedSize = int.parse(
                                          widget.product.availableSizes[index]);
                                      _selectedButtonIndex = index;
                                      _sizeSelected = !_sizeSelected;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(50, 50),
                                    padding: EdgeInsets.zero,
                                    splashFactory: NoSplash.splashFactory,
                                    shadowColor: Colors.transparent,
                                    enableFeedback: false,
                                    side: BorderSide(
                                        width: 1, color: Colors.grey),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    backgroundColor:
                                        _selectedButtonIndex == index
                                            ? Colors.black
                                            : Colors.white,
                                    foregroundColor:
                                        _selectedButtonIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.product.availableSizes[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ExpansionTile(
                          title: Text('Характеристики'),
                          tilePadding: EdgeInsets.zero,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Колір'),
                                Text(widget.product.availableColors[0])
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Вид товару'),
                                Text(widget.product.productType.name)
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Опис'),
                                Text(widget.product.description)
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '+${widget.product.bonusPoints} bonuses when buying'),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.question_mark_rounded))
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '+${widget.product.bonusPointsForSubscribers} for subscribers'),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.question_mark_rounded))
                            ],
                          ),
                        ),
                        Text('Бренд'),
                        _brands.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                    _brands
                                        .where((brand) =>
                                            brand.name == widget.product.brand)
                                        .first
                                        .imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.favorite_border),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.heart_broken_outlined))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Продавець'),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            widget.product.seller,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
