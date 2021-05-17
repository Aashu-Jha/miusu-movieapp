import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/route_constants.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/presentation/themes/theme_text.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/common/constants/translation_constants.dart';
import 'package:miusu/presentation/blocs/login/login_bloc.dart';
import 'package:miusu/presentation/widgets/button.dart';

import 'label_field_widget.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController? _usernameController, _passwordController;
  bool enableSignIn = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _usernameController!.addListener(() {
      setState(() {
        enableSignIn = _usernameController!.text.isNotEmpty &&
            _passwordController!.text.isNotEmpty;
      });
    });

    _passwordController!.addListener(() {
      setState(() {
        enableSignIn = _usernameController!.text.isNotEmpty &&
            _passwordController!.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_32.w,
          vertical: Sizes.dimen_24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.dimen_8.h),
              child: Text(
                TranslationConstants.loginToMovieApp.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            LabelFieldWidget(
              label: TranslationConstants.username.t(context),
              hintText: TranslationConstants.enterTMDbUsername.t(context),
              controller: _usernameController!,
            ),
            LabelFieldWidget(
              label: TranslationConstants.password.t(context),
              hintText: TranslationConstants.enterPassword.t(context),
              controller: _passwordController!,
              isPasswordField: true,
            ),
            BlocConsumer<LoginCubit, LoginState>(
              buildWhen: (previous, current) => current is LoginError,
              builder: (context, state) {
                if (state is LoginError)
                  return Text(
                    state.message.t(context),
                    style: Theme.of(context).textTheme.orangeSubtitle1,
                  );
                return const SizedBox.shrink();
              },
              listenWhen: (previous, current) => current is LoginSuccess,
              listener: (context, state) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteList.home,
                  (route) => false,
                );
              },
            ),
            Button(
              onPressed:  () => enableSignIn
                  ? BlocProvider.of<LoginCubit>(context).initiateLogin(
                _usernameController?.text ?? '',
                _passwordController?.text ?? '',
              )
                  : null,
              text: TranslationConstants.signIn,
              isEnabled: enableSignIn,
            ),
          ],
        ),
      ),
    );
  }
}
