import 'package:flutter/material.dart';
import 'package:yugidb/models/card.dart';

import 'cardinfo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cards = [];
  int _currentPage = 0;
  bool _isLoading = false;
  String searchstr = '';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen for scroll position changes and load more data when necessary
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    // Load initial data
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    _loadData();
  }

  void clearText() {
    _controller.clear();
    setState(() {
      searchstr = '';
    });
    _loadData();
  }

  Future<void> _loadData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _currentPage = 0;
    });
    List data;
    if (searchstr == '') {
      data = await YGOcard.getAllCards(
          'https://db.ygoprodeck.com/api/v7/cardinfo.php?num=10&offset=$_currentPage');

      setState(() {
        cards = [];
      });
    } else {
      String val = searchstr.replaceAll(' ', '%20');
      data = await YGOcard.getAllCards(
          'https://db.ygoprodeck.com/api/v7/cardinfo.php?fname=$val&num=10&offset=$_currentPage');

      setState(() {
        cards = [];
      });
    }

    setState(() {
      _isLoading = false;
      cards.addAll(data);
      _currentPage += 10;
    });
  }

  Future<void> _loadMoreData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    List data;
    if (searchstr == '') {
      data = await YGOcard.getAllCards(
          'https://db.ygoprodeck.com/api/v7/cardinfo.php?num=10&offset=$_currentPage');
    } else {
      String val = searchstr.replaceAll(' ', '%20');
      data = await YGOcard.getAllCards(
          'https://db.ygoprodeck.com/api/v7/cardinfo.php?fname=$val=10&offset=$_currentPage');
    }

    setState(() {
      _isLoading = false;
      cards.addAll(data);
      _currentPage += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextTheme textTheme = Theme.of(context).textTheme;
    // var size = MediaQuery.of(context).size;

    // /*24 is for notification bar on Android*/
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('YuGiDB'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'Search card...',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: clearText, icon: const Icon(Icons.clear))),
              onChanged: (value) {
                if (value.length >= 3) {
                  setState(() {
                    searchstr = value;
                  });
                } else {
                  setState(() {
                    searchstr = '';
                  });
                }
              },
              onSubmitted: (String value) {
                _handleSubmit();
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (3 / 4),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      Color color;
                      if (cards[index].cardType.contains('Spell')) {
                        color = Colors.greenAccent; // new color
                      } else if (cards[index].cardType.contains('Trap')) {
                        color = const Color.fromARGB(
                            255, 220, 135, 235); // new color
                      } else if (cards[index].cardType.contains('Ritual')) {
                        color = Colors.blueGrey; // new color
                      } else if (cards[index].cardType.contains('Fusion')) {
                        color = const Color.fromARGB(
                            255, 162, 35, 185); // new color
                      } else if (cards[index].cardType.contains('Link')) {
                        color = Colors.lightBlueAccent; // new color
                      } else if (cards[index].cardType.contains('XYZ')) {
                        color =
                            const Color.fromARGB(255, 47, 47, 47); // new color
                      } else if (cards[index].cardType.contains('Synchro')) {
                        color =
                            const Color.fromRGBO(192, 192, 192, 1); // new color
                      } else {
                        color = Colors.blue; // new color
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewScreen(
                                      data: cards[index],
                                      color: color,
                                    )),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: color,
                              boxShadow: [
                                BoxShadow(color: color, spreadRadius: 3),
                              ]),
                          child: Column(
                            children: [
                              Image.network(
                                cards[index].imageUrl,
                                width: 100.0,
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 15.0),
                              Center(
                                child: Text((cards[index].cardName),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
