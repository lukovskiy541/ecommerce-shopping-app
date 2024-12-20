import 'package:ecommerce_app/models/cart_item_model.dart';

import 'package:ecommerce_app/screens/cart/cart_item_container.dart';
import 'package:flutter/material.dart';

class ChangeQuantityScreen extends StatefulWidget {
  const ChangeQuantityScreen({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  State<ChangeQuantityScreen> createState() => _ChangeQuantityScreenState();
}

class _ChangeQuantityScreenState extends State<ChangeQuantityScreen> {
  late int _selectedQuantity;

    @override
  void initState() {
    super.initState();
    _selectedQuantity = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: 390,
            height: 50,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pop(context, _selectedQuantity);
              },
              label: Text('Зберегти',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor: Colors.black,
              elevation: 0,
              highlightElevation: 0,
            ),
          ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Редагувати',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20),
            child: CartItemContainer(
              item: widget.cartItem,
              withButton: false,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text('Оберіть кількість:')),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 8),
                scrollDirection: Axis.horizontal,
                itemCount: 11,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ElevatedButton(
                      onPressed: () {

                        setState(() {
                          _selectedQuantity = index + 1;
                        });
                        print('index: $index');
                        print('_selectedQuantity: $_selectedQuantity');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(50, 50),
                        padding: EdgeInsets.zero,
                        splashFactory: NoSplash.splashFactory,
                        shadowColor: Colors.transparent,
                        enableFeedback: false,
                        side: BorderSide(width: 1, color: Colors.grey),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        backgroundColor: _selectedQuantity  == index + 1
                            ? Colors.black
                            : Colors.white,
                        foregroundColor: _selectedQuantity == index + 1
                            ? Colors.white
                            : Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          (List.generate(11, (i) => i + 1)[index]).toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
