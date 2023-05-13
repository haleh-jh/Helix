import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helix_with_clean_architecture/src/app/cubit/app_cubit.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/presentation/auth/login_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/cubit/main_screen_cubit.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/main_screen.dart';
import 'package:sizer/sizer.dart';
import '../injector.dart' as di;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => di.injector<AppCubit>()),
                BlocProvider(create: (_) => di.injector<MainScreenCubit>()),
              ],
              child: Sizer(
                builder: (context, orientation, deviceType) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: '',
                    theme: ThemeData.dark().copyWith(
                      scaffoldBackgroundColor: bgColor,
                      textTheme: GoogleFonts.poppinsTextTheme(
                              Theme.of(context).textTheme)
                          .apply(bodyColor: Colors.white),
                      canvasColor: secondaryColor,
                    ),
                    home: LayoutBuilder(
                      builder: (p0, p1) {
                        return BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) {
                            return LayoutBuilder(
                              builder: (context, constraint) {
                                return state.when(
                                  success: (isLogged) {
                                    if (!isLogged) return LoginScreen();
                                    return MainScreen();
                                  },
                                  error: () {
                                    return LoginScreen();
                                  },
                                  init: (bool isLogged) {
                                    //  if (!isLogged) return LoginScreen();
                                    return LoginScreen();
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              )));
}
