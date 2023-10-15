import 'package:coltech/expertCategory/bookExpert.dart';
import 'package:coltech/expertCategory/rate_now.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../profile/profile_edit.dart';
import 'expert_model.dart';

class DetailExpert extends StatefulWidget {
  final String type;
  final Expert expert;
  DetailExpert({super.key, required this.type, required this.expert});
  @override
  State<DetailExpert> createState() => _DetailExpertState();
}

class _DetailExpertState extends State<DetailExpert>
    with SingleTickerProviderStateMixin {
  Color accentColor = Color(0xff214062);
  Expert sponsor = Expert('name', 'profession', 'skill', 'email');
  int vendorId = 0;
  late String type;
  late Expert expert;
  bool _load = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      type = widget.type;
      expert = widget.expert;
    });
  }

  void contactExpert(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getToolBar(() {
        Get.back();
        // Get.to(AllVendors(eventId: sponsor.eventId));
      },
          title: getCustomFont(
            "Details",
            19,
            Colors.white,
            1,
            fontWeight: FontWeight.w700,
          )),
      body: _load
          ? DefaultTabController(
              length: 2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: Color(0xFF214062), width: 3)),
                          child: Image.network(
                            'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/hostedimages/1668528105i/33618060._SY540_.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //rating
                    RatingBarWidget(
                      rating: 3,
                      onRatingUpdate: (value) {},
                      pageType: 'vendors',
                      id: vendorId,
                      widget: DetailExpert(
                        type: '',
                        expert: expert,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(() => ConsultantBookingForm(
                                email: '',
                              ));
                        },
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                getCustomFont(
                                  expert.name,
                                  16,
                                  Colors.black87,
                                  1,
                                  fontWeight: FontWeight.w600,
                                ),
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    TabBar(indicatorColor: accentColor, tabs: [
                      Tab(
                        child: getCustomFont('Info', 15, Colors.black, 1,
                            fontWeight: FontWeight.w600),
                      ),
                      Tab(
                        child: getCustomFont('Reviews', 15, Colors.black, 1,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    Expanded(
                      child: TabBarView(children: [
                        SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      contactExpert('hrasel2002@gmail.com');
                                    },
                                    child: buildContactItem(
                                        Icons.email, sponsor.email)),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: buildContactItem(
                                        Icons.facebook, "Facebook")),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 17, left: 17, right: 17),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade100,
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                        offset: Offset(2, 1),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Review',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  )),
                                );
                              })),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: accentColor,
              ),
            ),
    );
  }

  _launchURL(String url) async {
    // Uri uri = Uri.parse(url);
    //
    // try {
    //   await launch(
    //     url,
    //     enableJavaScript: true,
    //     enableDomStorage: true,
    //   );
    // } catch (e) {
    //   // Handle the exception here, e.g., show an error message
    //   print('Error launching URL: $e');
    // }
  }

  Widget buildBusinessHoursRow(String day, String from, String to) {
    return Padding(
      padding: EdgeInsets.only(
          top: 15.0, left: MediaQuery.of(context).size.width * 0.2),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: getCustomFont(day, 15, Colors.black, 1,
                  fontWeight: FontWeight.w600)),
          Expanded(
              flex: 2,
              child: getCustomFont(from, 15, Colors.black, 1,
                  fontWeight: FontWeight.w600)),
          Expanded(
              flex: 2,
              child: getCustomFont(to, 15, Colors.black, 1,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget buildContactItem(IconData icon, String location) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.height * 0.025,
            ),
            Icon(
              icon,
              color: accentColor,
              size: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height * 0.02,
            ),
            getCustomFont(
              location,
              16,
              Colors.black87,
              1,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }

  fetchVendor(int vendorId) {
    return [Expert('name', 'profession', 'skill', 'email')];
  }

  Column buildAboutWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont("About", 18, Colors.black, 1,
            fontWeight: FontWeight.w600, txtHeight: 1.5),
      ],
    );
  }

  AppBar getToolBar(Function function,
      {Function? function2,
      Widget? title,
      bool leading = true,
      bool IsWeb = false,
      bool rating = false,
      bool filter = false,
      bool isHome = false,
      bool done = false,
      bool noti = false}) {
    return AppBar(
      toolbarHeight: 65,
      title: isHome ? null : title,
      systemOverlayStyle: SystemUiOverlayStyle(
          //  systemNavigationBarColor: accentColor,
          statusBarColor: accentColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      backgroundColor: IsWeb ? Colors.white : accentColor,
      elevation: 0,
      centerTitle: true,
      leading: leading == true
          ? Center(
              child: IconButton(
                onPressed: () {
                  function();
                },
                icon: Icon(Icons.arrow_back, size: 24, color: Colors.white),
              ),
            )
          : null,
      actions: [
        //   InkWell(
        //     onTap: (){
        //       function2!();
        //     },
        //     child: const Padding(
        //     padding: EdgeInsets.all(20.0),
        //     child: Center(child: Text('Submit'
        //     ,style: TextStyle(
        //         fontWeight: FontWeight.w500,
        //         fontSize: 17
        //       ),),
        //  ),
        // ),
        //   ),
        if (filter)
          InkWell(
            onTap: () async {
              function2!();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.filter_list),
            ),
          ),
        if (done)
          Center(
            child: InkWell(
              onTap: () async {
                function2!();
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: getCustomFont('Done', 18, Colors.white, 1,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        if (noti)
          InkWell(
              onTap: () {
                function2!();
              },
              child: Container(
                margin: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.notification_important,
                  color: Colors.white,
                  size: 28,
                ),
              ))
      ],
    );
  }
}

class RatingBarWidget extends StatelessWidget {
  final double rating;
  final Function(double) onRatingUpdate;
  final String pageType;
  final int id;
  final Widget widget;
  RatingBarWidget({
    required this.rating,
    required this.onRatingUpdate,
    required this.pageType,
    required this.id,
    required this.widget,
  });
  Color accentColor = Color(0xff214062);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, rating) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: 25,
            onRatingUpdate: onRatingUpdate,
          ),
          Spacer(),
          Text(
            "${rating.toStringAsFixed(2)}   Ratings ",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            "Rate Now",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () async {
              Get.to(
                () => RateNow(
                  pageType: pageType,
                  id: id,
                  widget: widget,
                ),
              );
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "asset/images/arrow_right.svg",
                color: Colors.white,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
