// import 'package:event/HomeNavigator.dart';
// import 'package:event/base/eventBottomBar.dart';
// import 'package:event/data/data_file.dart';
// import 'package:event/event/eventHome.dart';
// import 'package:event/modal/modal_speaker.dart';
// import 'package:event/Expert/speaker_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coltech/expertCategory/expert_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../profile/profile_edit.dart';
import 'expert_detail.dart';

// import '../../../base/color_data.dart';
// import '../../../base/constant.dart';
// import '../../../base/widget_utils.dart';

// import 'all_about_speaker.dart';

class AllExpertsPage extends StatefulWidget {
  final String type;
  const AllExpertsPage({Key? key, required this.type}) : super(key: key);

  @override
  State<AllExpertsPage> createState() => _AllExpertsPageState();
}

class _AllExpertsPageState extends State<AllExpertsPage> {
  late String type;

  late Future<List<Expert>> _speakersFuture;
  List<Expert> _filteredSpeakers = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      type = widget.type;
    });
    _speakersFuture = fetchSpeakers();
  }

  Color accentColor = Color(0xff214062);
  Future<List<Expert>> fetchSpeakers() async {
    try {
      final speakers = await fetchExperts();
      List<Expert> lis = [];
      for (var it in speakers) {
        if (it.skill.toLowerCase() == type.toLowerCase()) {
          lis.add(it);
        }
      }
      setState(() {
        _allSpeakers = lis;
        _filteredSpeakers = lis;
      });
      return lis;
    } catch (e) {
      throw e;
    }
  }

  void fetch() async {}
  List<Expert> _allSpeakers = [];
  void filterSpeakers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSpeakers = _allSpeakers;
      } else {
        // Filter speakers based on the query
        _filteredSpeakers = _allSpeakers
            .where((Expert) =>
                Expert.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        // appBar: getToolBar(() {
        //   Get.to(EventHomePage(id: eventId));
        // },
        //     title: getCustomFont(
        //       "Speakers",
        //       20.sp,
        //       Colors.white,
        //       1,
        //       fontWeight: FontWeight.w700,
        //     )),
        body: SafeArea(
          child: Column(
            children: [
              getDivider(
                Colors.red.withOpacity(0.5),
                1,
              ),
              getVerSpace(16),
              buildSearchWidget(context),
              getVerSpace(24),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${type} Experts',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder<List<Expert>>(
                  future: _speakersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: accentColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No experts found in this field.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    } else {
                      List<Expert> speakers = _filteredSpeakers;
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: speakers.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Expert expert = speakers[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => DetailExpert(
                                    type: expert.skill,
                                    expert: _filteredSpeakers[index],
                                  ));
                              // Constant.sendToScreen(
                              //     SpeakerDetails(speakerID: Expert.id),
                              //     context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(2, 4))
                                  ],
                                  borderRadius: BorderRadius.circular(22)),
                              padding: EdgeInsets.only(
                                  top: 7, left: 7, bottom: 6, right: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image(
                                            image: NetworkImage(
                                                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSCnEfnEadyXeXd3jIno2PWRv2fOz6M8PIAr1KOswWM7ZTORnlX'),
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        getHorSpace(10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              getCustomFont(expert.name ?? "",
                                                  18, Colors.black, 1,
                                                  fontWeight: FontWeight.w600,
                                                  txtHeight: 1.5),
                                              getVerSpace(4),
                                              getCustomFont(
                                                  expert.profession ?? '',
                                                  15,
                                                  Colors.grey,
                                                  1,
                                                  fontWeight: FontWeight.w500,
                                                  txtHeight: 1.46)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Constant.sendToScreen(
                                      //     SpeakerDetails(speakerID: Expert.id),
                                      //     context);
                                    },
                                    child: Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                          color: Color(0xff214062),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.keyboard_arrow_right_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),

        // ... (rest of the widget code)
      ),
    );
  }

  TextEditingController searchController = TextEditingController();

  Widget buildSearchWidget(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: 20),
      getDefaultTextFieldWithLabel(
        context,
        "Search experts...",
        searchController,
        prefix: Row(
          children: [
            getHorSpace(18),
            Icon(Icons.search, size: 24),
          ],
        ),
        constraint: BoxConstraints(maxHeight: 24, maxWidth: 55),
        vertical: 18,
        horizontal: 16,
        onChanged: filterSpeakers,
      ),
    );
  }

  Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
    return Padding(
      padding: edgeInsets,
      child: widget,
    );
  }

  Widget getDivider(Color color, double thickness) {
    return Divider(
      color: color,
      thickness: thickness,
    );
  }

  Widget getHorSpace(double verSpace) {
    return SizedBox(
      width: verSpace,
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
              borderSide: BorderSide(color: Color(0xff323279), width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xff323279), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xff323279), width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xff323279), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xff323279), width: 1),
            ),
            errorStyle: TextStyle(
              color: Color(0xff323279),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Color(0xff323279), width: 1),
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
                      child: SvgPicture.asset(
                        suffixImage.toString(),
                        width: 24,
                        height: 24,
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

  Widget getVerSpace(double verSpace) {
    return SizedBox(
      height: verSpace,
    );
  }

// ... (other methods)
}
