import '/exports.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (controller) => Container(
        color: secondary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            BootstrapCol(
              sizes: 'col-12',
              child: Container(
                height: 100,
                padding: EdgeInsets.all(dPadding),
                child: Text(
                  'Order Info',
                  style: TextStyle(color: white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Cart
            BootstrapCol(
              sizes: 'col-12',
              child: Container(
                height: screenHeight(context) * 0.5,
                margin: EdgeInsets.all(dPadding / 2),
                alignment: controller.cart.isNotEmpty ? Alignment.topCenter : Alignment.center,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: controller.cart.isNotEmpty
                    ? ListView(
                        children: List.generate(
                          controller.cart.length,
                          (index) {
                            ProductModel product = controller.cart[index];

                            return BootstrapCol(
                              sizes: 'col-12',
                              child: Container(
                                height: 125,
                                margin: EdgeInsets.all(dPadding / 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: secondary,
                                ),
                                child: Row(
                                  children: [
                                    // Image
                                    Container(
                                      height: double.maxFinite,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                        image: DecorationImage(
                                          image: MemoryImage(base64Decode(product.image)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: dPadding),

                                    // Name & Price & Buttons
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(dPadding / 2),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Name
                                            Text(
                                              product.title,
                                              style: TextStyle(
                                                  color: white, fontWeight: FontWeight.bold),
                                            ),

                                            // Price
                                            Text(
                                              '${product.price} \$',
                                              style: TextStyle(color: white),
                                            ),

                                            // Buttons
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                // Add To Cart
                                                IconButton(
                                                  onPressed: () =>
                                                      controller.addToCart(product: product),
                                                  icon: Icon(Icons.add, color: white),
                                                ),

                                                // Count
                                                Text(
                                                  product.cartQuantity.toString(),
                                                  style: TextStyle(
                                                      color: white, fontWeight: FontWeight.bold),
                                                ),

                                                // Remove From Cart
                                                IconButton(
                                                  onPressed: () =>
                                                      controller.removeFromCart(product: product),
                                                  icon: Icon(Icons.remove, color: white),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Text(
                        'Cart is empty',
                        style: TextStyle(color: white, fontSize: 32, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),

            // Order Information
            BootstrapCol(
              sizes: 'col-12',
              child: Container(
                margin: EdgeInsets.all(dPadding / 2),
                padding: EdgeInsets.all(dPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12.5),
                ),
                child: Column(
                  children: [
                    // Products Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${controller.cartTotal().toStringAsFixed(2)} \$',
                          style: TextStyle(color: white, fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(height: dPadding),

                    // Tax
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${(controller.cartTotal() * 0.16).toStringAsFixed(2)} \$',
                          style: TextStyle(color: white, fontSize: 16),
                        ),
                      ],
                    ),

                    // Divider
                    Padding(
                      padding: EdgeInsets.all(dPadding),
                      child: Divider(thickness: 2, color: primary),
                    ),

                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${(controller.cartTotal() + (controller.cartTotal() * 0.16)).toStringAsFixed(2)} \$',
                          style: TextStyle(color: white, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: dPadding * 2),

                    // Button
                    if (controller.cart.isNotEmpty)
                      SizedBox(
                        width: double.maxFinite,
                        child: OutlinedButton.icon(
                          onPressed: () => OrderController.instance.createOrder(),
                          icon: const Icon(Icons.print, size: 16),
                          label: const Text('Done'),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
