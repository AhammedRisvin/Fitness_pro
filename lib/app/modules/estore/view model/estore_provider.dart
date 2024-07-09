// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:olympic/app/core/app_router.dart';
import 'package:olympic/app/helpers/common_widget.dart';
import 'package:olympic/app/modules/estore/model/estore_cart_model.dart';
import 'package:olympic/app/modules/estore/model/estore_category_model.dart';
import 'package:olympic/app/modules/estore/model/estore_wishlist_model.dart';
import 'package:olympic/app/modules/estore/model/product_detail_model.dart';
import 'package:olympic/app/modules/estore/view/cart_screen.dart';
import 'package:olympic/app/modules/estore/view/favourites_screen.dart';
import 'package:olympic/app/modules/estore/view/home_screen.dart';
import 'package:olympic/app/modules/estore/view/search_screen.dart';
import 'package:olympic/app/utils/app_constants.dart';
import 'package:olympic/app/utils/app_images.dart';
import 'package:olympic/app/utils/extensions.dart';
import 'package:olympic/app/utils/loading_overlay.dart';

import '../../../core/estore_client_service.dart';
import '../../../core/string_const.dart';
import '../../../utils/enums.dart';
import '../model/estore_items_model.dart';
import '../model/get_order_histoy_model.dart';
import '../model/serching_model.dart';

