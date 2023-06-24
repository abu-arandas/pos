import '/exports.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      pageName: 'History',
      body: [
        Column(
          children: [
            // Calender
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: date,
              currentDay: date,
              onFormatChanged: (format) {},
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(color: white),
                leftChevronIcon: Icon(Icons.arrow_left, color: white),
                rightChevronIcon: Icon(Icons.arrow_right, color: white),
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: white),
                weekendTextStyle: TextStyle(color: primary),
                selectedDecoration: BoxDecoration(color: primary),
              ),
              onDaySelected: (selectedDay, focusedDay) => setState(
                  () => date = DateTime(selectedDay.year, selectedDay.month, selectedDay.day)),
            ),

            // Table
            FutureBuilder(
              future: OrderController.instance.orders(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<OrderModel> orders = List.generate(
                    snapshot.data!.length,
                    (index) => OrderModel.fromMap(snapshot.data![index]),
                  )
                      .where(
                        (element) =>
                            DateTime(element.date.year, element.date.month, element.date.day) ==
                            date,
                      )
                      .toList();

                  return Padding(
                    padding: EdgeInsets.only(top: webScreen(context) ? 0 : dPadding * 2),
                    child: Table(
                      border: TableBorder.all(borderRadius: BorderRadius.circular(25)),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        // Title
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: primary)),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(dPadding / 2),
                              child: Text(
                                'Order',
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              'Products',
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container()
                          ],
                        ),

                        // Products
                        for (var order in orders) orderWidget(order),

                        // Total
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: primary)),
                          ),
                          children: [
                            Text(
                              OrderController.instance
                                  .ordersTotal(orders: orders)
                                  .toStringAsFixed(2),
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            // TODO link printer
                            Padding(
                              padding: EdgeInsets.all(dPadding / 2),
                              child: ElevatedButton(onPressed: () {}, child: const Text('Print')),
                            ),
                            Container()
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return waitContainer();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  TableRow orderWidget(OrderModel order) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: grey)),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(dPadding / 2),
          child: Text(
            order.id.toString(),
            style: TextStyle(color: white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),

        // Products
        FutureBuilder(
          future: order.products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BootstrapRow(
                children: List.generate(
                  snapshot.data!.length,
                  (index) => BootstrapCol(
                    sizes: 'col-lg-6 col-md-12 cl-sm-12',
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: MemoryImage(base64Decode(snapshot.data![index].image)),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].title,
                        style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${snapshot.data![index].price} \$ * ${snapshot.data![index].cartQuantity}',
                        style: TextStyle(color: white),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),

        // Delete
        IconButton(
          onPressed: () => OrderController.instance.deleteOrder(order: order),
          icon: const Icon(Icons.delete, color: Color(0xFFFF3333)),
        ),
      ],
    );
  }
}
