import 'package:gestion_stock_flutter/produit/produit.dart';
import 'package:gestion_stock_flutter/service/produit_service.dart';
import 'package:get/get.dart';

class ProduitController extends GetxController {
  RxList<Produit> produits = <Produit>[].obs;
  RxBool isLoading = false.obs;
  final ProduitService _produitService = ProduitService();

  void setIsloading(bool val) {
    isLoading.value = val;
  }

  Future<void> getProduitsFromFirebase() async {
    if (produits.isEmpty) {
      await refreshProducts();
    }
  }

  @override
  void onInit() {
    super.onInit();
    refreshProducts();
  }

  Future<void> refreshProducts() async {
    setIsloading(true);
    produits.value = await _produitService.getProduitsFromFirebase();
    setIsloading(false);
  }

  Future<void> sendProduitTofirebase() async {
    await _produitService.sendProduitTofirebase();
  }
}
