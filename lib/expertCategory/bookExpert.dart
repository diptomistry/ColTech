import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsultantBookingForm extends StatefulWidget {
  final String email;

  const ConsultantBookingForm({super.key, required this.email});
  @override
  _ConsultantBookingFormState createState() => _ConsultantBookingFormState();
}

class ConsultantBooking {
  final String userId;
  final String name;
  final String email;
  final String message;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  ConsultantBooking({
    required this.userId,
    required this.name,
    required this.email,
    required this.message,
    this.selectedDate,
    this.selectedTime,
  });
}

class _ConsultantBookingFormState extends State<ConsultantBookingForm> {
  Color accentColor = Color(0xff214062);
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, you can perform your booking logic here
      print('Name: ${_msg.text}');
      print('Email: $email');
      print('Message: $message');
      print('Selected Date: $selectedDate');
      print('Selected Time: $selectedTime');

      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('consultantBookings').add({
        'userEmail': FirebaseAuth.instance.currentUser?.email,
        'name': FirebaseAuth.instance.currentUser?.displayName,
        'email': email,
        'message': message,
        'selectedDate': selectedDate,
        'selectedTime': selectedTime,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // You can send the data to a server or perform any other necessary actions.
    }
  }

  TextEditingController _msg = TextEditingController();
  TextEditingController _price = TextEditingController();

  Future<void> storeConsultantBooking(ConsultantBooking booking) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('consultantBookings').add({
      'userEmail': FirebaseAuth
          .instance.currentUser?.email, // Use the passed email from the widget
      'name': FirebaseAuth.instance.currentUser?.displayName,
      'email': email,
      'message': _msg.text,
      'selectedDate': selectedDate,
      'selectedTime': selectedTime,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // The booking data has been successfully stored in Firestore.
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        title: Text('Consultant Booking Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _msg,
                decoration: InputDecoration(
                  labelText: 'Your Message',
                  labelStyle: TextStyle(color: accentColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    name = value ?? '';
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Offered Price',
                  labelStyle: TextStyle(color: accentColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onSaved: (value) {
                  setState(() {
                    message = value ?? '';
                  });
                },
                controller: _price,
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(selectedDate == null
                        ? 'Select Date'
                        : 'Date: ${selectedDate?.toLocal()}'.split(' ')[0]),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(accentColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    child: Text(selectedTime == null
                        ? 'Select Time'
                        : 'Time: $selectedTime'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(accentColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: Text('Book Consultant'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(accentColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
