part of 'pages.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(24),
        child: Stack(
          children: [
            ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset("assets/images/Gudangku.png",
                       height: 300, 
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                          if(value.isEmpty){
                            return "Please fill the field!";
                          } else {
                            if(!EmailValidator.validate(value)){
                              return "Email isn't valid!";
                            } else {
                               return null;
                            }
                          }
                        },
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlPass,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.vpn_key),
                          border: OutlineInputBorder(),
                          suffixIcon: new GestureDetector(
                            onTap: (){
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: Icon(
                              isVisible==true 
                              ? 
                                Icons.visibility 
                              :
                                Icons.visibility_off
                            ),
                          )
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value){
                          return value.length < 6 ?
                            "Password must have at least 6 or more characters" :
                            null;
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton.icon(
                       onPressed: () async {
                         if(_formKey.currentState.validate()){
                           setState(() {
                               isLoading = true;
                             });
                             await AuthServices.signIn(ctrlEmail.text, ctrlPass.text).then((value){
                               if(value == "success"){
                               setState(() {
                                 isLoading = false;
                               });
                               ActivityServices.showToast("Login success", Colors.green);
                               Navigator.pushReplacementNamed(context, MainMenu.routeName);
                             } else {
                               setState(() {
                                 isLoading = false;
                               });
                               ActivityServices.showToast(value, Colors.red);
                             }
                             });

                           //melanjutkan ke tahap berikutnya
                          //  Navigator.pushReplacementNamed(context, MainMenu.routeName);
                         } else {
                           //kosongkan aja
                           Fluttertoast.showToast(msg: "Please check the fields!",backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT);
                         }
                       },
                       icon: Icon(Icons.login_rounded), 
                       label: Text("Login"),
                       style: ElevatedButton.styleFrom(
                         primary: Color(0xFFEE4540),
                         elevation: 8,
                       ),
                       ),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, Register.routeName);
                        },
                        child: Text("Not registered yet ? Join now.",
                          style: TextStyle(color: Colors.white,
                          fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            isLoading == true 
              ? ActivityServices.loadings()
              : Container()
          ],
        ),
      ),
    );
  }
}
