import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/screens/profile/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  late TextEditingController _surnameController;

  late TextEditingController _patronymicController;

  late bool _sex;

  late TextEditingController _phoneController;

  late TextEditingController _birthdayController;

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileCubit>().state.user;
    _nameController = TextEditingController(text: user.name);
    _surnameController = TextEditingController(text: user.surname);
    _patronymicController = TextEditingController(text: user.patronymic);
    _sex = user.sex;
    _phoneController = TextEditingController(text: user.phone);
    _birthdayController = TextEditingController(
      text:
          '${user.birthday.day.toString().padLeft(2, '0')}-${user.birthday.month.toString().padLeft(2, '0')}-${user.birthday.year}',
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = context.read<ProfileCubit>().state.user.birthday;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        _birthdayController.text =
            '${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}';
      });
    }
  }

  Future<void> _selectSex(BuildContext context) async {
    bool? selectedSex = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Виберіть стать'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Чоловік'),
                leading: Radio<bool>(
                  value: true,
                  groupValue: _sex,
                  onChanged: (bool? value) {
                    setState(() {
                      _sex = value!;
                    });
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
              ListTile(
                title: Text('Жінка'),
                leading: Radio<bool>(
                  value: false,
                  groupValue: _sex,
                  onChanged: (bool? value) {
                    setState(() {
                      _sex = value!;
                    });
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    if (selectedSex != null) {
      setState(() {
        _sex = selectedSex;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    _birthdayController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<ProfileCubit>().state.user;
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Мій профіль',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
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
                    SizedBox(height: 16),
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
                    SizedBox(height: 16),
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
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _birthdayController,
                      decoration: InputDecoration(
                        labelText: 'Дата народження',
                      ),
                      onTap: () => _selectDate(context),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Будь ласка введіть дату народження';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _selectSex(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: TextEditingController(
                            text: _sex ? 'Чоловік' : 'Жінка',
                          ),
                          decoration: InputDecoration(
                            labelText: 'Стать',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
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
                              DateTime parsedBirthday = DateTime.parse(
                                  _birthdayController.text
                                      .split('-')
                                      .reversed
                                      .join('-'));
                              try {
                                await context
                                    .read<ProfileCubit>()
                                    .updateProfile(
                                      user: user.copyWith(
                                        name: _nameController.text.trim(),
                                        surname: _surnameController.text.trim(),
                                        patronymic:
                                            _patronymicController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                        birthday: parsedBirthday,
                                        sex: _sex,
                                      ),
                                    );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Дані успішно збережено')),
                                );

                                Navigator.of(context).pop(true);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Помилка при збереженні даних')),
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
                    TextButton(
                        onPressed: () {
                          pushScreenWithNavBar(context, ChangePassword());
                        },
                        child: Text(
                          'Змінити пароль',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
