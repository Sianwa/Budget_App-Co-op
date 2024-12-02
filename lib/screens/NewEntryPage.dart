import 'package:budget_app/utils/AppNavigation/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../database/BudgetDatabase.dart';
import '../utils/service_locator.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  String dropDownValue = "";
  int selectedID = 1;
  List<String> categories = [];
  TextEditingController itemName = TextEditingController();
  TextEditingController itemAmount = TextEditingController();

  late BudgetDatabase budgetDatabase;

  @override
  void initState() {
    budgetDatabase = locator<BudgetDatabase>();
    fetchCategories();
    super.initState();
  }

  Future<void> fetchCategories() async {
    var list = <Map<String, dynamic>>[];
    var catName = <String>[];
    list = await budgetDatabase.getAllCategories();

    for (Map<String, dynamic> category in list) {
      catName.add(category["name"]);
    }

    setState(() {
      categories = catName;
    });

    print("Data:: $list");
  }

  Future<void> addExpense(int categoryId, double amount, String note) async {
    var date = DateFormat("yyyy/MM/dd").format(DateTime.now());
    var resp = await budgetDatabase.addExpense(categoryId, amount, date, note);
    context.pushNamed(successScreen, queryParameters: {'budgetItem': note , 'amount': amount.toString()},);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Add New Budget Item",
                          style: TextStyle(
                              fontFamily: "Product Sans",
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 32.0),
                        child: Text(
                          "Select Category",
                          style: TextStyle(
                              fontFamily: "Product Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 12.0),
                            child: DropdownButton(
                              isExpanded: true,
                              value: dropDownValue.isNotEmpty
                                  ? dropDownValue
                                  : null,
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              hint: Text("Select Categories",
                                  style: TextStyle(
                                      fontFamily: "Product Sans",
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w400)),
                              items: categories.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item, style: const TextStyle(
                                      fontFamily: "Product Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value.toString();
                                  selectedID = categories.indexOf(value.toString()) + 1;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 32.0),
                        child: Text(
                          "Item Name",
                          style: TextStyle(
                              fontFamily: "Product Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          controller: itemName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Shopping",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontFamily: "Product Sans")),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text("Allocation", style: TextStyle(
                            fontFamily: "Product Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          controller: itemAmount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Enter allocation amount",
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade400, fontFamily: "Product Sans",)),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 36.0),
                        child: SizedBox(
                          height: 48.0,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                addExpense(selectedID, double.parse((itemAmount.text)),
                                    itemName.text);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.green),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)))),
                              child: const Text("Create New Budget Item",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Product Sans"))),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
