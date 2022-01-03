part of 'pages.dart';

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  //1
  Icon searchIcon = Icon(Icons.search);
  Widget appBarText = Text("Stok Barang");

  String uid = FirebaseAuth.instance.currentUser.uid;

  CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");

  Widget buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: productCollection.where('addBy', isEqualTo: uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Failed to load data");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return ActivityServices.loadings();
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot doc) {
                Products products = new Products(
                    doc.data()['productId'],
                    doc.data()['productName'],
                    doc.data()['productDesc'],
                    doc.data()['productPrice'],
                    doc.data()['productImage'],
                    doc.data()['addBy'],
                    doc.data()['createdAt'],
                    doc.data()['updatedAt'],
                  );
                return ProductCard(products: products);
              }).toList(),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarText,
        centerTitle: true,
        elevation: 0,

        //1
        actions: <Widget>[
          IconButton(
              icon: searchIcon,
              onPressed: () {
                setState(() {
                  if (this.searchIcon.icon == Icons.search) {
                    this.searchIcon = Icon(Icons.cancel);
                    this.appBarText = TextField(
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari barang apa ?"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    );
                  } else {
                    this.searchIcon = Icon(Icons.search);
                    this.appBarText = Text("Stok Barang");
                  }
                });
              })
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: buildBody(),
    );
  }
}
