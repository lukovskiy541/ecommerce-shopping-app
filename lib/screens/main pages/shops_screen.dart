import 'package:flutter/material.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
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
                          image: AssetImage('assets/intertop_shop.png'),
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
                          image: AssetImage('assets/intertop_outlet.png'),
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
                          image: AssetImage('assets/ecco_shop.png'),
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
                          image: AssetImage('assets/timberland.png'),
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
                          image: AssetImage('assets/geox.png'),
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
                          image: AssetImage('assets/skechers.png'),
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
                          image: AssetImage('assets/marc_o_polo.png'),
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
                          image: AssetImage('assets/armani_exchange.png'),
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
                          image: AssetImage('assets/the_north_face.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
