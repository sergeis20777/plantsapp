import 'package:flutter/material.dart';
import '../service/search_service.dart';
import '../screens/plan_details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Map<String, dynamic> _selectedFilters = {};
  List<String> _searchResults = List.generate(10, (index) => 'Plant ${index + 1}');

  void _openFilterScreen() async {
    final filters = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(selectedFilters: _selectedFilters),
      ),
    );

    if (filters != null) {
      setState(() {
        _selectedFilters = filters;
      });
      _fetchSearchResults(_searchController.text);
    }
  }

  void _navigateToPlantDetail(String plantName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantDetailScreen(plantName: plantName),
      ),
    );
  }

  Future<void> _fetchSearchResults(String query) async {
    final results = await SearchService.fetchFromServer(query, _selectedFilters);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (text) => _fetchSearchResults(text),
                    decoration: InputDecoration(
                      hintText: 'Поиск растений',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: _openFilterScreen,
                    ),
                    if (_selectedFilters.isNotEmpty)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '${_selectedFilters.length}',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final plant = _searchResults[index];
                return ListTile(
                  title: Text(_searchResults[index]),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () => _navigateToPlantDetail(plant),
                );
              },
            ),

          ),
        ],
      ),
    );
  }
}

class FilterScreen extends StatefulWidget {
  final Map<String, dynamic> selectedFilters;

  FilterScreen({Key? key, required this.selectedFilters}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, bool> _temperatureOptions = {
    '0-10°C': false,
    '10-20°C': false,
    '20-30°C': false,
    '30-40°C': false,
  };

  Map<String, bool> _humidityOptions = {
    '0-20%': false,
    '20-40%': false,
    '40-60%': false,
    '60-80%': false,
    '80-100%': false,
  };

  @override
  void initState() {
    super.initState();
    _temperatureOptions = {
      ..._temperatureOptions,
      ...widget.selectedFilters['temperature'] ?? {},
    };
    _humidityOptions = {
      ..._humidityOptions,
      ...widget.selectedFilters['humidity'] ?? {},
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фильтры'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text('Температура'),
                  children: _temperatureOptions.keys.map((option) {
                    return CheckboxListTile(
                      title: Text(option),
                      value: _temperatureOptions[option],
                      onChanged: (value) {
                        setState(() {
                          _temperatureOptions[option] = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  title: Text('Влажность'),
                  children: _humidityOptions.keys.map((option) {
                    return CheckboxListTile(
                      title: Text(option),
                      value: _humidityOptions[option],
                      onChanged: (value) {
                        setState(() {
                          _humidityOptions[option] = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'temperature': _temperatureOptions,
                  'humidity': _humidityOptions,
                });
              },
              child: Text('Сохранить'),
            ),
          ),
        ],
      ),
    );
  }
}
