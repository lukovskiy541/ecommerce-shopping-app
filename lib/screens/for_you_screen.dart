import 'package:flutter/material.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                    children: [
                      Text('Для тебе', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      cursorHeight:
                          20,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 0.9,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Пошук',
                        hintStyle: TextStyle(
                            fontSize: 17,
                            height:
                                1.1,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size:
                              20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(bottom: 3, top: -3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: !index.isOdd ? Colors.white : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text('$index', textScaler: const TextScaler.linear(5)),
                ),
              );
            },
            childCount: 50,
          ),
        ),
      ],
    );
  }
}
