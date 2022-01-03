part of 'models.dart';

class Products extends Equatable{
  final String productId;
  final String productName;
  final String productDesc;
  final String productPrice;
  final String productImage;
  final String addBy;
  final String createdAt;
  final String updatedAt;

  Products(
    this.productId,
    this.productName,
    this.productDesc,
    this.productPrice,
    this.productImage,
    this.addBy,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props => [
    productId,
    productName,
    productDesc,
    productPrice,
    productImage,
    addBy,
    createdAt,
    updatedAt,
  ];
}