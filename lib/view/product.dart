import '/exports.dart';
import 'dart:io';

class NewProduct extends StatefulWidget {
  const NewProduct({super.key});

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final formKey = GlobalKey<FormState>();
  XFile? pickedImage;
  ImageProvider? image;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  GroupController categoryController = GroupController();
  int? categoryId;

  @override
  Widget build(BuildContext context) {
    pickedImage == null
        ? image = const AssetImage('assets/images/default.jpg')
        : image = FileImage(File(pickedImage!.path));

    return MyScaffold(
      pageName: '',
      body: [
        BootstrapRow(
          children: [
            // Image
            BootstrapCol(
              sizes: 'col-lg-4 col-md-6 col-sm-12',
              child: Container(
                width: double.maxFinite,
                height: webScreen(context) ? double.maxFinite : 200,
                margin: EdgeInsets.all(dPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.5),
                  image: DecorationImage(
                    image: image!,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(black.withOpacity(0.25), BlendMode.darken),
                  ),
                ),
                child: IconButton(
                  onPressed: () async {
                    if (pickedImage == null) {
                      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {});
                    } else {
                      pickedImage = null;
                      setState(() {});
                    }
                  },
                  icon: Icon(
                    pickedImage == null ? Icons.camera_alt : Icons.remove_circle,
                    color: white,
                  ),
                ),
              ),
            ),

            // Information
            BootstrapCol(
              sizes: 'col-lg-8 col-md-6 col-sm-12',
              child: Form(
                key: formKey,
                child: BootstrapRow(
                  children: [
                    // Title
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Padding(
                        padding: EdgeInsets.all(dPadding),
                        child: TextInputFeild(
                          text: 'Title',
                          controller: title,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),

                    // Price
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Padding(
                        padding: EdgeInsets.all(dPadding),
                        child: TextInputFeild(
                          text: 'Price',
                          controller: price,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),

                    // Category
                    BootstrapCol(
                      sizes: 'col-12',
                      child: FutureBuilder(
                        future: CategoryController.instance.categories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<int> categoriesId = List.generate(
                                snapshot.data!.length, (index) => snapshot.data![index]['id']);
                            List<String> categoriesTitle = List.generate(
                                snapshot.data!.length, (index) => snapshot.data![index]['title']);

                            return Container(
                              margin: EdgeInsets.all(dPadding),
                              padding: EdgeInsets.all(dPadding),
                              decoration: BoxDecoration(
                                border: Border.all(color: white, strokeAlign: 12.5),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                              child: SimpleGroupedCheckbox<int>(
                                groupTitleAlignment: Alignment.topLeft,
                                controller: categoryController,
                                groupTitle: 'Category',
                                onItemSelected: (data) => setState(() => categoryId = data),
                                itemsTitle: categoriesTitle,
                                values: categoriesId,
                                groupStyle: GroupStyle(
                                  activeColor: primary,
                                  groupTitleStyle: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  itemTitleStyle: TextStyle(color: white),
                                ),
                                checkFirstElement: false,
                              ),
                            );
                          } else {
                            return waitContainer();
                          }
                        },
                      ),
                    ),

                    // Button
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Padding(
                        padding: EdgeInsets.all(dPadding),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (pickedImage != null && categoryId != null) {
                                ProductController.instance.createProduct(
                                  product: ProductModel(
                                    id: 0,
                                    image: base64Encode(await pickedImage!.readAsBytes()),
                                    title: title.text,
                                    price: double.parse(price.text),
                                    category: categoryId!,
                                  ),
                                );
                              } else {
                                errorSnackBar('Please Check your Data');
                              }
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UpdateProduct extends StatefulWidget {
  final ProductModel product;
  const UpdateProduct({super.key, required this.product});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final formKey = GlobalKey<FormState>();
  XFile? pickedImage;
  ImageProvider? image;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  GroupController categoryController = GroupController();
  int? categoryId;

  @override
  Widget build(BuildContext context) {
    pickedImage == null
        ? image = AssetImage(widget.product.image)
        : image = FileImage(File(pickedImage!.path));

    title = TextEditingController(text: widget.product.title);
    price = TextEditingController(text: widget.product.price.toString());

    return MyScaffold(
      pageName: '',
      body: [
        BootstrapRow(
          children: [
            // Image
            BootstrapCol(
              sizes: 'col-lg-4 col-md-6 col-sm-12',
              child: Container(
                width: double.maxFinite,
                height: webScreen(context) ? double.maxFinite : 200,
                alignment: Alignment.center,
                margin: EdgeInsets.all(dPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.5),
                  image: DecorationImage(
                    image: image!,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(black.withOpacity(0.25), BlendMode.darken),
                  ),
                ),
                child: IconButton(
                  onPressed: () async {
                    if (pickedImage == null) {
                      pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                      setState(() {});
                    } else {
                      pickedImage = null;
                      setState(() {});
                    }
                  },
                  icon: Icon(
                    pickedImage == null ? Icons.camera_alt : Icons.remove_circle,
                    color: white,
                  ),
                ),
              ),
            ),

            // Information
            BootstrapCol(
              sizes: 'col-lg-8 col-md-6 col-sm-12',
              child: Form(
                key: formKey,
                child: BootstrapRow(
                  children: [
                    // Title
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Padding(
                        padding: EdgeInsets.all(dPadding),
                        child: TextInputFeild(
                          text: 'Title',
                          controller: title,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            setState(() => widget.product.title = title.text);
                          },
                        ),
                      ),
                    ),

                    // Price
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Padding(
                        padding: EdgeInsets.all(dPadding),
                        child: TextInputFeild(
                          text: 'Price',
                          controller: price,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            setState(() => widget.product.price = double.parse(price.text));
                          },
                        ),
                      ),
                    ),

                    // Category
                    BootstrapCol(
                      sizes: 'col-12',
                      child: FutureBuilder(
                        future: CategoryController.instance.categories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<int> categoriesId = List.generate(
                                snapshot.data!.length, (index) => snapshot.data![index]['id']);
                            List<String> categoriesTitle = List.generate(
                                snapshot.data!.length, (index) => snapshot.data![index]['title']);

                            return Container(
                              margin: EdgeInsets.all(dPadding),
                              padding: EdgeInsets.all(dPadding),
                              decoration: BoxDecoration(
                                border: Border.all(color: white, strokeAlign: 12.5),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                              child: SimpleGroupedCheckbox<int>(
                                groupTitleAlignment: Alignment.topLeft,
                                controller: categoryController,
                                groupTitle: 'Category',
                                onItemSelected: (data) =>
                                    setState(() => widget.product.category = data),
                                itemsTitle: categoriesTitle,
                                values: categoriesId,
                                groupStyle: GroupStyle(
                                  activeColor: primary,
                                  groupTitleStyle: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  itemTitleStyle: TextStyle(color: white),
                                ),
                                checkFirstElement: false,
                              ),
                            );
                          } else {
                            return waitContainer();
                          }
                        },
                      ),
                    ),

                    // Button
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Padding(
                        padding: EdgeInsets.all(dPadding),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (pickedImage != null) {
                                ProductController.instance.createProduct(
                                  product: ProductModel(
                                    id: 0,
                                    image: base64Encode(await pickedImage!.readAsBytes()),
                                    title: title.text,
                                    price: double.parse(price.text),
                                    category: categoryId!,
                                  ),
                                );
                              } else {
                                ProductController.instance.updateProduct(
                                  product: ProductModel(
                                      id: widget.product.id,
                                      title: title.text,
                                      image: widget.product.image,
                                      price: double.parse(price.text),
                                      category: widget.product.category),
                                );
                              }
                            }
                          },
                          child: const Text('Update'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
