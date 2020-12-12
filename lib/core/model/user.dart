class User{
  String email;
  String alamat;
  String perusahaan;
  String telp;
  String nama;
  String alamatPerusahaan;
  String photoUrl;

  User({this.nama, this.email, this.alamat, this.telp, this.perusahaan, this.alamatPerusahaan, this.photoUrl});

  User.fromMap(Map snapshot, String id)
        : email = id ?? '',
        nama = snapshot['nama'] ?? '',
        alamat = snapshot['alamat'] ?? '',
        telp = snapshot['telp'] ?? '',
        perusahaan = snapshot['perusahaan'] ?? '',
        alamatPerusahaan = snapshot['alamat_perusahaan'] ?? '',
        photoUrl = 'https://www.unr.ac.id/images/dosen_male.png';

   toJson() {
    return {
      "nama": nama,
      "alamat": alamat,
      "telp": telp,
      "perusahaan": perusahaan,
      "alamat_perusahaan": alamatPerusahaan,
      "photoUrl" : 'https://www.unr.ac.id/images/dosen_male.png'
    };
  }
}