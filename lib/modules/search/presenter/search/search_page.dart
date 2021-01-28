import 'package:clean_flutterando/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_flutterando/modules/search/presenter/search/states/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Github Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            //Não iremos tipar o StreamBuilder, pois não é feito uso do snapshot;
            child: StreamBuilder(
              stream: bloc,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return Center(
                    child: Text('Digite um texto'),
                  );
                }

                if (state is SearchError) {
                  return Center(
                    child: Text('Houve um erro'),
                  );
                }

                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final list = (state as SearchSuccess).list;

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, id) {
                    final item = list[id];
                    return ListTile(
                      leading: item.img != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(item.img),
                            )
                          : Container(),
                      title: Text(item.login ?? ""),
                      subtitle: Text(item.id),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
