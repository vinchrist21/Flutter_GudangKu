part of 'pages.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlDesc = TextEditingController();
  final ctrlPrice = TextEditingController();
  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseFile(String type) async{
    ImageSource imgSrc;
    if(type == "camera"){
      imgSrc = ImageSource.camera;
    } else {
      imgSrc = ImageSource.gallery;
    }

    final selectedImage = await imagePicker.getImage(
      source: imgSrc,
      imageQuality: 50
    );
    setState(() {
      imageFile = selectedImage;
    });
  }

  void showFileDialog(BuildContext ctx){
    showDialog(
      context: ctx, 
      builder: (ctx){
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Pick image from:"),
          actions: [
            ElevatedButton.icon(
              onPressed: (){
                chooseFile("camera");
              }, 
              icon: Icon(Icons.camera_alt), 
              label: Text("Camera"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
            ),
            ElevatedButton.icon(
              onPressed: (){
                chooseFile("gallery");
              }, 
              icon: Icon(Icons.folder_open), 
              label: Text("Gallery"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  void dispose(){
    ctrlName.dispose();
    ctrlDesc.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }

  void clearForm(){
    ctrlName.clear();
    ctrlDesc.clear();
    ctrlPrice.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Barang"),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(16),
              children:[
                Form(
                    key: _formKey,
                    child: Column(
                      children:[
                      SizedBox(height:24),
                        TextFormField(
                          controller: ctrlName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Nama Produk",
                            prefixIcon: Icon(Icons.all_inbox_sharp),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please fill the field!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height:24),
                        TextFormField(
                          controller: ctrlDesc,
                          keyboardType: TextInputType.name,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: "Deskripsi Produk",
                            prefixIcon: Icon(Icons.description_outlined),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please fill the field!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height:24),
                        TextFormField(
                          controller: ctrlPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Harga Produk",
                            prefixIcon: Icon(Icons.monetization_on),
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please fill the field!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height:24),
                        imageFile == null ?
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: (){
                                showFileDialog(context);
                              },
                              icon: Icon(Icons.photo_camera),
                              label: Text("Ambil Gambar"),
                              style: ElevatedButton.styleFrom(
                              primary: Color(0xFFC72C41),

                            ),
                            ),
                            SizedBox(width:16),
                            Text("File tidak ditemukan.")
                          ],
                        )
                        :
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: (){
                                showFileDialog(context);
                              },
                              icon: Icon(Icons.photo_camera),
                              label: Text("Ulangi Gambar"),
                              style: ElevatedButton.styleFrom(
                              primary: Color(0xFFC72C41),

                            ),
                            ),
                            SizedBox(width:16),
                            Semantics(
                              child: Image.file(
                                File(imageFile.path),
                                width: 100,
                              )
                            )
                          ],
                        ),
                         SizedBox(height:24),
                         ElevatedButton.icon(
                         onPressed: () async{
                           if(_formKey.currentState.validate() && imageFile != null){
                             setState(() {
                               isLoading = true;
                             });
                            Products products = Products("", ctrlName.text, ctrlDesc.text, ctrlPrice.text, "", FirebaseAuth.instance.currentUser.uid, "", "");
                            await ProductServices.addProduct(products, imageFile).then((value){
                              if(value == true){
                                ActivityServices.showToast("Simpan Barang Berhasil!", Colors.green);
                                clearForm();
                                setState(() {
                                  isLoading = false;
                                });
                              }else{
                                ActivityServices.showToast("Simpan Barang Gagal!", Colors.red);
                              }
                            });
                           } else {
                             ActivityServices.showToast("Please check form fields!", Colors.red);
                           }
                         },
                         icon: Icon(Icons.save), 
                         label: Text("Simpan Barang"),
                         style: ElevatedButton.styleFrom(
                           primary: Color(0xFFC72C41),

                         ),
                        ),
                      ],
                    )
                )
              ]
            ),
            isLoading == true 
              ? ActivityServices.loadings()
              : Container()
          ],
        ),
      )
    );
  }
}