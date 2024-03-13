import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

class ViewInventoryScreen extends StatefulWidget {
  @override
  _ViewInventoryScreenState createState() => _ViewInventoryScreenState();
}

class _ViewInventoryScreenState extends State<ViewInventoryScreen> {
  late Stream<QuerySnapshot> _productStream;

  @override
  void initState() {
    super.initState();
    _productStream = FirebaseFirestore.instance.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF035ea8),
        title: Text('View Inventory',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No products available'),
            );
          }
          double screenWidth = MediaQuery.of(context).size.width;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 4.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'No. of Items: ${snapshot.data!.docs.length}',
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 10.0.sp : 12.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Total Price: ${_calculateTotalPrice(snapshot.data!.docs)} \u20B9',
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 10.0.sp : 12.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var productData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 4.0.w),
                      child: Container(
                        padding: EdgeInsets.all(4.0.w),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(2.0.w),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.2.w,
                              blurRadius: 0.5.w,
                              offset: Offset(0, 0.5.w),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Information',
                              style: TextStyle(
                                fontSize: screenWidth > 600 ? 10.0.sp : 14.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 2.0.h),
                            Divider(
                              color: Colors.black,
                              thickness: 0.2.w,
                            ),
                            SizedBox(height: 2.0.h),
                            _buildInfoRow('Product Name:', productData['productName'], screenWidth),
                            _buildInfoRow('Category:', productData['category'], screenWidth),
                            _buildInfoRow('Price:', '${productData['price']} \u20B9 /per item', screenWidth),
                            _buildInfoRow('Quantity:', '${productData['quantity']}', screenWidth),
                            _buildInfoRow('Product Code:', productData['productCode'], screenWidth),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _calculateTotalPrice(List<QueryDocumentSnapshot> docs) {
    double totalSum = docs.fold(0, (total, doc) => total + doc['price']);
    return totalSum.toStringAsFixed(2);
  }

  Widget _buildInfoRow(String title, String value, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth > 600 ? 10.0.sp : 14.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: screenWidth > 600 ? 10.0.sp : 14.0.sp),
          ),
        ],
      ),
    );
  }
}
