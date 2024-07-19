class Region {
  int id;
  String name;

  Region({required this.id, required this.name});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Country {
  int id;
  String company;

  Country({required this.id, required this.company});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      company: json['company'],
    );
  }
}

class Coffee {
  List<Region> region;
  Country country;

  Coffee({required this.region, required this.country});

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      region: List<Region>.from(json['region'].map((x) => Region.fromJson(x))),
      country: Country.fromJson(json['country']),
    );
  }
}

class Brewing {
  List<Region> region;
  Country country;

  Brewing({required this.region, required this.country});

  factory Brewing.fromJson(Map<String, dynamic> json) {
    return Brewing(
      region: List<Region>.from(json['region'].map((x) => Region.fromJson(x))),
      country: Country.fromJson(json['country']),
    );
  }
}

class CoffeeAndBrewing {
  Coffee coffee;
  Brewing brewing;

  CoffeeAndBrewing({required this.coffee, required this.brewing});

  factory CoffeeAndBrewing.fromJson(Map<String, dynamic> json) {
    return CoffeeAndBrewing(
      coffee: Coffee.fromJson(json['coffee']),
      brewing: Brewing.fromJson(json['brewing']),
    );
  }
}

Map<String, Type> regionTypeMap = {
  'id': int,
  'name': String,
};

Map<String, Type> countryTypeMap = {
  'id': int,
  'company': String,
};

Map<String, dynamic> coffeeTypeMap = {
  'region': [regionTypeMap], // List of Region maps
  'country': countryTypeMap,
};

Map<String, dynamic> brewingTypeMap = {
  'region': [regionTypeMap], // List of Region maps
  'country': countryTypeMap,
};

Map<String, dynamic> coffeeAndBrewingTypeMap = {
  'coffee': coffeeTypeMap,
  'brewing': brewingTypeMap,
};
