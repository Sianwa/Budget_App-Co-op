import 'package:flutter/cupertino.dart';

class TransactionListTile extends StatefulWidget {
  const TransactionListTile({super.key, required this.itemName, required this.itemAmount, required this.dateCreated, required this.categoryName});
  final String itemName;
  final String itemAmount;
  final String dateCreated;
  final String categoryName;

  @override
  State<TransactionListTile> createState() => _TransactionListTileState();
}

class _TransactionListTileState extends State<TransactionListTile> {
  String transactionDate = "";

  @override
  void initState() {
    formatDate();
    super.initState();
  }

  void formatDate(){}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.itemName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "Product Sans")),
              const Text("June 10, 2024",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFA6A6A6),
                      fontSize: 12,
                      fontFamily: "Product Sans")),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Ksh. ${widget.itemAmount}", style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD80000),
                  fontSize: 14,
                  fontFamily: "Product Sans")),
               Text(widget.categoryName, style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFA6A6A6),
                  fontSize: 12,
                  fontFamily: "Product Sans")),
            ],
          ),
        ],
      ),
    );
  }
}
