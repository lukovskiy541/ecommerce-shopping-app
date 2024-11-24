import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty && 
                     _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
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
            ),
            
          SizedBox(height: 10,),
            
          ElevatedButton(
            onPressed: _isFormValid 
              ? () {
                  TextInput.finishAutofillContext();
                } 
              : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isFormValid ? Colors.black : Colors.grey,
              foregroundColor: Colors.white,
            ),
            child: Text('Зареєструватися'),
          ),
        ],
      ),
    );
  }
}