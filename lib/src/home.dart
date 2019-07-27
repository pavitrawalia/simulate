import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'data/simulations.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/custom_items/chemistry_page.dart';
import 'package:simulate/src/custom_items/home_page.dart';
import 'package:simulate/src/custom_items/mathematics_page.dart';
import 'package:simulate/src/custom_items/physics_page.dart';
import 'package:simulate/src/custom_items/algorithms_page.dart';
import 'package:simulate/src/custom_items/simulation_card.dart';

class Home extends StatefulWidget {
  final List<Widget> _categoryTabs = [
    Tab(
      child: Text('Home'),
    ),
    Tab(
      child: Text('Physics'),
    ),
    Tab(
      child: Text('Algorithms'),
    ),
    Tab(
      child: Text('Mathematics'),
    ),
    Tab(
      child: Text('Chemistry'),
    ),
  ];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _categoryController;

  @override
  void initState() {
    super.initState();
    _categoryController = TabController(
      vsync: this,
      length: 5,
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Simulate',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Ubuntu',
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SimulationSearch(),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _categoryController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black.withOpacity(0.3),
          indicatorColor: Colors.black,
          tabs: widget._categoryTabs,
        ),
      ),
      body: TabBarView(
        controller: _categoryController,
        children: <Widget>[
          HomePage(),
          PhysicsPage(),
          AlgorithmsPage(),
          MathematicsPage(),
          ChemistryPage(),
        ],
      ),
    );
  }
}

class SimulationSearch extends SearchDelegate<SimulationCard> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    return (query != '')
        ? (appState.searchSims(query).length != 0)
            ? GridView.count(
                crossAxisCount: (MediaQuery.of(context).size.width < 600)
                    ? 2
                    : (MediaQuery.of(context).size.width / 200).floor(),
                children: appState.searchSims(query),
              )
            : Container(
                child: Center(
                  child: Text(
                    "Sorry, couldn't find a simulation",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              )
        : Container(
            child: Center(
              child: Text(
                'Search for Simulations',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
          );
  }
}