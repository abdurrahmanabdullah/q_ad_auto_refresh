import 'package:flutter/material.dart';
import 'package:hidayah_tv_ad/ui/shared/ui_helpers.dart';

class ElevatedButtonMainWidget extends StatelessWidget {
  const ElevatedButtonMainWidget({
    Key? key,
    required this.buttonName,
    this.icon,
    required this.onClickListener,
    this.isSmall = false,
    this.isFocused = false,
    this.onFocusChange,
  }) : super(key: key);

  final String buttonName;
  final IconData? icon;
  final VoidCallback? onClickListener;
  final dynamic onFocusChange;
  final bool isFocused;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        backgroundColor: isFocused ? Colors.purple : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        // shadowColor: Colors.red,
      ),
      onFocusChange: onFocusChange,
      onPressed: onClickListener,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Padding(
          padding: icon != null
              ? EdgeInsets.symmetric(
                  vertical: UIHelper.responsiveBigPadding(context))
              : EdgeInsets.symmetric(
                  vertical: UIHelper.responsiveBigPadding(context) + 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: icon != null
                ? [
                    Icon(
                      icon,
                      size: isSmall ? 20 : 24,
                    ),
                    SizedBox(
                      width: UIHelper.responsiveSmallSpacing(context),
                    ),
                    Text(
                      buttonName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmall ? 12 : 14,
                        fontWeight: isSmall ? FontWeight.w500 : FontWeight.w600,
                      ),
                    ),
                  ]
                : [
                    Text(
                      buttonName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmall ? 12 : 14,
                        fontWeight: isSmall ? FontWeight.w500 : FontWeight.w600,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
