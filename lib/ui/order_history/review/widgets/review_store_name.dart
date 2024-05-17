import 'package:flutter/cupertino.dart';

class ReviewStoreName extends StatelessWidget {
  const ReviewStoreName({
    super.key,
    required this.storeName,
    required this.storeAddress,
  });

  final storeName;
  final storeAddress;

  @override
  Widget build(BuildContext context) {
  return Text(
  "${storeName} ${storeAddress}\n후기를 작성해 주세요",
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  );
  }
}