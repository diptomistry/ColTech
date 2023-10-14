import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../profile/profile_edit.dart';

class RateNow extends StatefulWidget {
  final String pageType;
  final int id;
  const RateNow(
      {super.key,
      required this.pageType,
      required this.id,
      required this.widget});
  final Widget widget;
  @override
  State<RateNow> createState() => _RateNowState();
}

class _RateNowState extends State<RateNow> {
  late final String pageType;
  late final int id;
  bool select = false;
  double _rating = 0;
  late Widget _widget;
  @override
  void initState() {
    super.initState();
    setState(() {
      pageType = widget.pageType;
      id = widget.id;
      _widget = widget.widget;
    });
    print(pageType);
  }

  void showMessage(String text, Color textColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey.withOpacity(0.4),
        content: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    TextEditingController comments = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
              child: getCustomFont("Tap to Rate", 20, Colors.black, 1,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 10,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, rating) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemSize: 25,
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: getCustomFont(
                  "Write a Review(Optional)", 20, Colors.black, 1,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 10,
          ),
          Container(
              width: wid * 0.7,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              )
              //getDefaultTextFieldWithLabel(context,'Write...' , comments)
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                value: select,
                onChanged: (val) {
                  setState(() {
                    select = val;
                  });
                },
              ),
              getCustomFont('Ask Anonymously', 18, Colors.black, 1,
                  fontWeight: FontWeight.w500),
            ],
          ),
          getButton(context, Color(0xff214062), 'Submit', Colors.white,
              () async {
            // var message = await submitReview(
            //     _rating, pageType, select ? 1 : 0, id, comments.text);
            // showMessage(message, Colors.green);
            comments.clear();
            Get.to(_widget);
          }, 14,
              buttonWidth: wid * 0.4,
              buttonHeight: 45,
              borderRadius: BorderRadius.circular(25))
        ],
      ),
    );
  }
}

Widget getButton(BuildContext context, Color bgColor, String text,
    Color textColor, Future<void> Function() function, double fontsize,
    {bool isBorder = false,
    EdgeInsetsGeometry? insetsGeometry,
    FontWeight weight = FontWeight.bold,
    bool isIcon = false,
    String? image,
    Color? imageColor,
    double? imageWidth,
    double? imageHeight,
    bool smallFont = false,
    double? buttonHeight,
    double? buttonWidth,
    List<BoxShadow> boxShadow = const [],
    EdgeInsetsGeometry? insetsGeometrypadding,
    BorderRadius? borderRadius,
    double? borderWidth}) {
  return InkWell(
    onTap: function,
    child: Container(
      margin: insetsGeometry,
      padding: insetsGeometrypadding,
      width: buttonWidth,
      height: buttonHeight,
      decoration: getButtonDecoration(
        bgColor,
        borderRadius: borderRadius,
        shadow: boxShadow,
        border: (isBorder)
            ? Border.all(color: Colors.blue, width: borderWidth!)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (isIcon) ? SizedBox(height: 10) : SizedBox(width: 0),
          getCustomFont(
            text, fontsize, textColor, 1,
            textAlign: TextAlign.center,
            fontWeight: weight,
            // fontFamily: Constant.fontsFamily
          )
        ],
      ),
    ),
  );
}

Widget getDefaultTextFieldWithLabel(
  BuildContext context,
  String label,
  TextEditingController textEditingController, {
  bool withSuffix = false,
  bool minLines = false,
  bool isPassword = false,
  bool isEnabled = true,
  bool isPrefix = false,
  Widget? prefix,
  double? height,
  String? suffixImage,
  Function? imageFunction,
  List<TextInputFormatter>? inputFormatters,
  FormFieldValidator<String>? validator,
  BoxConstraints? constraint,
  ValueChanged<String>? onChanged,
  double vertical = 20,
  double horizontal = 18,
  int? maxLength,
  String obscuringCharacter = '•',
  GestureTapCallback? onTap,
  bool isReadOnly = false,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        readOnly: isReadOnly,
        onTap: onTap,
        onChanged: onChanged,
        controller: textEditingController,
        obscureText: isPassword,
        maxLines: (minLines) ? null : 1,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          counter: SizedBox.shrink(),
          contentPadding: EdgeInsets.symmetric(
            vertical: vertical,
            horizontal: horizontal,
          ),
          isDense: false,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Color(0xff214062), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 24,
          ),
          suffixIcon: withSuffix
              ? InkWell(
                  onTap: () {
                    if (imageFunction != null) {
                      imageFunction();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 18),
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 24,
                    ),
                  ),
                )
              : null,
          prefixIconConstraints: constraint,
          prefixIcon: isPrefix ? prefix : null,
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        onEditingComplete: null,
      );
    },
  );
}

BoxDecoration getButtonDecoration(Color bgColor,
    {BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow> shadow = const [],
    DecorationImage? image}) {
  return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: shadow,
      image: image);
}
