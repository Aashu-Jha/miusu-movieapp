import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/languages.dart';
import 'package:miusu/common/constants/route_constants.dart';
import 'package:miusu/common/constants/translation_constants.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:miusu/presentation/journey/drawer/navigation_expanded_list_item.dart';
import 'package:miusu/presentation/journey/drawer/navigation_list_item.dart';
import 'package:miusu/presentation/widgets/app_dialog.dart';
import 'package:miusu/presentation/widgets/logo.dart';
import 'package:wiredash/wiredash.dart';

import '../../../common/constants/languages.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: Theme.of(context).primaryColor.withOpacity(0.7),
        ),
      ]),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
                bottom: Sizes.dimen_18.h,
              ),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(
                title: TranslationConstants.favoriteMovies.t(context),
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteList.favorite);
                }),
            NavigationExpandedListItem(
                title: TranslationConstants.language.t(context),
                onPressed: (index) {
                  BlocProvider.of<LanguageBloc>(context)
                      .add(ToggleLanguageEvent(Languages.languages[index]));
                },
                children: Languages.languages.map((e) => e.value).toList()),
            NavigationListItem(
                title: TranslationConstants.feedback.t(context),
                onPressed: () {
                  Navigator.of(context).pop();
                  Wiredash.of(context)!.show();
                }),
            NavigationListItem(
                title: TranslationConstants.about.t(context),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showDialog(context);
                }),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
      builder: (BuildContext context) => AppDialog(
            title: TranslationConstants.about,
            description: TranslationConstants.aboutDescription,
            buttonText: TranslationConstants.okay,
        image: Image.asset('assets/pngs/tmdb_logo.png', height: Sizes.dimen_32.h,),
      )
    );
  }
}
