import '/exports.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      pageName: 'Settings',
      body: [
        BootstrapRow(
          height: screenHeight(context) * 0.75,
          children: [
            // Categories
            BootstrapCol(
              sizes: 'col-lg-6 col-md-12 col-sm-12',
              child: Container(
                margin: EdgeInsets.all(dPadding),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: BootstrapRow(
                  children: [
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => CategoryController.instance.createCategory(),
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: grey,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: FutureBuilder(
                        future: CategoryController.instance.categories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              columnWidths: const {
                                0: FlexColumnWidth(4),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                              },
                              children: List.generate(
                                snapshot.data!.length,
                                (index) {
                                  CategoryModel category =
                                      CategoryModel.fromMap(snapshot.data![index]);

                                  return TableRow(
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: primary)),
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(dPadding / 2),
                                        child: Text(
                                          category.title,
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => CategoryController.instance
                                            .updateCategory(category: category),
                                        icon: Icon(Icons.edit, color: white),
                                      ),
                                      IconButton(
                                        onPressed: () => CategoryController.instance
                                            .deleteCategory(category: category),
                                        icon: const Icon(Icons.delete, color: Color(0xFFFF3333)),
                                      )
                                    ],
                                  );
                                },
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
              ),
            ),

            // Products
            BootstrapCol(
              sizes: 'col-lg-6 col-md-12 col-sm-12',
              child: Container(
                margin: EdgeInsets.all(dPadding),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: BootstrapRow(
                  children: [
                    BootstrapCol(
                      sizes: 'col-12',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Products',
                            style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => page(page: const NewProduct()),
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: grey,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BootstrapCol(
                      sizes: 'col-12',
                      child: FutureBuilder(
                        future: ProductController.instance.products(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              columnWidths: const {
                                0: FlexColumnWidth(4),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                              },
                              children: List.generate(snapshot.data!.length, (index) {
                                ProductModel product = ProductModel.fromMap(snapshot.data![index]);

                                return TableRow(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: primary)),
                                  ),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(dPadding / 2),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              image: DecorationImage(
                                                image: MemoryImage(base64Decode(product.image)),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              product.title,
                                              style: TextStyle(
                                                  color: white, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => page(page: UpdateProduct(product: product)),
                                      icon: Icon(Icons.edit, color: white),
                                    ),
                                    IconButton(
                                      onPressed: () => ProductController.instance
                                          .deleteProduct(product: product),
                                      icon: const Icon(Icons.delete, color: Color(0xFFFF3333)),
                                    )
                                  ],
                                );
                              }),
                            );
                          } else {
                            return waitContainer();
                          }
                        },
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
