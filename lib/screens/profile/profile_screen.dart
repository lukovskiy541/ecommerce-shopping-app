import 'package:ecommerce_app/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/screens/for_you/for_you_screen.dart';
import 'package:ecommerce_app/screens/profile/bonus_program.dart';
import 'package:ecommerce_app/screens/profile/delivery_payment_screen.dart';
import 'package:ecommerce_app/screens/profile/edit_notifications_screen.dart';
import 'package:ecommerce_app/screens/profile/edit_profile_screen.dart';
import 'package:ecommerce_app/screens/profile/settings_screen.dart';
import 'package:ecommerce_app/screens/profile/signin_screen.dart';
import 'package:ecommerce_app/screens/profile/support_screen.dart';
import 'package:ecommerce_app/screens/profile/user_current_orders.dart';
import 'package:ecommerce_app/screens/profile/user_orders_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

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
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => ForYouScreen()),
                        (route) => false,
                      ),
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
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 15),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.person),
                    ),
                  ),
                  if (state.authStatus == AuthStatus.authenticated) ...[
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, profileState) {
                        if (profileState.profileStatus ==
                            ProfileStatus.loaded) {
                          return Column(
                            children: [
                              Text(
                                '${profileState.user.name} ${profileState.user.surname}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Ваші бонуси: ${profileState.user.bonusPoints}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 30),
                              _buildProfileItem(
                                'Мої замовлення',
                                () => pushScreen(context,
                                    screen: UserOrders(), withNavBar: true),
                              ),
                              _buildProfileItem(
                                'Мої покупки',
                                () => pushScreen(context,
                                    screen: UserOrdersHistory(),
                                    withNavBar: true),
                              ),
                              SizedBox(height: 30),
                              _buildProfileItem(
                                'Мій профіль',
                                () => pushScreen(context,
                                    screen: EditProfileScreen(),
                                    withNavBar: true),
                              ),
                              _buildProfileItem(
                                'Мої сповіщення',
                                () => pushScreen(context,
                                    screen: EditNotificationsScreen(),
                                    withNavBar: true),
                              ),
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                  if (state.authStatus == AuthStatus.unauthenticated) ...[
                    Center(
                        child: Text(
                      'Переглядайте статус ваших',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                     Center(
                        child: Text(
                      ' замовлень і керуйте інформацією',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(height: 15),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                        child: Text(
                          'Увійти',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        height: 50,
                        width: 150,
                      ),
                      onTap: () {
                        pushScreen(
                          context,
                          screen: SignInScreen(),
                          withNavBar: true,
                        );
                      },
                    ),
                  ],
                  SizedBox(height: 30),
                  _buildProfileItem(
                    'Налаштування',
                    () => pushScreen(context,
                        screen: SettingsScreen(), withNavBar: true),
                  ),
                  _buildProfileItem(
                    'Бонусна програма',
                    () => pushScreen(context,
                        screen: BonusProgramScreen(), withNavBar: true),
                  ),
                  _buildProfileItem(
                    'Доставка та оплата',
                    () => pushScreen(context,
                        screen: DeliveryPaymentScreen(), withNavBar: true),
                  ),
                  _buildProfileItem(
                    'Служба підтримки',
                    () => pushScreen(context,
                        screen: SupportScreen(), withNavBar: true),
                  ),
                  if (state.authStatus == AuthStatus.authenticated)
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutRequestedEvent());
                      },
                      child: Text('Вийти'),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 16)),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
