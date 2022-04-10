import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/src/config/style.dart';
import 'package:whatsapp/src/ui/screens/home_screen.dart';
import 'package:whatsapp/src/ui/screens/welcome_screen.dart';
import './config/injection_container.dart' as di;
import 'bloc/auth/auth_cubit.dart';
import 'bloc/communication/communication_cubit.dart';
import 'bloc/get_device_number/get_device_numbers_cubit.dart';
import 'bloc/my_chat/my_chat_cubit.dart';
import 'bloc/phone_auth/phone_auth_cubit.dart';
import 'bloc/user/user_cubit.dart';
import 'model/user_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.sl<AuthCubit>()..appStarted(),
          ),
          BlocProvider(
            create: (_) => di.sl<PhoneAuthCubit>(),
          ),
          BlocProvider<UserCubit>(
            create: (_) => di.sl<UserCubit>()..getAllUsers(),
          ),
          BlocProvider<GetDeviceNumbersCubit>(
            create: (_) => di.sl<GetDeviceNumbersCubit>(),
          ),
          BlocProvider<CommunicationCubit>(
            create: (_) => di.sl<CommunicationCubit>(),
          ),
          BlocProvider<MyChatCubit>(
            create: (_) => di.sl<MyChatCubit>(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WhatsApp Clone',
          theme: ThemeData(primaryColor: primaryColor),
          routes: {
            "/": (context) {
              return
                BlocBuilder<AuthCubit,AuthState>(builder: (context, authState) {
                if (authState is Authenticated) {
                  return BlocBuilder<UserCubit, UserState>(
                    builder: (context, userState) {
                      if (userState is UserLoaded) {
                        final currentUserInfo = userState.users.firstWhere(
                            (user) => user.uid == authState.uid,
                            orElse: () => UserModel(uid: '', email: '', phoneNumber: '', isOnline: false, profileUrl: '', status: '', name: ''));
                        return HomeScreen(
                          userInfo: currentUserInfo,
                        );
                      }
                      return Container();
                    },
                  );
                }
                if (authState is UnAuthenticated) {
                  return WelcomeScreen();
                }

                return Container();
              });
            }
          },
        ));
  }
}
