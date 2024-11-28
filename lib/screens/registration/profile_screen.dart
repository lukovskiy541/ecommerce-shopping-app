import 'package:ecommerce_app/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  final bool showBackButton;
  const ProfileScreen({super.key, this.showBackButton = true});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _getProfile();
  }

 void _getProfile() {
    final authState = context.read<AuthBloc>().state;
    
    if (authState.user != null) {
      final String uid = authState.user!.uid;
      print('uid: $uid');
      context.read<ProfileCubit>().getProfile(uid: uid);
    } else {
      print('No user logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (widget.showBackButton) {
              return true;
            }
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: widget.showBackButton
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : null,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                'Мій аккаунт',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  Text('Profile photo'),
                  if (state.authStatus == AuthStatus.unauthenticated)
                    GestureDetector(
                      child: Container(
                        color: Colors.black,
                        child: Text(
                          'Увійти',
                          style: TextStyle(color: Colors.white),
                        ),
                        height: 50,
                        width: 100,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                    ),
                  if (state.authStatus == AuthStatus.authenticated)
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutRequestedEvent());
                      },
                      child: Text('Вийти'),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
