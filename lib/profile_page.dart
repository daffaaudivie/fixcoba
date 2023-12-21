import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.77.218/embase/public/api/all-pangkalan'));

    if (response.statusCode == 200) {
      print(response);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _showDetailDialog(BuildContext context, Map<String, dynamic> detailPangkalan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Pangkalan'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Id Pangkalan: ${detailPangkalan['id']}'),
              SizedBox(height: 8.0),
              Text('Nama Pangkalan: ${detailPangkalan['nama_pangkalan']}'),
              Text('Nomor Pangkalan: ${detailPangkalan['nomor_pangkalan']}'),
              SizedBox(height: 8.0),
              Text('Nama Provinsi: ${detailPangkalan['nama_provinsi']}'),
              SizedBox(height: 8.0),
              Text('Nama Kota: ${detailPangkalan['nama_kota']}'),
              SizedBox(height: 8.0),
              Text('Nama Kecamatan: ${detailPangkalan['nama_kecamatan']}'),
              SizedBox(height: 8.0),
              Text('Nama Kelurahan: ${detailPangkalan['nama_kelurahan']}'),
              SizedBox(height: 8.0),
              Text('Kode Pos: ${detailPangkalan['kode_pos']}'),
              SizedBox(height: 8.0),
              Text('Alamat: ${detailPangkalan['alamat']}'),
              SizedBox(height: 8.0),
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
            'Data Pangkalan',
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
            List<dynamic> pangkalanList = snapshot.data!;
            return ListView.builder(
              itemCount: pangkalanList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      _showDetailDialog(context, pangkalanList[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Id Pangkalan: ${pangkalanList[index]['id']}'),
                          // SizedBox(height: 8.0),
                          Text(
                          'Nama Pangkalan: ${pangkalanList[index]['nama_pangkalan']}',
                          style: TextStyle(
                          fontSize: 18.0, // Ubah sesuai dengan ukuran yang Anda inginkan
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text('Alamat: ${pangkalanList[index]['alamat']}')

                          // Tambahkan elemen-elemen lainnya sesuai kebutuhan
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
