import 'package:coltech/expertCategory/allExperts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../consultation_category/conscat_firestore.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  var catImag = ['https://icons8.com/icon/61864/artificial-intelligence'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 18, top: 50, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Rasel!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Find Experts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            //categories
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: FutureBuilder(
                  future: fetchConsCats(),
                  builder: (context, snapshot) {
                    var categories = snapshot.data;
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    else
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => AllExpertsPage(
                                    speakerId:
                                        int.parse(categories![index].id)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 0, right: 10, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 18)
                                    ]),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      categories![index].image,
                                      width: 40,
                                    ),
                                    Text(
                                      categories![index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    // Text(
                                    //   '25 Available',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w500,
                                    //       fontSize: 16,
                                    //       color: Colors.grey),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          });
                  }),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Upcoming Schedules',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 6,
            ),
            //upcoming schedules of user
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.26,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 0, right: 18, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 18)
                          ]),
                      height: MediaQuery.of(context).size.height * 0.067,
                      width: MediaQuery.of(context).size.width * 0.69,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildInfoContainer(
                                  Icons.date_range, 'Date', '12 Dec'),
                              buildInfoContainer(
                                  Icons.access_time, 'Time', '10:00 AM'),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildInfoContainer(
                                  Icons.person, 'User', 'John Doe'),
                              buildInfoContainer(Icons.location_on, 'Location',
                                  'City, Country'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xff214062),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'Join',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Past Bookings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.239,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(9),
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 10)
                          ]),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.all(3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset(
                          //   'assets/ai.png',
                          //   width: 40,
                          // ),
                          Text(
                            'Devops',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '25 Available',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoContainer(IconData icon, String text, String subtext) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.3,
      margin: EdgeInsets.only(right: 8, left: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.blue.withOpacity(0.2))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              Text(
                subtext,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
