import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<DeliveryAddress> deliveryAddresses = [
  DeliveryAddress(
    city: 'Kyiv',
    id: '0',
  ),
  DeliveryAddress(
    city: 'Lviv',
    id: '1',
  ),
  DeliveryAddress(
    city: 'Odesa',
    id: '2',
  ),
];

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key, required this.user});
  final User user;

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _patronymicController;
  late TextEditingController _cityController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    _nameController = TextEditingController(text: widget.user.name);
    _surnameController = TextEditingController(text: widget.user.surname);
    _patronymicController = TextEditingController(text: widget.user.patronymic);
    _cityController = TextEditingController(text: deliveryAddresses[0].city);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Одержувач',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Ім\'я',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Будь ласка введіть ім\'я';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(
                    labelText: 'Прізвище',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Будь ласка введіть прізвище';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _patronymicController,
                  decoration: InputDecoration(
                    labelText: 'По батькові',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Будь ласка введіть по батькові';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Місто доставки',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Будь ласка введіть місто';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Телефон',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Будь ласка введіть телефон';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 50,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Validate city
                          final selectedAddress = deliveryAddresses
                              .where((element) =>
                                  element.city == _cityController.text)
                              .firstOrNull;
                  
                          if (selectedAddress == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Виберіть місто зі списку')),
                            );
                            return;
                          }
                  
                          try {
                            await context.read<ProfileCubit>().updateProfile(
                                  user: widget.user.copyWith(
                                    name: _nameController.text.trim(),
                                    surname: _surnameController.text.trim(),
                                    patronymic: _patronymicController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                    addresses: [selectedAddress],
                                  ),
                                );
                  
                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Дані успішно збережено')),
                            );
                  
                            Navigator.of(context).pop(true);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Помилка при збереженні даних')),
                            );
                          }
                        }
                      },
                      label: Text(
                        'Зберегти',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: Colors.black,
                      elevation: 0,
                      highlightElevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
