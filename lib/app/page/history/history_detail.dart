import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/data/sharepre.dart';
import 'package:app_api/app/model/bill.dart';
import 'package:app_api/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;

  const HistoryDetail({Key? key, required this.bill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: bill.length + 1, // Add 1 for the delete button
        itemBuilder: (context, index) {
          if (index < bill.length) {
            var data = bill[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(data.productName),
                //Text(data.imageUrl),
                Text(data.price.toString()),
                Text(data.total.toString()),
                const SizedBox(
                  width: 16,
                ),
              ],
            );
          } else {
            // Display the delete button at the end
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await APIRepository().removeBill(
                      pref.getString('billID').toString(),
                      pref.getString('token').toString());
                  setIndex(1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Mainpage()));
                },
                child: const Text("Delete"),
              ),
            );
          }
        },
      ),
    );
  }
}
