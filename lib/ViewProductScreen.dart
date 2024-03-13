import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

class ViewProductScreen extends StatefulWidget {
  @override
  _ViewProductScreenState createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productCodeController = TextEditingController();
  List<Map<String, dynamic>> _productDataList = [];
  bool _isDataLoaded = false;

  void _fetchProductData() {
    if (_formKey.currentState!.validate()) {
      String productCode = _productCodeController.text;
      FirebaseFirestore.instance
          .collection('products')
          .where('productCode', isEqualTo: productCode)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            _productDataList =
                querySnapshot.docs.map((doc) => doc.data()).toList();
            _isDataLoaded = true;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product not found')),
          );
        }
      }).catchError((error) {
        // Handle errors here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching product data: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF035ea8),
        title: Text(
          'View Product',
          style: TextStyle(color: Color(0xFFffffff)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _productCodeController,
                  decoration: InputDecoration(
                    labelText: 'Product Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter product Code',
                    hintStyle: TextStyle(color: Colors.grey),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 1.h),
                Center(
                  child: ElevatedButton(
                    onPressed: _fetchProductData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF035ea8), // Change button color here
                    ),
                    child: SizedBox(
                      width: 12.w, // Adjust width as needed
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0, // Adjust font size as needed
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.w),
                if (_isDataLoaded)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _productDataList
                        .map((productData) => _buildProductTile(productData))
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductTile(Map<String, dynamic> productData) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(2.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.1.w,
            blurRadius: 0.3.w,
            offset: Offset(0, 0.3.w),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 2.w),
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Information',
            style: TextStyle(
              fontSize: 5.5.w,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 1.5.w),
          Divider(
            color: Colors.black,
            thickness: 0.1.w,
          ),
          SizedBox(height: 1.5.w),
          ListTile(
            title: Text(
              'Product Name:',
              style: TextStyle(
                fontSize: 4.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              productData['productName'],
              style: TextStyle(fontSize: 4.w),
            ),
          ),
          ListTile(
            title: Text(
              'Category:',
              style: TextStyle(
                fontSize: 4.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              productData['category'],
              style: TextStyle(fontSize: 4.w),
            ),
          ),
          ListTile(
            title: Text(
              'Price:',
              style: TextStyle(
                fontSize: 4.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${productData['price']}',
              style: TextStyle(fontSize: 4.w),
            ),
          ),
          ListTile(
            title: Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 4.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${productData['quantity']}',
              style: TextStyle(fontSize: 4.w),
            ),
          ),
          ListTile(
            title: Text(
              'Product Code:',
              style: TextStyle(
                fontSize: 4.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              productData['productCode'],
              style: TextStyle(fontSize: 4.w),
            ),
          ),
        ],
      ),
    );
  }
}
