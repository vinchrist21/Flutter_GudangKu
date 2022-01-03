part of 'pages.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

bool isLoading = false;
//
String uid = FirebaseAuth.instance.currentUser.uid;
CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");
//
class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: userCollection.where('uid', isEqualTo: uid).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ActivityServices.loadings();
                }

                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot doc) {
                    Users users;
                    users = new Users(
                      doc.data()['uid'],
                      doc.data()['name'],
                      doc.data()['phone'],
                      doc.data()['email'],
                      doc.data()['password'],
                      doc.data()['createdAt'],
                      doc.data()['updatedAt'],
                    );

                    return Column(children: [
                      Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color(0xFFC72C41),
                                Color(0xFF2D142C),
                              ])),
                          child: Container(
                              width: double.infinity,
                              child: Center(
                                  child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      "https://thesmokingcuban.com/wp-content/uploads/getty-images/2017/07/1193632471.jpeg",
                                    ),
                                    radius: 80.0,
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Text(
                                    users.name,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Email :",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 22.0),
                                  ),
                                  Text(
                                    users.email,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Phone :",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 22.0),
                                  ),
                                  Text(
                                    users.phone,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Created At :",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    users.createdAt,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 0),
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await AuthServices.signOut()
                                              .then((value) {
                                            if (value == true) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              ActivityServices.showToast(
                                                  "Logout success",
                                                  Colors.green);
                                              Navigator.pushReplacementNamed(
                                                  context, Login.routeName);
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              ActivityServices.showToast(
                                                  "Logout failed", Colors.red);
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.logout),
                                        label: Text("Logout"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFFC72C41),
                                          elevation: 8,
                                        ),
                                      ))
                                ],
                              ))))
                    ]);
                  }).toList(),
                );
              },
            ),
          ),
          isLoading == true ? ActivityServices.loadings() : Container()
        ],
      ),
    );
  }
}