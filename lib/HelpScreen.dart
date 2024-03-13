import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF035ea8),
        title: Text('Help', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.0.w),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 2.0.h),
                    Text(
                      'Welcome to the Pacxus Inventory System Help',
                      style: TextStyle(
                        fontSize: 5.0.w,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.0.h),
                    HelpItem(
                      title: 'Adding Product:',
                      description:
                      'To add a product to your inventory, navigate to the "Add Product" screen and fill in the required details such as item name, quantity, and any other relevant information. Then, press the "Add" button to save the item.',
                    ),
                    SizedBox(height: 3.0.h),
                    HelpItem(
                      title: 'Update Product:',
                      description:
                      'To update an existing product, go to the "Update Product" screen and tap on the item you want to edit. This will take you to the item details screen where you can make changes. Once done, press the "Update Product" button to update the item.',
                    ),
                    SizedBox(height: 3.0.h),
                    HelpItem(
                      title: 'Delete Product:',
                      description:
                      'To delete a product, go to the "Delete Product" screen and tap on the product code. Confirm the deletion to remove the item from your inventory.',
                    ),
                    SizedBox(height: 3.0.h),
                    HelpItem(
                      title: 'View Product:',
                      description:
                      'You can search for items using the search bar provided on the "View Product" screen. Simply type in the name or any relevant keyword to find the item you are looking for.',
                    ),
                    SizedBox(height: 3.0.h),
                    HelpItem(
                      title: 'View Inventory:',
                      description:
                      'You can view inventory in the "View Inventory" screen by tapping on the sort icon and selecting the sorting criteria such as product code.',
                    ),
                    SizedBox(height: 3.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                      child: Text(
                        'If you have any further questions or need assistance, please contact our support team.',
                        style: TextStyle(
                          fontSize: 4.0.w,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5.0.h),
                    Image.asset(
                      'assets/images/Pacxuspvt.png',
                      height: 42.0.h,
                      width: 60.0.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 3.0.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.0.h),
                      child: Center(
                        child: Text(
                          '© 2024 Pacxus Private Limited. All rights reserved.',
                          style: TextStyle(
                            fontSize: 3.0.w,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.0.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HelpItem extends StatelessWidget {
  final String title;
  final String description;

  const HelpItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 4.0.w,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.0.h),
          Text(
            description,
            style: TextStyle(fontSize: 3.0.w),
          ),
        ],
      ),
    );
  }
}
