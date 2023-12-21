import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Transaksi extends StatefulWidget {
  const Transaksi({Key? key}) : super(key: key);

  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.77.218/embase/public/api/all-transaksi'));

    if (response.statusCode == 200) {
      print(response);
      List<dynamic> transaksiList = json.decode(response.body);

      for (var i = 0; i < transaksiList.length; i++) {
        final idPetugas = transaksiList[i]['id'];
        final petugasResponse =
            await http.get(Uri.parse('http://192.168.77.218/embase/public/api/all-petugas/$idPetugas'));

        if (petugasResponse.statusCode == 200) {
          transaksiList[i]['nama_petugas'] = json.decode(petugasResponse.body)['nama_petugas'];
        }

        final idPangkalan = transaksiList[i]['id'];
        final pangkalanResponse =
            await http.get(Uri.parse('http://192.168.77.218/embase/public/api/all-pangkalan/$idPangkalan'));

        if (pangkalanResponse.statusCode == 200) {
          transaksiList[i]['nama_pangkalan'] = json.decode(pangkalanResponse.body)['nama_pangkalan'];
        }
      }

      return transaksiList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _showDetailDialog(Map<String, dynamic> detailTransaksi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Transaksi'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Id Transaksi: ${detailTransaksi['id']}'),
              SizedBox(height: 8.0),
              Text('Id Pangkalan: ${detailTransaksi['id_pangkalan']}'),
              SizedBox(height: 8.0),
              Text('Id Petugas: ${detailTransaksi['id_petugas']}'),
              SizedBox(height: 8.0),
              Text('Jumlah: ${detailTransaksi['jumlah']}'),
              SizedBox(height: 8.0),
              Text('Harga / Tabung: ${detailTransaksi['harga']}'),
              SizedBox(height: 8.0),
              Text('Tanggal Transaksi: ${detailTransaksi['date']}'),
              SizedBox(height: 8.0),
              Text('Status Transaksi: ${detailTransaksi['status_transaksi']}'),
              SizedBox(height: 8.0),
              Text('Status Pengiriman: ${detailTransaksi['status_pengiriman']}'),
              // Tambahkan elemen-elemen lainnya sesuai kebutuhan
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Daftar Transaksi',
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 162, 171, 189),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> transaksiList = snapshot.data!;
            return ListView.builder(
              itemCount: transaksiList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      _showDetailDialog(transaksiList[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Id Transaksi: ${transaksiList[index]['id']}'),
                          SizedBox(height: 8.0),
                          Text('Status Transaksi: ${transaksiList[index]['status_transaksi']}'),
                          SizedBox(height: 8.0),
                          Text('Tanggal Transaksi: ${transaksiList[index]['date']}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
