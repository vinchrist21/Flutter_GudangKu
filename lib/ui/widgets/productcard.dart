part of 'widgets.dart';

class ProductCard extends StatefulWidget {
  final Products products;
  ProductCard({this.products});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    Products product = widget.products;
    if (product == null) {
      return Container();
    } else {
      return Card(
        elevation: 1,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 24.0,
              backgroundImage: NetworkImage(product.productImage),
            ),
            title: Text(
              product.productName,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              maxLines: 1,
              softWrap: true,
            ),
            subtitle: Text(
              ActivityServices.toIDR(product.productPrice),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
              maxLines: 1,
              softWrap: true,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(CupertinoIcons.ellipsis_circle_fill),
                    color: Colors.blue,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext ctx) {
                            return Container(
                              width: double.infinity,
                              height: 80,
                              padding: EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    icon: Icon(CupertinoIcons.eye_fill),
                                    label: Text("Show Data"),
                                    onPressed: () {
                                      Navigator.pushNamed(context, Details.routeName);
                                    },
                                  ),
                                  ElevatedButton.icon(
                                    icon: Icon(CupertinoIcons.pencil),
                                    label: Text("Edit Data"),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue[600]),
                                  ),
                                  ElevatedButton.icon(
                                    icon: Icon(CupertinoIcons.trash_fill),
                                    label: Text("Delete Data"),
                                    onPressed: () async {
                                      bool result = await ProductServices.deleteProduct(product.productId);
                                      if(result){
                                        ActivityServices.showToast("Delete data success", Colors.green);
                                      } else {
                                        ActivityServices.showToast("Delete data failed", Colors.red);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red[600]),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
              ],
            ),
          ),
        ),
      );
    }
  }
}
