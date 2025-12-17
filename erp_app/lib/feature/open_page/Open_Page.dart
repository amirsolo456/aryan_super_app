import 'package:flutter/material.dart';

class OpenedPage extends StatefulWidget {
  final List<Map<String, String>> items;

  const OpenedPage({super.key, required this.items});

  @override
  State<OpenedPage> createState() => _OpenedPageState();
}

class _OpenedPageState extends State<OpenedPage> {
  late List<Map<String, String>> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _clearAll() {
    setState(() {
      _items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            if (_items.isNotEmpty)
              Container(
                width: double.infinity,
                color: Color(0xffECECEC),
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'بستن همه',
                      style: TextStyle(fontSize: 12, color: Color(0xff292929)),
                    ),

                    InkWell(
                      onTap: _clearAll,
                      child: Image.asset(
                        'assets/images/Close.png',
                        package: 'resources_package',
                      ),
                    ),

                  ],
                ),
              ),

            if (_items.isEmpty)
              const Expanded(
                child: Center(
                  child: Text('موردی وجود ندارد', style: TextStyle(fontSize: 16)),
                ),
              )
            else
              Expanded(
                child: ListView.builder(

                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    final title = item.keys.first;
                    final route = item.values.first;

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, route);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        child: Row(
                          children: [
                            // ➕ سمت چپ
                             Image.asset(
                          'assets/images/pluse.png',
                          package: 'resources_package',
                        ),

                            const Spacer(),

                            // عنوان
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),

                            // ❌ سمت راست


                            InkWell(
                              onTap: () => _removeItem(index),
                              child: Image.asset(
                                'assets/images/Close.png',
                                package: 'resources_package',
                              ),
                            ),



                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
