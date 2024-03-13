import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

class DeleteProductScreen extends StatefulWidget {
  @override
  _DeleteProductScreenState createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productCodeController = TextEditingController();

  void _deleteProductFromFirebase() {
    if (_formKey.currentState!.validate()) {
      String productCode = _productCodeController.text;
      FirebaseFirestore.instance
          .collection('products')
          .where('productCode', isEqualTo: productCode)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete().then((_) {
              // Show a confirmation message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Product deleted successfully')),
              );
              // Clear the text field
              _productCodeController.clear();
            }).catchError((error) {
              // Handle errors here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to delete product: $error')),
              );
            });
          });
        } else {
          // Show an alert message if the product is not found
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Product Not Found'),
                content: Text('The product with the given code does not exist.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }).catchError((error) {
        // Handle errors here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete product: $error')),
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
          'Delete Product',
          style: TextStyle(color: Color(0xFFffffff)),
        ),
      ),
      body: Container(
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
                  prefixIcon: Icon(Icons.code),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 4.w),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _deleteProductFromFirebase,
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text(
                    'Delete Product',
                    style: TextStyle(color: Color(0xFFffffff)),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 4.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    backgroundColor: Colors.red,
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
