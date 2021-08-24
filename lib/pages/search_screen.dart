import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sahemapp/widgets/filter_dialog.dart';
import '../widgets/search_item.dart';
import '../utils/helpers.dart';

class SearchPage extends StatefulWidget {
  static const routeName = 'search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> filteredList = images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo3.png',
          height: 40,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
            Material(
              elevation: 20,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.circular(14),
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: false,
                cursorColor: Colors.white,
                style: Theme.of(context).textTheme.headline5,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: IconButton(
                      icon: const Center(child: Icon(Icons.menu_rounded, size: 35)),
                      color: Colors.white,
                      onPressed: () => {
                        showDialog(context: context, builder: (context) {
                          return const FiltersDialog();
                        },)
                      },
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: const Center(child: Icon(Icons.search, size: 35)),
                      color: Colors.white,
                      onPressed: () => searchSubmitted(_controller.text),
                    ),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).accentColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  focusedBorder: searchTextFieldBorder(),
                  enabledBorder: searchTextFieldBorder(),
                ),
                onSubmitted: (value) => searchSubmitted(value),
                onChanged: (value) => searchSubmitted(value),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: filteredList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return SearchItem(imagePath: filteredList[index]);
                },
                staggeredTileBuilder: (index)=> const StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchSubmitted(String query){
    setState(() {
      filteredList = images.where((value){
        var t = value.trim();
        var q = query.trim();
        return t.contains(q);
      }).toList();
    });
  }
}
