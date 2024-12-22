import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _plants = List.generate(10, (index) => 'Plant ${index + 1}');
  int _selectedFiltersCount = 0;

  void _navigateToFilters() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FiltersScreen(
          selectedFiltersCount: _selectedFiltersCount,
        ),
      ),
    );
    if (result != null && result is int) {
      setState(() {
        _selectedFiltersCount = result;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Plants'),
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
                    decoration: InputDecoration(
                      hintText: 'Поиск растений',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: _navigateToFilters,
                    ),
                    if (_selectedFiltersCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            '$_selectedFiltersCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
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
              itemCount: _plants.length,
              itemBuilder: (context, index) {
                final plant = _plants[index];
                return ListTile(
                  title: Text(plant),
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

class FiltersScreen extends StatelessWidget {
  final int selectedFiltersCount;

  FiltersScreen({required this.selectedFiltersCount});

  @override
  Widget build(BuildContext context) {
    int _tempFiltersCount = selectedFiltersCount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Количество выбранных фильтров: $_tempFiltersCount'),
            ElevatedButton(
              onPressed: () {
                _tempFiltersCount++;
                Navigator.pop(context, _tempFiltersCount);
              },
              child: Text('Добавить фильтр'),
            ),
          ],
        ),
      ),
    );
  }
}

class PlantDetailScreen extends StatelessWidget {
  final String plantName;

  PlantDetailScreen({required this.plantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plantName),
      ),
      body: Center(
        child: Text('Детальная информация о растении $plantName'),
      ),
    );
  }
}