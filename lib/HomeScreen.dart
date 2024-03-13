import 'package:classroom/HelpScreen.dart';
import 'package:classroom/SendFeedbackScreen.dart';
import 'package:flutter/material.dart';
import 'package:classroom/DeleteProductScreen.dart';
import 'package:classroom/UpdateProductScreen.dart';
import 'package:classroom/ViewInventoryScreen.dart';
import 'package:classroom/ViewProductScreen.dart';
import 'package:classroom/AddProductScreen.dart';
import 'package:classroom/HelpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:classroom/LoginScreen.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0XFF035ea8),
          title: Text("Confirm Sign Out?",style: TextStyle(color: Colors.white),),
          content: Text("Are you sure you want to sign out?",style: TextStyle(color: Colors.white),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel",style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              onPressed: () {
                // Perform sign-out action
                _signOut();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Sign Out",style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void _navigateToScreen(String text) {
    switch (text) {
      case 'Add Product':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProductScreen()),
        );
        break;
      case 'Update Warehouse':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdateProductScreen()),
        );
        break;
      case 'Delete Item':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeleteProductScreen()),
        );
        break;
      case 'View Products':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewProductScreen()),
        );
        break;
      case 'View Inventory':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewInventoryScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pacxus inventory system',
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
          color: Colors.white),
        ),
        backgroundColor: Color(0XFF035ea8),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              _confirmSignOut(context); // Pass the context if needed
            },
          ),
        ],
      ),
      drawer: Drawer(
        shadowColor: Color(0XFF035ea8),
        width: 80.w,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.w,left: 4.w),
              child: Container(
                height: 18.h, // Set the desired height
                decoration: BoxDecoration(
                  // color: Color(0XFFFFFFFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18.0.w, // Adjust the width of the image container
                      child: Image.asset(
                        'assets/images/Pacxuspvt.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Pacxus Private Limited',
                          style: TextStyle(
                            color: Color(0xFF035ea8),
                            fontSize: 14.sp, // Adjust font size as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1.h,
              thickness: 2.0.w,
              color: Color(0xFF035ea8),
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard_customize_outlined,
                color: Color(0XFF035ea8),
                size: 6.0.w, // Adjust icon size as needed
              ),
              title: Text(
                'Dashboard',
                style: TextStyle(
                  color: Color(0XFF035ea8),
                  fontWeight: FontWeight.bold,
                  fontSize: 4.5.w, // Adjust font size as needed
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback_outlined,
                color: Color(0XFF035ea8),
                size: 6.0.w, // Adjust icon size as needed
              ),
              title: Text(
                'Send feedback',
                style: TextStyle(
                  color: Color(0XFF035ea8),
                  fontWeight: FontWeight.bold,
                  fontSize: 4.5.w, // Adjust font size as needed
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SendFeedbackScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help_center_outlined,
                color: Color(0XFF035ea8),
                size: 6.0.w, // Adjust icon size as needed
              ),
              title: Text(
                'Help',
                style: TextStyle(
                  color: Color(0XFF035ea8),
                  fontWeight: FontWeight.bold,
                  fontSize: 4.5.w, // Adjust font size as needed
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Color(0XFF035ea8),
                size: 6.0.w, // Using responsive sizing with ScreenUtil // Adjust icon size as needed
              ),
              title: Text(
                'Sign Out',
                style: TextStyle(
                  color: Color(0XFF035ea8),
                  fontWeight: FontWeight.bold,
                  fontSize: 4.5.w, // Using responsive sizing with ScreenUtil
                ),
              ),
              onTap: () {
                _confirmSignOut(context);
              }, // Call sign out function on tap
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: HalfCircleClipper(),
              child: Container(
                color: Color(0XFF035ea8),
                height: 20.0.h,
                alignment: Alignment.center,
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 4.5.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GridView.count(
              padding: EdgeInsets.all(2.0.w),
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CustomContainer(
                  icon: Icons.add_circle_outline,
                  text: 'Add Product',
                  onTap: () => _navigateToScreen('Add Product'),
                ),
                CustomContainer(
                  icon: Icons.update_outlined,
                  text: 'Update Item',
                  onTap: () => _navigateToScreen('Update Warehouse'),
                ),
                CustomContainer(
                  icon: Icons.delete_forever,
                  text: 'Delete Item',
                  onTap: () => _navigateToScreen('Delete Item'),
                ),
                CustomContainer(
                  icon: Icons.view_carousel,
                  text: 'View Product',
                  onTap: () => _navigateToScreen('View Products'),
                ),
                CustomContainer(
                  icon: Icons.inventory_outlined,
                  text: 'View Inventory',
                  onTap: () => _navigateToScreen('View Inventory'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CustomContainer({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(2.5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0.h),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5.w,
              blurRadius: 1.5.w,
              offset: Offset(0, 0.5.h), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 8.0.w,
              color: Color(0XFF035ea8),
            ),
            SizedBox(height: 2.0.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 3.5.w,
                fontWeight: FontWeight.bold,
                color: Color(0XFF035ea8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
