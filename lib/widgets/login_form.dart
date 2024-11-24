import 'package:ecommerce_app/blocs/signin/signin_cubit.dart';
import 'package:ecommerce_app/screens/registration/profile_screen.dart';
import 'package:ecommerce_app/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _email, _password;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    print('email: $_email, password: $_password');

    context.read<SigninCubit>().signin(email: _email!, password: _password!);
  }

  @override
  void initState() {
    super.initState();

  }



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) async {
        if (state.signinStatus == SigninStatus.error) {
            await errorDialog(context, state.error);
          }

          if (state.signinStatus == SigninStatus.success) {
           Navigator.of(context).pushNamedAndRemoveUntil(
            ProfileScreen.routeName,
            ModalRoute.withName('/'),
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
                TextFormField(
                    autocorrect: false,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    decoration: InputDecoration(
                      labelText: 'Пошта',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
                    }),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  autocorrect: false,
                  autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Забули пароль?',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ))
                  ],
                ),
                ElevatedButton(
                  onPressed: state.signinStatus == SigninStatus.submiting ? null : () {
                    if (_formKey.currentState!.validate()) {
                      TextInput.finishAutofillContext();
                    }

                    _submit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(state.signinStatus == SigninStatus.submiting ? 'Завантаження...' : 'Увійти'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
