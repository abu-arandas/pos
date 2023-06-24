import '/exports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String categoryIndex = 'all';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      pageName: 'Home',
      body: [
        BootstrapRow(
          children: [
            // Search
            BootstrapCol(
              sizes: 'col-12',
              child: FutureBuilder(
                future: ProductController.instance.products(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: dPadding),
                      child: SearchField<ProductModel>(
                        suggestions: List.generate(
                          snapshot.data!.length,
                          (index) {
                            ProductModel product = ProductModel.fromMap(snapshot.data![index]);

                            return SearchFieldListItem<ProductModel>(
                              product.title,
                              item: product,
                              child: ListTile(
                                leading: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: MemoryImage(base64Decode(product.image)),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                title: Text(product.title),
                                subtitle: Text('${product.price} \$'),
                                onTap: () => ProductController.instance.addToCart(product: product),
                              ),
                            );
                          },
                        ),
                        hint: 'Search...',
                        searchStyle: TextStyle(color: white),
                        suggestionStyle: TextStyle(color: black),
                        itemHeight: 75,
                      ),
                    );
                  } else {
                    return waitContainer();
                  }
                },
              ),
            ),

            // Categories
            BootstrapCol(
              sizes: 'col-12',
              child: FutureBuilder(
                future: CategoryController.instance.categories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 50,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          categoryWidget(CategoryModel(id: -1, title: 'all')),
                          for (var category in snapshot.data!)
                            categoryWidget(CategoryModel.fromMap(category))
                        ],
                      ),
                    );
                  } else {
                    return waitContainer();
                  }
                },
              ),
            ),

            // Products
            BootstrapCol(
              sizes: 'col-12',
              child: FutureBuilder(
                future: ProductController.instance.products(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductModel> products = List.generate(snapshot.data!.length,
                        (index) => ProductModel.fromMap(snapshot.data![index]));

                    List<ProductModel> productsList = categoryIndex == 'all'
                        ? products
                        : products.where((element) => element.category == categoryIndex).toList();

                    return BootstrapRow(
                      children: List.generate(
                        productsList.length,
                        (index) => BootstrapCol(
                          sizes: 'col-xl-4 col-lg-4 col-md-6 col-sm-6',
                          child: InkWell(
                            onTap: () =>
                                ProductController.instance.addToCart(product: productsList[index]),
                            child: Padding(
                              padding: EdgeInsets.all(dPadding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.5),
                                        image: DecorationImage(
                                          image:
                                              MemoryImage(base64Decode(productsList[index].image)),
                                          fit: BoxFit.fill,
                                          colorFilter: ColorFilter.mode(
                                              black.withOpacity(0.5), BlendMode.darken),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Title
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: dPadding / 2),
                                    child: Text(
                                      productsList[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                  ),

                                  // Title
                                  Text('${productsList[index].price} \$'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return waitContainer();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget categoryWidget(CategoryModel category) {
    return Padding(
      padding: EdgeInsets.only(left: dPadding),
      child: ElevatedButton(
        onPressed: () => setState(() => categoryIndex = category.title),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed) ||
                    categoryIndex == category.title
                ? primary
                : white,
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed) ||
                    categoryIndex == category.title
                ? white
                : primary,
          ),
        ),
        child:
            Text(category.title.toLowerCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
