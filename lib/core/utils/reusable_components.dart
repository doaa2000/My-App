import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/core/utils/colors.dart';

void showToastMessage({
  required String message,
  required bool isError,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16);
}

class LoginAndRegisterTextForm extends StatelessWidget {
  const LoginAndRegisterTextForm(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.validate});
  final String hintText;
  final String? Function(String?)? validate;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      style: TextStyle(color: AppColors.primaryColor),
      controller: controller,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            color: Colors.grey,
          )),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.title,
      this.color,
      this.fontSize,
      this.fontWeight})
      : super(key: key);
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis),
    );
  }
}

class LoginAndRegisterButton extends StatelessWidget {
  const LoginAndRegisterButton({super.key, required this.text, this.onTap});
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        child: Center(
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.white, fontSize: 20))),
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
      {super.key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontWeight});
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.textColor,
      required this.text,
      required this.buttonColor,
      this.isLoading = false});

  final VoidCallback onTap;
  final String text;
  final Color textColor;
  final Color buttonColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18, left: 10, right: 10),
      height: 50,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 20),
        ),
      ),
    );
  }
}
