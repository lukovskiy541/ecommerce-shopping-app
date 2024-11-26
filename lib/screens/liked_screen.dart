import 'package:flutter/material.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: false,
          expandedHeight: 100.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Мої вподобання',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      cursorHeight: 20,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 0.9,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Мої вподобання',
                        hintStyle: TextStyle(
                            fontSize: 17,
                            height: 1.1,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.only(bottom: 3, top: -3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Stack(children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/shopping_type.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 40.0,
                    child: Text(
                      'Збережені',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 16.0,
                    child: Text(
                      'мій список бажань',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Stack(children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/shopping_type.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 40.0,
                    child: Text(
                      'Каталог',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 16.0,
                    child: Text(
                      'всі товари',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Stack(children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/shopping_type.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 40.0,
                    child: Text(
                      'Каталог',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 16.0,
                    child: Text(
                      'всі товари',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Stack(children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/shopping_type.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 40.0,
                    child: Text(
                      'Каталог',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 16.0,
                    child: Text(
                      'всі товари',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
