import 'package:coltech/profile/profile_edit.dart';
import 'package:coltech/profile/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//
// import '../apiCall/notification_api.dart';
// import '../base/eventBottomBar.dart';
// import '../event/eventHome.dart';

import 'package:flutter/material.dart';

import 'api/loggedInUser.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.main = false}) : super(key: key);

  final bool main;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool main;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      main = widget.main;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Color(0xff214062), statusBarBrightness: Brightness.light));
    // print(main);
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 0,
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: Color(0xff214062), statusBarBrightness: Brightness.light),
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            FutureBuilder(
                future: fetchLoggedInUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    return Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.height * 0.17,
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1380&t=st=1693564186~exp=1693564786~hmac=34badb23f9ce7734364a431e350be4ddba450762fc9d703bf10b4dc3d9f0e96b'))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.05,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff214062)),
                            child: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff214062),
                      ),
                    );
                  }
                  return CircularProgressIndicator(
                    color: Color(0xff214062),
                  );
                }),
            const SizedBox(height: 10),

            FutureBuilder(
                future: fetchLoggedInUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      return getCustomFont(
                          snapshot.data!.name, 30, Colors.brown, 1,
                          fontWeight: FontWeight.w600);
                    }
                  }
                  return CircularProgressIndicator(
                    color: Color(0xff214062),
                  );
                  return CircularProgressIndicator(
                    color: Color(0xff214062),
                  );
                }),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () => Get.to(() => UpdateProfileScreen()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff214062),
                    elevation: 5,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text('Edit Profile',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              thickness: 2,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 10),

            /// -- MENU
            // ProfileMenuWidget(
            //     title: "Settings",
            //     icon: LineAwesomeIcons.cog,
            //     onPress: () {
            //       Get.defaultDialog(
            //         title: "Notifications",
            //         titleStyle: const TextStyle(fontSize: 20),
            //         content: Padding(
            //           padding: EdgeInsets.symmetric(vertical: 15.0),
            //           child: Text(
            //             'Turn off notifications',
            //             style: TextStyle(fontWeight: FontWeight.w500),
            //           ),
            //         ),
            //         confirm: ElevatedButton(
            //           onPressed: () async {
            //             // await requestPermissionAndSendNotificationSubscription(
            //             //     8,
            //             //     enable: false);
            //           },
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: Color(0xff214062),
            //               side: BorderSide.none),
            //           child: const Text("Yes"),
            //         ),
            //         cancel: OutlinedButton(
            //             onPressed: () async {
            //               Get.back();
            //               // await requestPermissionAndSendNotificationSubscription(
            //               //     8,
            //               //     enable: true);
            //             },
            //             child: const Text(
            //               "No",
            //               style: TextStyle(color: Colors.black),
            //             )),
            //       );
            //     }),
            // ProfileMenuWidget(
            //     title: "My Booking",
            //     icon: Icons.book_online_rounded,
            //     onPress: () {
            //       // Get.to(() => const AllTicketPage());
            //     }),
            // ProfileMenuWidget(
            //     title: "Billing Details",
            //     icon: LineAwesomeIcons.wallet,
            //     onPress: () {
            //       // Get.to(() => const AllTicketPage());
            //     }),
            // ProfileMenuWidget(
            //     title: "User Management",
            //     icon: LineAwesomeIcons.user_check,
            //     onPress: () {}),
            ProfileMenuWidget(
                title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Color(0xff214062),
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: "Log Out",
                    titleStyle: const TextStyle(fontSize: 20),
                    content: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Text(
                          "Are you sure, you want to Logout?",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    confirm: ElevatedButton(
                      onPressed: () {
                        print('YEs');
                        // SharedPreferencesHelper.clearLoginDetails();
                        // Get.to(() => LoginScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff214062),
                          side: BorderSide.none),
                      child: const Text("Yes"),
                    ),
                    cancel: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.black),
                        )),
                  );
                }),

            Spacer(),
          ],
        ),
      ),
      // bottomNavigationBar: main
      //     ? SizedBox()
      //     : EventNavBar(
      //         currentIndex: 3,
      //         widget: EventHomePage(
      //           id: 8,
      //         ),
      //       ),
    );
  }
}
