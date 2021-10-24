import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '\filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _gluentfree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState(){
    _gluentfree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose'] ?? false;
    _vegetarian = widget.currentFilters['vegetarian'] ?? false;
    _vegan = widget.currentFilters['vegan'] ?? false;
    super.initState();
  }
  Widget _buildSwitchListTile(String title, 
                              String description,
                              bool currentValue, 
                              Function(bool)? updateValue) {
  return   SwitchListTile(
              title: Text(title),
              value: currentValue,
              subtitle: Text(
                description
                ),
              onChanged: updateValue,
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            final _selectedFilters = {
               'gluten': _gluentfree,
               'lactose': _lactoseFree,
               'vegan': _vegan,
               'vegetarian': _vegetarian,
            };
            widget.saveFilters(_selectedFilters);
          },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text('Adjust your meal selection',
          style: Theme.of(context).textTheme.bodyText1),
        ),
        Expanded(
          child: ListView(children: [
            _buildSwitchListTile('Gluten-Free',
             'Only include gluten-free meals', 
             _gluentfree, (newValue){
               setState(() {
                 _gluentfree = newValue;
               });
             }),
             _buildSwitchListTile('Lactose-Free',
             'Only include Lactose-free meals', 
             _lactoseFree, (newValue){
               setState(() {
                 _lactoseFree = newValue;
               });
             }),
             _buildSwitchListTile('Vegetrain-Free',
             'Only include -free meals', 
             _vegetarian, (newValue){
               setState(() {
                 _vegetarian = newValue;
               });
             }),
             _buildSwitchListTile('Vegan-Free',
             'Only include Vegan-free meals', 
             _vegan, (newValue){
               setState(() {
                 _vegan = newValue;
               });
             })
              
            
          ],),
        )
      ],)
    );
  }
}