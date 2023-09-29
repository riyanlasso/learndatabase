class ProductTabel {
  int? id;
  String? tanggal, status, uang, keterangan, createdAt, updatedAt;
  ProductTabel(
      {this.id,
      this.tanggal,
      this.status,
      this.uang,
      this.keterangan,
      this.createdAt,
      this.updatedAt});
  factory ProductTabel.fromJson(Map<String, dynamic> json) {
    return ProductTabel(
        id: json['id'],
        tanggal: json['tanggal'],
        status: json['status'],
        uang: json['jumlah_Uang'],
        keterangan: json['keterangan'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
