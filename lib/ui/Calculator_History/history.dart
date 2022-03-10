import 'package:calculatorapp/ui/Calculator_History/Model/historyitem.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);
  final List<HistoryItem> result = Hive.box<HistoryItem>('history')
      .values
      .toList()
      .reversed
      .toList()
      .cast<HistoryItem>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.indigo),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "History",
          style: TextStyle(color: Colors.indigo),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Hive.box<HistoryItem>('history').clear();
              },
              child: const Icon(
                Icons.delete_forever,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: result.isEmpty
          ? Center(
              child: Text(
                'Empty!',
                style:
                    Theme.of(context).textTheme.caption?.copyWith(fontSize: 12),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: result.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.white,
                  title: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(result[i].title)),
                  subtitle: Text(result[i].subtitle),
                );
              },
            ),
    );
  }
}
