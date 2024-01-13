class Produit {
  final String? idProduit;
  final String nom;
  final int prix;
  int stock;
  final String description;
  final String categorie;
  final String image;

  Produit({
    this.idProduit,
    required this.nom,
    required this.prix,
    required this.stock,
    required this.description,
    required this.categorie,
    required this.image,
  });

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
        idProduit: json['idProduit'],
        nom: json['nom'],
        prix: json['prix'],
        stock: json['stock'],
        categorie: json['categorie'],
        image: json['image'],
        description: json['description']);
  }
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prix': prix,
      'stock': stock,
      'categorie': categorie,
      'image': image,
      'description': description,
    };
  }
}
