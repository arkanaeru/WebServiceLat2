import 'dart:convert';

void main() {
  // JSON untuk transkrip mahasiswa
  String transkripJson = '''
  {
    "nim": "123456",
    "nama": "Budi Martami",
    "nilai": [
      {"kode_mk": "BP1", "nama_mk": "Bahasa Pemrograman 1", "sks": 3, "nilai": "A"},
      {"kode_mk": "BP2", "nama_mk": "Bahasa Pemrograman 2", "sks": 3, "nilai": "B"},
      {"kode_mk": "PB1", "nama_mk": "Pengetahuan Bisnis", "sks": 3, "nilai": "C"},
      {"kode_mk": "MK1", "nama_mk": "Matematika Komputasi", "sks": 3, "nilai": "D"}
    ]
  }
  ''';

  // Konversi JSON transkrip mahasiswa ke objek Map
  Map<String, dynamic> transkrip = jsonDecode(transkripJson);

  // Hitung IPK
  double ipk = hitungIPK(transkrip);
  print("IPK Mahasiswa: $ipk");
}

double hitungIPK(Map<String, dynamic> transkrip) {
  List<dynamic> nilai = transkrip['nilai'];
  double totalBobot = 0;
  int totalSKS = 0;

  for (var mataKuliah in nilai) {
    int sks = mataKuliah['sks'];
    String huruf = mataKuliah['nilai'];

    // Konversi nilai huruf ke bobot
    double bobot = konversiNilaiKeBobot(huruf);

    // Hitung bobot total
    totalBobot += bobot * sks;

    // Hitung total SKS
    totalSKS += sks;
  }

  // Hitung IPK
  double ipk = totalBobot / totalSKS;
  return ipk;
}

double konversiNilaiKeBobot(String huruf) {
  switch (huruf) {
    case 'A':
      return 4.0;
    case 'B':
      return 3.0;
    case 'C':
      return 2.0;
    case 'D':
      return 1.0;
    default:
      return 0.0;
  }
}
