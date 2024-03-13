import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

class SendFeedbackScreen extends StatefulWidget {
  @override
  _SendFeedbackScreenState createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  void _sendFeedback() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      String email = user.email ?? '';

      await firestore.collection('feedback').add({
        'uid': uid,
        'email': email,
        'text': _feedbackController.text,
        'timestamp': DateTime.now(),
      });

      // Clear the feedback text field after sending feedback
      _feedbackController.clear();

      // Show a snackbar or navigate to another screen to inform the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Feedback sent successfully!'),
      ));
    } else {
      // Handle the case where the user is not signed in
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please sign in to send feedback.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF035ea8),
        title: Text('Send Feedback', style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Feedback:',
              style: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Type your feedback here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _sendFeedback,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF035ea8), // Font color
              ),
              child: Text('Send Feedback'),
            ),

          ],
        ),
      ),
    );
  }
}

