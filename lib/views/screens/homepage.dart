import 'package:currency_convertor/helpers/CurrencyHelper.dart';
import 'package:currency_convertor/main.dart';
import 'package:currency_convertor/model/Currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Currency?> future;

  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    future = CurrencyHelper.currencyHelper
        .fetchCurrency(from: "USD", to: "INR", amount: 1);

    amountController.text = "1";
  }

  String fromCurrency = "USD";
  String toCurrency = "INR";

  @override
  Widget build(BuildContext context) {
    return (Globals.isIos == false)
        ? Scaffold(
            backgroundColor: const Color(0xffEEE9DA),
            appBar: AppBar(
              title: const Text(
                "Currency Convertor",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                Switch(
                  onChanged: (val) {
                    Globals.isIos = val;

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (route) => false);
                  },
                  value: Globals.isIos,
                ),
              ],
            ),
            body: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    Currency? data = snapshot.data;
                    return (data != null)
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01,
                            ),
                            const Center(
                              child: Text(
                                "Enter Amount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100),
                                child: TextField(
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 20),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "From",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.06,
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.35,
                                      child: DropdownButtonFormField(
                                          value: fromCurrency,
                                          items: Globals.currency
                                              .map(
                                                (e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              fromCurrency =
                                                  val!.toString();
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "To",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.06,
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.35,
                                      child: DropdownButtonFormField(
                                          value: toCurrency,
                                          items: Globals.currency
                                              .map(
                                                (e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              toCurrency = val!.toString();
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.07,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Rate : ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${data.rate}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Result : ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${data.result}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.07,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.07,
                              width:
                                  MediaQuery.of(context).size.width * 0.5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  if (amountController.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        //  backgroundColor: Global.appColor,
                                        behavior: SnackBarBehavior.floating,
                                        content:
                                            Text("Please Enter Amount"),
                                      ),
                                    );
                                  } else {
                                    int amount =
                                        int.parse(amountController.text);
                                    setState(() {
                                      future = CurrencyHelper.currencyHelper
                                          .fetchCurrency(
                                              from: fromCurrency,
                                              to: toCurrency,
                                              amount: amount);
                                    });
                                  }
                                },
                                child: const Text(
                                  "Convert",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : const Center(
                            child: Text("Data Not Found"),
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              trailing: CupertinoSwitch(
                  value: Globals.isIos,
                  onChanged: (val) {
                    Globals.isIos = val;

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (route) => false);
                  }),
              middle: const Text("Currency Convertor"),
            ),
            child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    Currency? data = snapshot.data;
                    return (data != null)
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01,
                            ),
                            const Text(
                              "Enter Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100),
                                child: CupertinoTextField(
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // InputDecoration(
                                  //   contentPadding:
                                  //       const EdgeInsets.only(left: 20),
                                  //   border: OutlineInputBorder(
                                  //     borderRadius:
                                  //         BorderRadius.circular(10),
                                  //   ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "From",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) => Column(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Container(
                                                    color:
                                                    Colors.black26,
                                                  ),),),
                                              Expanded(
                                                child: CupertinoPicker(
                                                  backgroundColor:
                                                  Colors.white,
                                                  itemExtent: 30,
                                                  children: Globals
                                                      .currency
                                                      .map((e) {
                                                    return Text(
                                                      e,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                            0.5),
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onSelectedItemChanged:
                                                      (value) {
                                                    setState(() {
                                                      fromCurrency = Globals
                                                          .currency[
                                                      value];
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.05,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.25,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              fromCurrency,
                                            ),
                                            const Icon(
                                              CupertinoIcons.add_circled,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "To",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) => Column(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.black26,
                                                      ),),),
                                              Expanded(
                                                child: CupertinoPicker(
                                                  backgroundColor:
                                                      Colors.white,
                                                  itemExtent: 30,
                                                  children: Globals
                                                      .currency
                                                      .map((e) {
                                                    return Text(
                                                      e,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .black
                                                            .withOpacity(
                                                                0.5),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onSelectedItemChanged:
                                                      (value) {
                                                    setState(() {
                                                      toCurrency = Globals
                                                              .currency[
                                                          value];
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.05,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              toCurrency,
                                            ),
                                            const Icon(
                                              CupertinoIcons.add_circled,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.06,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Rate : ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${data.rate}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Result : ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${data.result}",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.07,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.08,
                              width:
                                  MediaQuery.of(context).size.width * 0.3,
                              child: CupertinoButton(
                                onPressed: () {
                                  if (amountController.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content:
                                            Text("Please Enter Amount"),
                                      ),
                                    );
                                  } else {
                                    int amount =
                                        int.parse(amountController.text);
                                    setState(() {
                                      future = CurrencyHelper.currencyHelper
                                          .fetchCurrency(
                                              from: fromCurrency,
                                              to: toCurrency,
                                              amount: amount);
                                    });
                                  }
                                },
                                child: const Text(
                                  "Convert",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : const Center(
                            child: Text("Data Not Found"),
                          );
                  }
                  return const Center(
                    child: CupertinoActivityIndicator(radius: 15),
                  );
                }),
          );
  }
}
