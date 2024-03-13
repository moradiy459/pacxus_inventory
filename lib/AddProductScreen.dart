import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _quantityController = TextEditingController();
  bool _isAdding = false;

  void _addProductToFirebase() {
    if (_formKey.currentState!.validate() && !_isAdding) {
      setState(() {
        _isAdding = true;
      });
      FirebaseFirestore.instance.collection('products').add({
        'productName': _productNameController.text,
        'category': _categoryController.text,
        'price': double.parse(_priceController.text),
        'productCode': _productCodeController.text,
        'quantity': _quantityController.text,
      }).then((value) {
        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );
        // Clear the text fields after a delay of 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _isAdding = false;
          });
          _productNameController.clear();
          _categoryController.clear();
          _priceController.clear();
          _productCodeController.clear();
          _quantityController.clear();
        });
      }).catchError((error) {
        // Handle errors here
        setState(() {
          _isAdding = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $error')),
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
          'Add Product Details',
          style: TextStyle(color: Color(0xFFffffff)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(6.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 3.h),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: Icon(Icons.shopping_bag),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 3.h),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 3.h),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.currency_rupee_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 3.h),
              TextFormField(
                controller: _productCodeController,
                decoration: InputDecoration(
                  labelText: 'Product Code',
                  prefixIcon: Icon(Icons.code),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 3.h),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  prefixIcon: Icon(Icons.format_list_numbered),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 3.h),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _isAdding ? 8.h : null,
                child: ElevatedButton(
                  onPressed: _isAdding ? null : _addProductToFirebase,
                  child: _isAdding
                      ? CupertinoActivityIndicator()
                      : Text(
                    'Add Product',
                    style: TextStyle(fontSize: 12.sp,color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 2.h), backgroundColor: Color(0xFF035ea8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    textStyle: TextStyle(fontSize: 14.sp),
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
