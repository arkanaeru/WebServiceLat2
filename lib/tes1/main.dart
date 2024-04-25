import 'dart:convert';

void main() {
  // Potongan kode pertama
  String jsonString =
      '{"nama": "Budi Martami", "umur":17, "list_bahasa": ["C++", "Python"]}';
  Map<String, dynamic> mhsJson = jsonDecode(jsonString); //json ke Map
  print("nama: ${mhsJson['nama']}");
  print("umur: ${mhsJson['umur']}");
  print("skill: ${mhsJson['list_bahasa']}");
  //cetak satu-satu
  for (String val in mhsJson['list_bahasa']) {
    print(val);
  }

  // Potongan kode kedua
  String nama = "Arkanaeru";
  int umur = 18;
  List<dynamic> listBahasa = ["php", "js"];
  String mhs2json = jsonEncode({"nama": nama, "umur": umur, "list_bahasa": listBahasa});
  print(mhs2json);
}
