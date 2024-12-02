import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key, this.budgetItem, this.amount});
  final String? budgetItem;
  final String? amount;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String dateNow = "";

  @override
  void initState() {
    getTodaysDate();
    super.initState();
  }

  void getTodaysDate(){
    var date = DateFormat("EEE MM yyyy").format(DateTime.now());
    setState(() {
      dateNow = date;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              SvgPicture.asset("assets/images/Vector.svg"),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "Budget Item added",
                  style: TextStyle(fontSize: 24, color: Color(0xFF80ba27), fontFamily: "Product Sans"),
                ),
              ),
              Text(
                "Budget Item has been added successfully",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade800, fontFamily: "Product Sans"),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Budget Item Name",
                      style:
                      TextStyle(fontSize: 14, color: Colors.grey.shade500, fontFamily: "Product Sans"),
                    ),
                    Text(
                      widget.budgetItem!,
                      style:
                      TextStyle(fontSize: 14, color: Colors.grey.shade800, fontFamily: "Product Sans"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Amount",
                      style:
                      TextStyle(fontSize: 14, color: Colors.grey.shade500, fontFamily: "Product Sans"),
                    ),
                    Text(
                      "KES ${widget.amount}",
                      style:
                      TextStyle(fontSize: 14, color: Color(0xFF80ba27), fontFamily: "Product Sans"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date",
                      style:
                      TextStyle(fontSize: 14, color: Colors.grey.shade500, fontFamily: "Product Sans"),
                    ),
                    Text(
                      dateNow,
                      style:
                      TextStyle(fontSize: 14, color: Colors.grey.shade800, fontFamily: "Product Sans"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: SizedBox(
                  height: 48.0,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                        StatefulNavigationShell.of(context).goBranch(0);
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(const Color(0xFF064E3B)),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)))),
                      child: const Text("Go Back Home", style: TextStyle(color: Colors.white, fontFamily: "Product Sans"))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  height: 48.0,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.green),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)))),
                      child: const Text("Rate your experience", style: TextStyle(color: Colors.white, fontFamily: "Product Sans"))),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
