import 'package:flutter/material.dart';

import '../models/polling_model.dart';

class PollingModal extends StatefulWidget {
  const PollingModal({super.key});

  @override
  State<PollingModal> createState() => _PollingModalState();
}

class _PollingModalState extends State<PollingModal> {
  List<PollingModel> _searchResult = [];

  List<PollingModel> _pollList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pollList = pollingData;
    _searchResult.addAll(_pollList);
  }

  String selectedPoll = '';
  final TextEditingController _searchController = TextEditingController();

  void _searchItem(String query) {
    if (query.isEmpty) {
      _searchResult = _pollList;
      setState(() {});
    } else {
      _searchResult = _pollList
          .where((item) => item.name
              .toString()
              .toLowerCase()
              .contains(query.toString().toLowerCase()))
          .toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _searchItem(value);
                setState(() {});
              },
              decoration: InputDecoration(
                filled: true,
                counterText: "",
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(47, 79, 79, 1),
                ),
                contentPadding: const EdgeInsets.all(18),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(47, 79, 79, 1), width: 1),
                ),
                // hintStyle: TextStyle(color: Color.fromRGBO(47, 79, 79, 1)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchResult.length,
                  itemBuilder: (context, index) {
                    final pollVariable = _searchResult[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedPoll = pollVariable.name;
                          });
                          Navigator.pop(context, selectedPoll);
                        },
                        child: Text(pollVariable.name),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
