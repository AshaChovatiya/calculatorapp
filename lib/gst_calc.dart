import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: 'GST Calculator', home: GstCalculator()));
}

class GstCalculator extends StatefulWidget {
  const GstCalculator({Key? key}) : super(key: key);

  @override
  State<GstCalculator> createState() => _GstCalculatorState();
}

class _GstCalculatorState extends State<GstCalculator> {
  double billAmount = 0;
  double calculatedGst = 0;
  double total = 0;
  double subgst = 0;
  double sgst = 0;
  double cgst = 0;
  double gstvalue = 0;
  double gstvaluehalf = 0;

  List<double> gstpersontage = [5, 12, 18, 28];
  List<String> gstplustext = ["+5", "+12", "+18", "+28"];
  List<String> gstminustext = ["-5", "-12", "-18", "-28"];

  int selecIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "GST",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold),
                ),
              ),

              // SGST
              Container(
                  height: 30,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SGST [$gstvaluehalf%]",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$sgst",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.indigo),
                      ),
                    ],
                  )),
              // GST
              Container(
                  height: 30,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CGST [$gstvaluehalf%]",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$cgst",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.indigo),
                      ),
                    ],
                  )),
              //GST
              Container(
                  height: 30,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "GST [$gstvalue%]",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$calculatedGst",
                        // "Total Rs.: $total",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.indigo),
                      ),
                    ],
                  )),
              //Total
              Container(
                  height: 30,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "$total",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.indigo),
                      ),
                    ],
                  )),
              //Add Amount
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                    decoration: const InputDecoration(
                        labelText: "Original Amount", hintText: "00"),
                    maxLength: 15,
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      try {
                        billAmount = double.parse(value.toString());
                      } catch (exception) {
                        billAmount = 0.0;
                      }
                    }),
              ),

              //++Gst
              Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: GridView.builder(
                  itemCount: gstpersontage.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 2),
                  itemBuilder: (context, index) => Container(
                    width: 85,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: ElevatedButton(
                        child: Text(
                          gstplustext[index],
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            gstvalue = gstpersontage[index];
                            gstvaluehalf = gstpersontage[index] / 2;
                            selecIndex = index;
                            calculatedGst =
                                billAmount * gstpersontage[index] / 100;
                            total = billAmount + calculatedGst;
                            sgst = calculatedGst / 2;
                            cgst = calculatedGst / 2;
                          });
                        }),
                  ),
                ),
              ),
              //-- Gst
              Container(
                height: 55,
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: GridView.builder(
                  itemCount: gstpersontage.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 2),
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: ElevatedButton(
                        child: Text(
                          gstminustext[index],
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            gstvalue = gstpersontage[index];
                            gstvaluehalf = gstpersontage[index] / 2;
                            selecIndex = index;
                            calculatedGst = billAmount -
                                (billAmount *
                                    (100 / (100 + gstpersontage[index])));
                            total = billAmount - calculatedGst;
                            sgst = calculatedGst / 2;
                            cgst = calculatedGst / 2;
                          });
                        }),
                  ),
                ),
              ),

              //text
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                width: double.infinity,
                child: const Text(
                  "Tips:",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Goods and Services Tax which is abbreviated as GST in the form of tax that has been imposed by the Government of India at the national level. Several GST Calculators are available on online websites which can be used to determine the GST cost.",
                  textAlign: TextAlign.justify,
                ),
              )
            ]),
          ),
        ));
  }
}
