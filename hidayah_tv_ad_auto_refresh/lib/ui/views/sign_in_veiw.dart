import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidayah_tv_ad/core/enums/view_state.dart';
import 'package:hidayah_tv_ad/core/view_models/sign_in_view_model.dart';
import 'package:hidayah_tv_ad/ui/route_navigation.dart';
import 'package:hidayah_tv_ad/ui/shared/ui_helpers.dart';
import 'package:hidayah_tv_ad/ui/views/base_view.dart';
import 'package:hidayah_tv_ad/ui/widgets/elevated_button_main_widget.dart';
import 'package:hidayah_tv_ad/ui/widgets/text_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: UIHelper.deviceHeight(context) * 0.9,
              child: Padding(
                padding: EdgeInsets.all(UIHelper.responsiveBigPadding(context)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(),
                      const Column(
                        children: [
                          Text(
                            'Welcome to Qad',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Powered by Hidayah Smart Solutions',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Form(
                        key: model.formKey,
                        child: Column(
                          children: [
                            TextFieldWidget(
                              textFieldLabel: 'Domain',
                              leadingIcon: Icons.link,
                              formValidator: (input) => model.iDValidator(input!),
                              typeKeyboard: TextInputType.url,
                              initialValue: model.inputDomain,
                              onChange: (value) {
                                model.inputDomain = value;
                              },
                            ),
                            TextFieldWidget(
                              textFieldLabel: 'ID',
                              leadingIcon: Icons.key,
                              formValidator: (input) => model.iDValidator(input!),
                              typeKeyboard: TextInputType.number,
                              initialValue: model.inputID,
                              onChange: (value) {
                                model.inputID = value;
                              },
                              isLastField: true,
                            ),
                            model.state == ViewState.idle
                                ? Shortcuts(
                                    shortcuts: {
                                      LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                                    },
                                    child: ElevatedButtonMainWidget(
                                      buttonName: 'Verify',
                                      onClickListener: () async {
                                        final SharedPreferences preferences = await SharedPreferences.getInstance();

                                        preferences.setString('domain', model.inputDomain);

                                        if (model.formKey.currentState!.validate()) {
                                          if (await model.signIn()) {
                                            if (context.mounted) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                RouteNavigation.home,
                                                (Route route) => route.isCurrent,
                                              );
                                            }
                                          }
                                        }
                                      },
                                      onFocusChange: (value) {
                                        model.changeButtonOneColor(value);
                                      },
                                      isFocused: model.buttonOneSelected,
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ),
                                  ),
                            SizedBox(
                              height: UIHelper.responsiveExtraBigSpacing(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
