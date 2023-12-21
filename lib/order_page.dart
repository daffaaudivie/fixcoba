import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fixcoba/main.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DateTime selectedDate = DateTime.now();
  int jumlahTabung = 0;
  TextEditingController jumlahTabungController = TextEditingController();

  List<String> paymentOptions = [
    'Pilih Metode',
    'BRI - 450273862',
    'GOPAY-085155423'
  ];
  String
   selectedPaymentOption = 'Pilih Metode'; // Initialize with the first option

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023), // Tanggal awal yang dapat dipilih
      lastDate: DateTime(2030), // Tanggal akhir yang dapat dipilih
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _tambahJumlahTabung() {
    setState(() {
      jumlahTabung++;
      jumlahTabungController.text = jumlahTabung.toString();
    });
  }

  void _kurangiJumlahTabung() {
    if (jumlahTabung > 0) {
      setState(() {
        jumlahTabung--;
        jumlahTabungController.text = jumlahTabung.toString();
      });
    }
  }

  void _updateJumlahTabung(String value) {
    final newValue = int.tryParse(value);
    if (newValue != null && newValue >= 0) {
      setState(() {
        jumlahTabung = newValue;
      });
    }
  }

  @override
  void dispose() {
    jumlahTabungController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Order Tabung Gas',
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 162, 171, 189),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            margin: EdgeInsets.all(25),
            width: 450,
            height: 380,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 228, 223),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.lightGreen,
                width: 4,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Harga Per Produk',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 60),
                    Text(
                      'Rp.17.000',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 121, 145, 158),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Tanggal Kirim',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 75),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 4),
                          Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 121, 145, 158),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Jumlah Tabung',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 60),
                    IconButton(
                      onPressed: _kurangiJumlahTabung,
                      icon: Icon(Icons.remove_circle),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 30,
                      child: TextField(
                        controller: jumlahTabungController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: _updateJumlahTabung,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Jumlah Tabung',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 0),
                    IconButton(
                      onPressed: _tambahJumlahTabung,
                      icon: Icon(Icons.add_circle),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Pembayaran',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 70),
                    DropdownButton<String>(
                      value: selectedPaymentOption,
                      items: paymentOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPaymentOption = newValue!;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 150),
        child: ElevatedButton(
          onPressed: () {
            debugPrint('Buat Order');
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100)),
          child: Text(
            'Buat Order',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
