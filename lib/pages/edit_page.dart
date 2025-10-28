import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  late Map mahasiswa;

  late TextEditingController namaController;
  late TextEditingController nimController;
  late TextEditingController jurusanController;
  late TextEditingController perguruanTinggiController;
  late TextEditingController jenisKelaminController;
  late TextEditingController tanggalMasukController;
  late TextEditingController jenjangProgramController;
  late TextEditingController statusAwalController;
  late TextEditingController statusTerakhirController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mahasiswa = ModalRoute.of(context)!.settings.arguments as Map;

    namaController = TextEditingController(text: mahasiswa['nama']);
    nimController = TextEditingController(text: mahasiswa['nim']);
    jurusanController = TextEditingController(text: mahasiswa['jurusan']);
    perguruanTinggiController = TextEditingController(
      text: mahasiswa['perguruan_tinggi'],
    );
    jenisKelaminController = TextEditingController(
      text: mahasiswa['jenis_kelamin'],
    );
    tanggalMasukController = TextEditingController(
      text: mahasiswa['tanggal_masuk'],
    );
    jenjangProgramController = TextEditingController(
      text: mahasiswa['jenjang_program'],
    );
    statusAwalController = TextEditingController(
      text: mahasiswa['status_awal'],
    );
    statusTerakhirController = TextEditingController(
      text: mahasiswa['status_terakhir'],
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    jurusanController.dispose();
    perguruanTinggiController.dispose();
    jenisKelaminController.dispose();
    tanggalMasukController.dispose();
    jenjangProgramController.dispose();
    statusAwalController.dispose();
    statusTerakhirController.dispose();
    super.dispose();
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _showConfirmationDialog() async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, size: 48, color: Colors.orange[600]),
              const SizedBox(height: 16),
              const Text(
                'Apakah Anda yakin ingin menyimpan perubahan?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Batal'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context, true),
                    icon: const Icon(Icons.save),
                    label: const Text('Simpan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
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
    );

    if (confirm ?? false) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil Mahasiswa'),
        backgroundColor: Colors.indigo[600], // navbar tetap biru
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildTextField('Nama', namaController),
                buildTextField('NIM', nimController),
                buildTextField('Jurusan', jurusanController),
                buildTextField('Perguruan Tinggi', perguruanTinggiController),
                buildTextField('Jenis Kelamin', jenisKelaminController),
                buildTextField('Tanggal Masuk', tanggalMasukController),
                buildTextField(
                  'Jenjang - Program Studi',
                  jenjangProgramController,
                ),
                buildTextField('Status Awal Mahasiswa', statusAwalController),
                buildTextField(
                  'Status Terakhir Mahasiswa',
                  statusTerakhirController,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _showConfirmationDialog,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan Perubahan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600], // hanya tombol simpan
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
