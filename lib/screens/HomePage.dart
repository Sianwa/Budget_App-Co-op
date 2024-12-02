import 'package:budget_app/elements/TransactionListTile.dart';
import 'package:budget_app/elements/categoryListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../database/BudgetDatabase.dart';
import '../utils/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BudgetDatabase budgetDatabase;
  var expensesList = <Map<String, dynamic>>[];
  var expensesCategoryList = <Map<String, dynamic>>[];
  var monthlyBudget = "";
  var myTotalExpenses = 0.0;
  @override
  void initState() {
    budgetDatabase = locator<BudgetDatabase>();
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    var list = <Map<String, dynamic>>[];

    var expList = <Map<String, dynamic>>[];
    list = await budgetDatabase.getExpenses();
    var budget = await budgetDatabase.getAllBudgets();
    var totalExpenses = await budgetDatabase.getTotalExpenses();
    var totalExpensesByCategory = await budgetDatabase.getTotalExpensesByCategory();

    for (Map<String, dynamic> expense in list) {
      expList.add(expense);
    }

    setState(() {
      expensesList = expList;
      monthlyBudget = budget[0]["remaining"].toString();
      myTotalExpenses = totalExpenses;
      expensesCategoryList = totalExpensesByCategory;
    });

    print("Data:: $totalExpensesByCategory");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                SvgPicture.asset("assets/images/Ellipse 9.svg"),
                const Text(
                  "Welcome Back, Kibunja 👋",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Product Sans"),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_rounded))
            ],
          ),
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: fetchData,
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Card(
                            elevation: 0,
                            color: Colors.green,
                            child: Column(children: [
                              const Spacer(),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "$monthlyBudget ",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Product Sans",
                                        fontSize: 48,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: "ksh.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: "Product Sans",
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text("remaining on your monthly budget",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Product Sans")),
                              const Spacer()
                            ]),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 20,
                        color: Colors.grey.shade200,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total spend this month",
                                  style: TextStyle(fontFamily: "Product Sans"),
                                ),
                                Text(
                                  "Ksh. ${myTotalExpenses}",
                                  style: TextStyle(
                                      fontFamily: "Product Sans", fontSize: 24),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: expensesCategoryList.length,
                                      itemBuilder: (context, index) {
                                        return CategoryListTile(
                                          categoryName: expensesCategoryList[index]["categoryName"],
                                          categoryTotalAmount:expensesCategoryList[index]["totalAmount"].toString() ,
                                        );
                                      }),
                                )
                              ])),
                      Divider(
                        thickness: 20,
                        color: Colors.grey.shade200,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Recent Transactions",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: "Product Sans"),
                                    ),
                                    Text(
                                      "View All",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Color(0xFF80BA27),
                                          fontFamily: "Product Sans"),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: expensesList.length,
                                      itemBuilder: (context, index) {
                                        return TransactionListTile(
                                            itemName: expensesList[index]["note"],
                                            itemAmount: expensesList[index]
                                                    ["amount"]
                                                .toString(),
                                            dateCreated: expensesList[index]
                                                ["date"],
                                            categoryName: expensesList[index]
                                                ["categoryName"]);
                                      }),
                                )
                              ])),
                    ],
                  ),
                )),
          )),
    );
  }
}
