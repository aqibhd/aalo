import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/overlay_appbar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Column(children: [
        OverlayAppBar(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(100.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Colors.black,
                    cursorHeight: 18,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "what do you want to search for?",
                        hintStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                ),
              ))
            ],
          ),
        )),
        const Gap(10),
        Container(
          height: 20,
          width: double.infinity,
          color: Colors.green,
        )
      ]),
    );
  }
}
