import 'package:awomowa/app/theme.dart';
import 'package:flutter/material.dart';

class LoaderButton extends StatelessWidget {
  final String btnTxt;
  final bool isLoading;
  final Function onPressed;
  final Color btnColor;

  const LoaderButton(
      {Key key,
      this.btnTxt,
      this.isLoading = false,
      this.onPressed,
      this.btnColor = const Color(0xffFFC324)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: btnColor),
            onPressed: onPressed,
            child: isLoading
                ? Center(
                    child: Image.asset(
                      'assets/btn_loader.gif',
                      height: 48.0,
                    ),
                  )
                : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        btnTxt,
                        maxLines: 1,
                        style: TextStyle(
                            color: AppTheme.textBlack,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )));
  }
}
