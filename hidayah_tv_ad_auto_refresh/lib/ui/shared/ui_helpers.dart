import 'package:flutter/material.dart';

class UIHelper {
  static double responsiveBigPadding(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 16;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 14;
    } else {
      return 12;
    }
  }

  static double responsiveMediumPadding(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 10;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 8;
    } else {
      return 6;
    }
  }

  static double responsiveSmallPadding(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 6;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 4;
    } else {
      return 2;
    }
  }

  static double responsiveExtraBigSpacing(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 32;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 28;
    } else {
      return 24;
    }
  }

  static double responsiveBigSpacing(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 24;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 21;
    } else {
      return 18;
    }
  }

  static double responsiveMediumSpacing(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 16;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 14;
    } else {
      return 12;
    }
  }

  static double responsiveSmallSpacing(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 10;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 8;
    } else {
      return 6;
    }
  }

  static double responsiveExtraSmallSpacing(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 4;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 3;
    } else {
      return 2;
    }
  }

  static double deviceHeight(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    return originalScreenHeight;
  }

  static double deviceWidth(BuildContext context) {
    double originalScreenWidth = MediaQuery.of(context).size.width;

    return originalScreenWidth;
  }

  static double responsiveText(BuildContext context) {
    double originalScreenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top);

    if (originalScreenHeight > 800) {
      return 22;
    } else if (800 >= originalScreenHeight && originalScreenHeight > 650) {
      return 20;
    } else {
      return 18;
    }
  }
}
