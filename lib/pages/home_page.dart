import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> allMahasiswa = [];
  List<dynamic> filteredMahasiswa = [];
  int currentPage = 1;
  final int perPage = 10;
  String searchQuery = '';

  Future<void> loadData() async {
    final data = await rootBundle.loadString('assets/data_mahasiswa.json');
    setState(() {
      allMahasiswa = json.decode(data);
      applyFilter();
    });
  }

  void applyFilter() {
    List<dynamic> temp = allMahasiswa;
    if (searchQuery.isNotEmpty) {
      temp = temp
          .where(
            (m) => m['nama'].toString().toLowerCase().contains(
              searchQuery.toLowerCase(),
            ),
          )
          .toList();
    }
    setState(() {
      filteredMahasiswa = temp;
      currentPage = 1;
    });
  }

  List<dynamic> getCurrentPageItems() {
    int start = (currentPage - 1) * perPage;
    int end = start + perPage;
    if (start > filteredMahasiswa.length) start = filteredMahasiswa.length;
    if (end > filteredMahasiswa.length) end = filteredMahasiswa.length;
    return filteredMahasiswa.sublist(start, end);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final currentItems = getCurrentPageItems();
    final totalPages = (filteredMahasiswa.length / perPage).ceil();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Profil Mahasiswa'),
        backgroundColor: Colors.indigo[600],
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
            child: const Text(
              'About',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari nama mahasiswa...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                searchQuery = value;
                applyFilter();
              },
            ),
          ),
          Expanded(
            child: currentItems.isEmpty
                ? const Center(child: Text("Tidak ada mahasiswa"))
                : ListView.builder(
                    itemCount: currentItems.length,
                    itemBuilder: (context, index) {
                      final mhs = currentItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            child: ClipOval(
                              child: Image.asset(
                                mhs['foto'],
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            mhs['nama'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${mhs['nim']} • ${mhs['jurusan']}'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.indigo,
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: mhs,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Pagination
          if (filteredMahasiswa.length > perPage)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: currentPage > 1
                        ? () => setState(() => currentPage--)
                        : null,
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 20),
                  Text('Halaman $currentPage dari $totalPages'),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: currentPage < totalPages
                        ? () => setState(() => currentPage++)
                        : null,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
