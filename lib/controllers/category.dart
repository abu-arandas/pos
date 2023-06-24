import '/exports.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();

  /* ====== Read ======*/
  Future<List<Map<String, dynamic>>> categories() async => await Db().readData(table: 'Category');

  /* ====== Create ======*/
  void createCategory() async {
    final formKey = GlobalKey<FormState>();
    final title = TextEditingController();

    dialog(
      title: 'New Category',
      content: Form(
        key: formKey,
        child: TextInputFeild(
          text: 'Category Title',
          controller: title,
          textInputAction: TextInputAction.done,
        ),
      ),
      actions: [
        // Add
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  Db.insertData(
                    table: 'Category',
                    item: CategoryModel(
                      id: await categories().then((value) => value.length + 1),
                      title: title.text,
                    ).toJson(),
                  );

                  successSnackBar('Done');
                  page(page: const Setting());
                } catch (error) {
                  errorSnackBar(error.toString());
                }
              }
            },
            child: const Text('Add'),
          ),
        ),

        // Cancle
        SizedBox(
          width: 100,
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(grey),
              side: MaterialStatePropertyAll(BorderSide(color: grey)),
            ),
            child: const Text('Cancle'),
          ),
        )
      ],
    );
  }

  /* ====== Update ======*/
  void updateCategory({required CategoryModel category}) async {
    final formKey = GlobalKey<FormState>();
    final title = TextEditingController(text: category.title);

    dialog(
      title: 'Update Category',
      content: Form(
        key: formKey,
        child: TextInputFeild(
          text: 'Category Title',
          controller: title,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            category.title = value;
            update();
          },
        ),
      ),
      actions: [
        // Update
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await Db.updateData(
                    table: 'Category',
                    item: CategoryModel(id: category.id, title: title.text).toJson(),
                  );

                  successSnackBar('Done');
                  page(page: const Setting());
                } catch (error) {
                  errorSnackBar(error.toString());
                }
              }
            },
            child: const Text('Update'),
          ),
        ),

        // Cancle
        SizedBox(
          width: 100,
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(grey),
              side: MaterialStatePropertyAll(BorderSide(color: grey)),
            ),
            child: const Text('Cancle'),
          ),
        )
      ],
    );
  }

  /* ====== Delete ======*/
  void deleteCategory({required CategoryModel category}) {
    dialog(
      title: 'Are you sure?',
      content: const SizedBox(),
      actions: [
        // Delete
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () async {
              try {
                await Db.deleteData(table: 'Category', id: category.id);

                successSnackBar('Done');
                page(page: const Setting());
              } catch (error) {
                errorSnackBar(error.toString());
              }
            },
            child: const Text('Yes'),
          ),
        ),

        // Cancle
        SizedBox(
          width: 100,
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(grey),
              side: MaterialStatePropertyAll(BorderSide(color: grey)),
            ),
            child: const Text('Cancle'),
          ),
        )
      ],
    );
  }
}

class CategoryModel {
  int id;
  String title;

  CategoryModel({required this.id, required this.title});

  factory CategoryModel.fromMap(Map data) {
    return CategoryModel(id: data['id'], title: data['title']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}
