import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

class UpdateProductScreen extends StatefulWidget {
  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productCodeController = TextEditingController();
  final _quantityController = TextEditingController();
  bool _isUpdating = false;

  void _updateQuantityInFirebase() {
    if (_formKey.currentState!.validate() && !_isUpdating) {
      setState(() {
        _isUpdating = true;
      });
      String productCode = _productCodeController.text.trim();
      int newQuantity = int.parse(_quantityController.text);

      CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');
      productsRef
          .where('productCode', isEqualTo: productCode)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          productsRef.doc(doc.id).update({'quantity': newQuantity}).then((_) {
            setState(() {
              _isUpdating = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Quantity updated successfully')),
            );
          }).catchError((error) {
            setState(() {
              _isUpdating = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update quantity: $error')),
            );
          });
        });
      }).catchError((error) {
        setState(() {
          _isUpdating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
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
          'Update Product Quantity',
          style: TextStyle(color: Color(0xFFffffff)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF035ea8), Color(0xFF004e92)],
          ),
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _productCodeController,
                        decoration: InputDecoration(
                          labelText: 'Product Code',
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
                          labelText: 'New Quantity',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter new quantity';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid quantity';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5.h),
                      ElevatedButton(
                        onPressed: _isUpdating ? null : _updateQuantityInFirebase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF035ea8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                        ),
                        child: Text(
                          _isUpdating ? 'Updating...' : 'Update Quantity',
                          style: TextStyle(fontSize: 14.sp, color: Color(0xFFffffff)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
