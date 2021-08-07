class ProductsCategoryModel{
String _cPName;
String _pName;
String _pTitle;
String _pDescription;
String _pCurrency;
String _pAvatar;
String _pPriceFText;
String _pDiscountType;
int _pPrice;
int _pId;
int _cId;
int _pDiscount;
int _pInStock;
num _pPriceAfterDiscount;


num get pPriceAfterDiscount => _pPriceAfterDiscount;

  String get pDiscountType => _pDiscountType;

  String get cPName=>_cPName;

int get pPrice => _pPrice;

  String get pTitle => _pTitle;

  String get pName => _pName;


int get pId => _pId;

  ProductsCategoryModel.fromJson(dynamic json){

    _pName=json['name'];
    _pTitle=json['title'];
    _pPrice=json['price'];
     _pId =json['id'];
     _cId= json['category_id'];
     _pDiscount=json['discount'];
     _pDescription=json['description'];
     _pCurrency=json['currency'];
     _pAvatar=json['avatar'];
     _pPriceFText=json['price_final_text'];
     _pInStock=json['in_stock'];
     _pDiscountType=json['discount_type'];
    _pPriceAfterDiscount=json['price_final'];

  }

int get cId => _cId;

int get pDiscount => _pDiscount;

String get pDescription => _pDescription;

String get pCurrency => _pCurrency;

String get pAvatar => _pAvatar;

String get pPriceFText => _pPriceFText;

int get pInStock => _pInStock;
}