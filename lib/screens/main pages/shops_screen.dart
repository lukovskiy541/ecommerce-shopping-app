import 'package:flutter/material.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
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
            preferredSize: const Size.fromHeight(2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Магазини',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.green,),
                              Text('Київ', style: TextStyle(),),
                            ],
                          ),
                        )
                      ]),
                  const SizedBox(
                    height: 10,
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
