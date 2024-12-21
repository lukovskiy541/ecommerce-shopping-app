import 'package:ecommerce_app/blocs/signin/signup_cubit.dart';
import 'package:ecommerce_app/screens/profile/profile_screen.dart';
import 'package:ecommerce_app/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  String? _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    print(' email: $_email, password: $_password');

    context.read<SignupCubit>().signup(
          email: _email!,
          password: _password!,
        );
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
    _nameController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {

    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      
      listener: (context, state) async {
        print('Listener triggered with state: ${state.signupStatus}');

        if (state.signupStatus == SignupStatus.error) {
          await errorDialog(context, state.error);
        }
        if (state.signupStatus == SignupStatus.success) {
           Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => ProfileScreen()),
  (route) => false, 
);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: AutofillGroup(
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                    labelText: 'Пошта',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Будь ласка, введіть пошту';
                    }
                    if (!isEmail(value.trim())) {
                      return 'Введіть правильну пошту.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  autofillHints: [AutofillHints.newPassword],
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Будь ласка, введіть пароль';
                    }
                    if (value.trim().length < 6) {
                      return 'Пароль повинен бути мінімум 6 символів.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _password = value;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  autofillHints: [AutofillHints.newPassword],
                  decoration: InputDecoration(
                    labelText: 'Підтвердіть пароль',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Будь ласка, підтвердіть пароль';
                    }
                    if (value != _passwordController.text) {
                      return 'Паролі не співпадають';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state.signupStatus == SignupStatus.submiting
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            TextInput.finishAutofillContext();
                          }
                          _submit();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    state.signupStatus == SignupStatus.submiting
                        ? 'Завантаження...'
                        : 'Зареєструватися',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
