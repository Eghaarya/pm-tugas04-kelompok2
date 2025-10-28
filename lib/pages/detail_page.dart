import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mahasiswa = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profil Mahasiswa'),
        backgroundColor: Colors.indigo[600], // navbar tetap biru
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(mahasiswa['foto']),
                    radius: 50,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    mahasiswa['nama'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'NIM: ${mahasiswa['nim']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Jurusan: ${mahasiswa['jurusan']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // Semua detail lainnya
                  InfoRow(
                    label: 'Perguruan Tinggi',
                    value: mahasiswa['perguruan_tinggi'],
                  ),
                  InfoRow(
                    label: 'Jenis Kelamin',
                    value: mahasiswa['jenis_kelamin'],
                  ),
                  InfoRow(
                    label: 'Tanggal Masuk',
                    value: mahasiswa['tanggal_masuk'],
                  ),
                  InfoRow(
                    label: 'Jenjang - Program Studi',
                    value: mahasiswa['jenjang_program'],
                  ),
                  InfoRow(
                    label: 'Status Awal Mahasiswa',
                    value: mahasiswa['status_awal'],
                  ),
                  InfoRow(
                    label: 'Status Terakhir Mahasiswa',
                    value: mahasiswa['status_terakhir'],
                  ),
                  const SizedBox(height: 20),
                  // Row tombol bersampingan dengan jarak tipis
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Kembali'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12), // jarak tipis antar tombol
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/edit',
                            arguments: mahasiswa,
                          );
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[600], // hanya edit
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double labelWidth = constraints.maxWidth * 0.35;
          double valueWidth = constraints.maxWidth * 0.65;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: labelWidth,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: valueWidth,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                  softWrap: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
