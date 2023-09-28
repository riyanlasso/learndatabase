class ProductTabel {
  int? id;
  String? name, uang, keterangan, createdAt, updatedAt;
  ProductTabel(
      {this.id,
      this.name,
      this.uang,
      this.keterangan,
      this.createdAt,
      this.updatedAt});
  factory ProductTabel.fromJson(Map<String, dynamic> json) {
    return ProductTabel(
        id: json['id'],
        name: json['nama'],
        uang: json['jumlah_Uang'],
        keterangan: json['keterangan'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
