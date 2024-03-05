import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    @required this.textFieldLabel,
    this.typeKeyboard,
    this.passwordField = false,
    this.onChange,
    this.textLengthSize = 200,
    this.noBottomPadding = false,
    this.leadingIcon,
    this.trialWidget,
    this.trialIconOnTap,
    this.prefixText = '',
    this.isLastField = false,
    this.formValidator,
    this.initialValue = '',
    this.enabled = true,
    this.autoFocus = false,
    this.isSmall = false,
  }) : super(key: key);

  final String? textFieldLabel;
  final TextInputType? typeKeyboard;
  final bool passwordField;
  final Function(String s)? onChange;
  final int textLengthSize;
  final bool noBottomPadding;
  final IconData? leadingIcon;
  final Widget? trialWidget;
  final VoidCallback? trialIconOnTap;
  final String prefixText;
  final bool isLastField;
  final String? Function(String?)? formValidator;
  final String initialValue;
  final bool enabled;
  final bool autoFocus;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autofocus: autoFocus,
            enabled: enabled,
            validator: formValidator,
            onChanged: onChange,
            obscureText: passwordField,
            keyboardType: typeKeyboard,
            initialValue: initialValue,
            style: Theme.of(context).textTheme.bodyText2,
            inputFormatters: [
              LengthLimitingTextInputFormatter(textLengthSize),
            ],
            textInputAction:
                isLastField ? TextInputAction.done : TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: isSmall ? 0 : 18.0, horizontal: 16.0),
              errorStyle: const TextStyle(fontSize: 9, height: 0.1),
              prefix: Text(
                prefixText,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
              prefixIcon: leadingIcon != null
                  ? Icon(
                      leadingIcon,
                      color: Colors.green,
                    )
                  : null,
              suffixIcon: trialWidget == null
                  ? null
                  : GestureDetector(
                      onTap: trialIconOnTap,
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: trialWidget,
                      ),
                    ),
              labelText: textFieldLabel,
              labelStyle: const TextStyle(
                color: Colors.green,
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          noBottomPadding
              ? Container()
              : const SizedBox(
                  height: 16.0,
                )
        ],
      ),
    );
  }
}
