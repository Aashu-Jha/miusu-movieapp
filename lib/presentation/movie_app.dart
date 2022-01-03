import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:miusu/common/constants/languages.dart';
import 'package:miusu/common/constants/route_constants.dart';
import 'package:miusu/common/screenutil/screen_util.dart';
import 'package:miusu/presentation/app_localizations.dart';
import 'package:miusu/presentation/blocs/language/language_cubit.dart';
import 'package:miusu/presentation/blocs/loading/loading_cubit.dart';
import 'package:miusu/presentation/blocs/login/login_bloc.dart';
import 'package:miusu/presentation/journey/loading/loading_screen.dart';
import 'package:miusu/presentation/routes.dart';
import 'package:miusu/presentation/themes/app_color.dart';
import 'package:miusu/presentation/themes/theme_text.dart';
import 'package:miusu/presentation/wiredash_app.dart';

import '../di/get_it.dart';
import 'fade_page_route_builder.dart';

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  static final _navigatorKey = GlobalKey<NavigatorState>();
  late LanguageCubit _languageCubit;
  late LoginCubit _loginCubit;
  late LoadingCubit _loadingCubit;

  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();
    _loginCubit = getItInstance<LoginCubit>();
    _loadingCubit = getItInstance<LoadingCubit>();
  }

  @override
  void dispose() {
    _loginCubit.close();
    _languageCubit.close();
    _loadingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
        BlocProvider<LoginCubit>.value(value: _loginCubit),
        BlocProvider<LoadingCubit>.value(value: _loadingCubit),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(builder: (context, locale) {
        return WiredashApp(
          languageCode: locale.languageCode,
          navigatorKey: _navigatorKey,
          child: MaterialApp(
              navigatorKey: _navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Miusu',
              theme: ThemeData(
                unselectedWidgetColor: AppColor.royalBlue,
                primaryColor: AppColor.vulcan,
                scaffoldBackgroundColor: AppColor.vulcan,
                textTheme: ThemeText.getTextTheme(),
                appBarTheme: const AppBarTheme(elevation: 0), 
                colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColor.royalBlue),
              ),
              supportedLocales:
                  Languages.languages.map((e) => Locale(e.code)).toList(),
              locale: locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              builder: (context, child) {
                return LoadingScreen(screen: child!);
              },
              initialRoute: RouteList.initial,
              onGenerateRoute: (RouteSettings settings) {
                final routes = Routes.getRoutes(settings);
                final WidgetBuilder? builder = routes[settings.name];
                return FadePageRouteBuilder(
                  builder: builder!,
                  settings: settings,
                );
              }),
        );
      }),
    );
  }
}