class EstoreProvider with ChangeNotifier {
  TextEditingController serchingController = TextEditingController();
  //BOTTOM NAV
  final screens = [
    const EstoreHomeScreen(),
    const EstoreSearchScreen(),
    const EstoreFavouritesScreen(),
    const EstoreCartScreen()
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify all listening widgets of the change.
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
  //BOTTOM NAV END

  //SEARCH
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void performSearch() {
    // Perform search operation with the provided query
    log('Searching for: $_searchQuery');
    // You can implement your search logic here
  }

  //CART

  int noOfItems = 0;

  void increment() {
    noOfItems++;
    notifyListeners();
  }

  void decrement() {
    if ((noOfItems > 0)) {
      noOfItems--;
    }
    notifyListeners();
  }

  //Get Order History

  GetOrderHistoryStatus getOrderHistoryStatus = GetOrderHistoryStatus.initial;

  List<GetEstoreOrderHistory> estoreOrderHistoryList = [];

  Future<GetEstoreOrderHistory> getEstoreOrderHistory() async {
    getOrderHistoryStatus = GetOrderHistoryStatus.loading;
    try {
      List response = await EstoreServerClient.get(StringConst.getOrderHIstory);
      log("-0-------------------response : $response");
      if (response.first >= 200 && response.first < 300) {
        GetEstoreOrderHistory slotModel =
            GetEstoreOrderHistory.fromJson(response.last);
        log('${slotModel.toJson()}');
        estoreOrderHistoryList.clear();
        estoreOrderHistoryList.add(slotModel);
        notifyListeners();
        getOrderHistoryStatus = GetOrderHistoryStatus.loaded;
        return slotModel;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getOrderHistoryStatus = GetOrderHistoryStatus.error;
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  //Get Order History

  GetProductsCategoryStatus getProductsCategoryStatus =
      GetProductsCategoryStatus.initial;

  List<EstoreProductCategory> estoreProductCategoryList = [];

  Future<EstoreProductCategoryModel> getEstoreCategoryFn() async {
    getProductsCategoryStatus = GetProductsCategoryStatus.loading;
    try {
      List response =
          await EstoreServerClient.get(StringConst.getOrderCategory);
      if (response.first >= 200 && response.first < 300) {
        EstoreProductCategoryModel slotModel =
            EstoreProductCategoryModel.fromJson(response.last);

        estoreProductCategoryList.clear();
        estoreProductCategoryList.addAll(slotModel.categories!);
        final tempItem = EstoreProductCategory(name: 'All Products', image: '');
        estoreProductCategoryList.insert(0, tempItem);
        notifyListeners();
        getProductsCategoryStatus = GetProductsCategoryStatus.loaded;

        return slotModel;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getProductsCategoryStatus = GetProductsCategoryStatus.error;
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  GetProductsStatus getProductsStatus = GetProductsStatus.initial;

  List<EStoreProduct> estoreProductsList = [];

  Future<EStoreItemModel?> getEstoreProductsFn() async {
    getProductsStatus = GetProductsStatus.loading;
    estoreProductsList.clear();
    isCatogorized = false;
    try {
      List response =
          await EstoreServerClient.get(StringConst.getEStoreItemUrl);
      if (response.first >= 200 && response.first < 300) {
        log("object ${response.first}");
        EStoreItemModel slotModel = EStoreItemModel();
        try {
          slotModel = EStoreItemModel.fromJson(response.last);
          log("object 123 $slotModel");
        } catch (e) {
          log("object 12345 $e");
        }

        log("object $slotModel");
        estoreProductsList.clear();
        estoreProductsList.addAll(slotModel.products ?? []);
        log("object $estoreProductsList");
        getProductsStatus = GetProductsStatus.loaded;
        notifyListeners();
        return slotModel;
      } else {
        log("object ERRRRRRRRORRRRRRRRRRRRRR");
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getProductsStatus = GetProductsStatus.error;
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  bool isCarted = false;
  String tempCategoryName = '';
  bool isCatogorized = false;
  Future<EStoreItemModel> getEstoreProductsByCategoryFn(
      {required String categoryName}) async {
    getProductsStatus = GetProductsStatus.loading;
    tempCategoryName = categoryName;
    isCatogorized = true;
    estoreProductsList.clear();
    try {
      List response = await EstoreServerClient.get(
          "${StringConst.getEStoreItemUrl}?category=$categoryName");
      if (response.first >= 200 && response.first < 300) {
        EStoreItemModel slotModel = EStoreItemModel.fromJson(response.last);

        estoreProductsList = slotModel.products ?? [];
        getProductsStatus = GetProductsStatus.loaded;

        notifyListeners();

        return slotModel;
      } else {
        getProductsStatus = GetProductsStatus.error;
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getProductsStatus = GetProductsStatus.error;
      log("ERROR 2");
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  GetProductsDetailStatus getProductsDetailStatus =
      GetProductsDetailStatus.initial;

  EStoreProductDetail estoreProductDetail = EStoreProductDetail();

  Future<EstoreProductDetailModel> getEstoreProductsDetailFn(
      {required String id}) async {
    getProductsDetailStatus = GetProductsDetailStatus.loading;
    try {
      List response =
          await EstoreServerClient.get("${StringConst.getEStoreItemUrl}/$id");
      if (response.first >= 200 && response.first < 300) {
        EstoreProductDetailModel estoreProductDetailResponse =
            EstoreProductDetailModel.fromJson(response.last);
        estoreProductDetail =
            estoreProductDetailResponse.product ?? EStoreProductDetail();
        log("ORDERRRRRRRRRR $estoreProductDetail");
        getProductsDetailStatus = GetProductsDetailStatus.loaded;
        changeItemSize(
            tempPrize: int.parse(
                estoreProductDetailResponse.product?.details?[0].price ?? "0"),
            tempItemSize: estoreProductDetailResponse.product?.details?[0].size
                    .toString() ??
                "");
        notifyListeners();

        return estoreProductDetailResponse;
      } else {
        log("ERROR 1");
        getProductsDetailStatus = GetProductsDetailStatus.error;
        notifyListeners();
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      log("ERROR 2");
      getProductsDetailStatus = GetProductsDetailStatus.error;
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  GetProductsWishListStatus getProductsWishListStatus =
      GetProductsWishListStatus.initial;

  List<EstoreWishlist> estoreWishList = [];
  int totalPrice = 0;
  String itemSize = '';
  int productPrice = 0;
  changeItemSize({required String tempItemSize, required int tempPrize}) {
    itemSize = tempItemSize;
    productPrice = tempPrize;
    notifyListeners();
  }

  Future<EstoreProductWishListModel> getEstoreWishListFn() async {
    getProductsWishListStatus = GetProductsWishListStatus.loading;
    estoreWishList.clear();
    try {
      List response =
          await EstoreServerClient.get(StringConst.getEStoreWishListUrl);
      if (response.first >= 200 && response.first < 300) {
        EstoreProductWishListModel estoreProductDetailResponse =
            EstoreProductWishListModel.fromJson(response.last);
        log("wishlist response ----- : $response");
        estoreWishList = estoreProductDetailResponse.wishlists ?? [];
        getProductsWishListStatus = GetProductsWishListStatus.loaded;
        notifyListeners();
        return estoreProductDetailResponse;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getProductsWishListStatus = GetProductsWishListStatus.error;
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  Future addToEstoreWishListFn(
      {required BuildContext context,
      required String productId,
      required String isFrom,
      required bool isFromHome,
      int? index}) async {
    try {
      List response = await EstoreServerClient.post(
          StringConst.getEStoreWishListUrl,
          data: {"id": productId});
      if (response.first >= 200 && response.first < 300) {
        if (isFrom == 'home') {
          estoreProductsList[index!].wishlist = true;
          notifyListeners();
        } else if (isFrom == 'home') {
          estoreProductsList[index!].wishlist = true;
          notifyListeners();
        } else if (isFrom == 'details') {
          estoreProductDetail.wishlist = true;
          if (isFromHome) {
            if (isCatogorized) {
              getEstoreProductsByCategoryFn(categoryName: tempCategoryName);
            } else {
              getEstoreProductsFn();
            }
          } else {
            getEstoreWishListFn();
          }
          notifyListeners();
        }
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      toast(context,
          title: "Try again", duration: 3, backgroundColor: AppConstants.red);
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  Future removeFromEstoreWishListFn(
      {required BuildContext context,
      required String productId,
      required String isFrom,
      required bool isFromHome,
      int? index}) async {
    try {
      List response = await EstoreServerClient.putWithoutBody(
        "${StringConst.getEStoreWishListUrl}/$productId",
      );
      log("url added : ${StringConst.getEStoreWishListUrl}/$productId");
      log("favorite_border removed : $response");
      if (response.first >= 200 && response.first < 300) {
        if (isFrom == 'home') {
          estoreProductsList[index!].wishlist = false;
          notifyListeners();
        } else if (isFrom == 'wishlist') {
          estoreWishList.removeAt(index!);
          notifyListeners();
        } else if (isFrom == 'details') {
          estoreProductDetail.wishlist = false;
          if (isFromHome) {
            if (isCatogorized) {
              getEstoreProductsByCategoryFn(categoryName: tempCategoryName);
            } else {
              getEstoreProductsFn();
            }
          } else {
            getEstoreWishListFn();
          }
          notifyListeners();
        }
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      toast(context,
          title: "Try again", duration: 3, backgroundColor: AppConstants.red);
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  GetProductsCartStatus getProductsCartStatus = GetProductsCartStatus.initial;

  List<EStoreCart> eStoreCart = [];

  Future<EStoreCartModel> getEstoreCartFn() async {
    getProductsCartStatus = GetProductsCartStatus.loading;
    try {
      List response =
          await EstoreServerClient.get(StringConst.getEStoreCartUrl);
      log(response.toString());
      if (response.first >= 200 && response.first < 300) {
        EStoreCartModel estoreProductCartResponse =
            EStoreCartModel.fromJson(response.last);

        eStoreCart = estoreProductCartResponse.carts ?? [];
        await calculateTotalPriceFn();
        getProductsCartStatus = GetProductsCartStatus.loaded;

        notifyListeners();

        return estoreProductCartResponse;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getProductsCartStatus = GetProductsCartStatus.error;
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  Future addToEstoreCartFn(
      {required BuildContext context,
      required String productId,
      required String isFrom,
      int? index}) async {
    try {
      List response = await EstoreServerClient.post(
          StringConst.getEStoreCartUrl,
          data: {"id": productId, "count": 1, "size": itemSize});
      if (response.first >= 200 && response.first < 300) {
        if (isFrom == 'cart') {
          print(eStoreCart[index!].count);
          eStoreCart[index].count =
              int.parse(eStoreCart[index].count.toString()) + 1;
          await calculateTotalPriceFn();
          notifyListeners();
        } else if (isFrom == 'details') {
          isCarted = true;
          // estoreProductDetail.cartCount =
          //     estoreProductDetail.cartCount!.toInt() + 1;
          toast(context,
              title: "Product added to cart",
              duration: 3,
              backgroundColor: AppConstants.appPrimaryColor);
          getEstoreCartFn();
          notifyListeners();
        }
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      toast(context,
          title: "Try again", duration: 3, backgroundColor: AppConstants.red);
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  changeIsCartedStatus() {
    isCarted = false;
    notifyListeners();
  }

  Future removeFromEstoreCartFn(
      {required BuildContext context,
      required String cartId,
      required String isFrom,
      int? index}) async {
    try {
      List response = await EstoreServerClient.put(
          "${StringConst.getEStoreCartUrl}?count=-1",
          data: {"id": cartId, "size": itemSize});
      if (response.first >= 200 && response.first < 300) {
        if (isFrom == 'cart') {
          if (eStoreCart[index!].count == 1) {
            eStoreCart.removeAt(index);
            await calculateTotalPriceFn();
          } else {
            eStoreCart[index].count =
                int.parse(eStoreCart[index].count.toString()) - 1;
            await calculateTotalPriceFn();
          }

          notifyListeners();
        } else if (isFrom == 'details') {
          estoreProductDetail.cartCount =
              int.parse(estoreProductDetail.cartCount.toString()) - 1;
          toast(context,
              title: "Product removed to cart",
              duration: 3,
              backgroundColor: AppConstants.appPrimaryColor);
          notifyListeners();
        }
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      toast(context,
          title: "Try again", duration: 3, backgroundColor: AppConstants.red);
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    }
  }

  calculateTotalPriceFn() {
    totalPrice = 0;
    int tempPrice = 0;
    for (var i = 0; i < eStoreCart.length; i++) {
      for (var k = 0; k < eStoreCart[i].product!.details!.length; k++) {
        if (eStoreCart[i].size == eStoreCart[i].product!.details![k].size) {
          eStoreCart[i].product!.prize = int.parse(
              eStoreCart[i].product?.details?[k].price.toString() ?? "0");
          tempPrice =
              (int.parse(eStoreCart[i].product!.details![k].price ?? "0") *
                  (int.parse(eStoreCart[i].count.toString())));
          totalPrice += tempPrice;
        }
      }
    }
  }

  String paymentIntentId = '';

  Future stripeFn({required BuildContext context}) async {
    // log('aaaaaaaaaaaaaaaaaaaaaaaa');
    try {
      LoadingOverlay.of(context).show();
      List response = await EstoreServerClient.post(
        StringConst.eStoreStripeUrl,
        data: {
          "amount": totalPrice,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        log(response.last['clientSecret']);
        paymentIntentId = response.last['clientSecret'];
        // log(paymentIntentId.toString());

        makeStripePayment(context: context);
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      throw Exception('Failed to fetch posts');
    }
  }

  Future<void> makeStripePayment({required BuildContext context}) async {
    try {
      try {
        log('aaaaaaaaaaaaaaaaaaaaaaaa');
        log(paymentIntentId.toString());
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                // googlePay:
                //     const PaymentSheetGooglePay(merchantCountryCode: "USD"),
                merchantDisplayName: "prospect",
                // customerId: paymentIntentData!["customer"],
                paymentIntentClientSecret: paymentIntentId));
        log('bbbbbbbbbbbbbbbbbbbbbbbbbb');
      } catch (e) {
        LoadingOverlay.of(context).hide();
        log("message$e");
      }
      //STEP 3: Display Payment sheet
      try {
        LoadingOverlay.of(context).hide();
        log('cccccccccccccccccccccccc');
        await Stripe.instance.presentPaymentSheet().then((value) async {
          await estorePlaceOrderFn(context: context);
        });

        log("success");
      } on Exception catch (e) {
        log('message');
        log(e.toString());
        if (e is StripeException) {
          log("error from stripe $e");
        } else {
          log("Unforeseen error $e");
        }
      } catch (e) {
        log("Exception   ---$e");
      }
      // displayPaymentSheet();
    } catch (err) {
      log('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      // hideLoading();
      log(err.toString());
    }
  }

  Future estorePlaceOrderFn({
    required BuildContext context,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      Map<String, dynamic> data = {
        "items": [
          for (var i = 0; i < eStoreCart.length; i++)
            {
              "item": eStoreCart[i].product?.id.toString(),
              "quantity": eStoreCart[i].count,
              "size": eStoreCart[i].size.toString(),
              "price": ((eStoreCart[i].product?.prize ?? 0) *
                  (eStoreCart[i].count ?? 0)),
            },
        ],
        "clientSecret": paymentIntentId,
        "amount": totalPrice,
      };
      List response = await EstoreServerClient.post(
        StringConst.eStorePlaceOrderUrl,
        data: data,
      );
      log("booking response : $response");
      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        getEstoreCartFn();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                height: Responsive.height * 50,
                width: Responsive.width * 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppConstants.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      AppImages.orderCompleted,
                      height: Responsive.height * 30,
                    ),
                    CommonButton(
                      onTap: () {
                        Routes.back();
                      },
                      text: "Back",
                      width: Responsive.width * 100,
                      height: Responsive.height * 6.5,
                      bgColor: AppConstants.black,
                      textColor: AppConstants.white,
                      borderColor: AppConstants.white,
                    )
                  ],
                ),
              ),
            );
          },
        );
      } else {
        LoadingOverlay.of(context).hide();
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      throw Exception('Failed to fetch posts');
    }
  }

  EStoreSerchingStatus eStoreSerchingStatus = EStoreSerchingStatus.initial;
  List<Products> serchingProductList = <Products>[];

  Future<SerchingModel> eStoreSerchingFnc({required String query}) async {
    eStoreSerchingStatus = EStoreSerchingStatus.loading;
    try {
      if (query.isEmpty) {
        serchingProductList.clear();
      }
      List response = await EstoreServerClient.get(
        StringConst.grtEstorSerchingUrl + query.toString(),
      );
      if (response.first >= 200 && response.first < 300) {
        SerchingModel slotModel = SerchingModel.fromJson(response.last);
        serchingProductList.clear();
        serchingProductList = slotModel.products!.toList();
        log(serchingProductList.length.toString());
        eStoreSerchingStatus = EStoreSerchingStatus.loaded;
        return slotModel;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      eStoreSerchingStatus = EStoreSerchingStatus.error;
      log(e.toString());
      notifyListeners();
      throw Exception('Failed to fetch posts');
    } finally {
      notifyListeners();
    }
  }

  clearProvider() {
    estoreWishList.clear();
    eStoreCart.clear();
    totalPrice = 0;
    itemSize = '';
    productPrice = 0;
    tempCategoryName = '';
    isCatogorized = false;
    setSelectedIndex(0);
    updateIndex(0);
  }
}
