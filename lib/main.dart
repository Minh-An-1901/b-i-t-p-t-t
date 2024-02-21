import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Province {
  final String id;
  final String name;
  final String level;

  Province({required this.id, required this.name, required this.level});

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      level: map['level'] ?? '',
    );
  }
}

class District {
  final String id;
  final String name;
  final String level;
  final String provinceId;

  District({required this.id, required this.name, required this.level, required this.provinceId});

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      level: map['level'] ?? '',
      provinceId: map['provinceId'] ?? '',
    );
  }
}

class Ward {
  final String id;
  final String name;
  final String level;
  final String districtId;
  final String provinceId;

  Ward({required this.id, required this.name, required this.level, required this.districtId, required this.provinceId});

  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      level: map['level'] ?? '',
      districtId: map['districtId'] ?? '',
      provinceId: map['provinceId'] ?? '',
    );
  }
}

class AddressInfo {
  final Province? province;
  final District? district;
  final Ward? ward;
  final String? street;

  AddressInfo({this.province, this.district, this.ward, this.street});

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      province: Province.fromMap(map['province']),
      district: District.fromMap(map['district']),
      ward: Ward.fromMap(map['ward']),
      street: map['street'],
    );
  }
}

class UserInfo {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthDate;
  final AddressInfo? address;

  UserInfo({this.name, this.email, this.phoneNumber, this.birthDate, this.address});

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      birthDate: DateTime.parse(map['birthDate'] ?? ''),
      address: AddressInfo.fromMap(map['address']),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Province> provinceList = [];
  List<District> districtList = [];
  List<Ward> wardList = [];

  @override
  void initState() {
    super.initState();
    loadLocationData();
  }

  Future<void> loadLocationData() async {
    try {
      String data = await rootBundle.loadString(
          'assets/don_vi_hanh_chinh.json');
      Map<String, dynamic> jsonData = json.decode(data);

      List provinceData = jsonData['province'];
      provinceList =
          provinceData.map((json) => Province.fromMap(json)).toList();

      List districtData = jsonData['district'];
      districtList =
          districtData.map((json) => District.fromMap(json)).toList();

      List wardData = jsonData['ward'];
      wardList = wardData.map((json) => Ward.fromMap(json)).toList();
    } catch (e) {
      print('Error loading location data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(

        children: <Widget>[
          ElevatedButton(
            child: Text('Province'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9, // Chiều rộng của hộp thoại
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.7, // Chiều cao của hộp thoại
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Thanh cuộn ngang
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical, // Thanh cuộn dọc
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text('ID'),
                              ),
                              DataColumn(
                                label: Text('Name'),
                              ),
                              DataColumn(
                                label: Text('Level'),
                              ),
                            ],
                            rows: provinceList.map((province) =>
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(province.id)),
                                    DataCell(Text(province.name)),
                                    DataCell(Text(province.level)),
                                  ],
                                )).toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          ElevatedButton(
            child: Text('District'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.7,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text('ID'),
                              ),
                              DataColumn(
                                label: Text('Name'),
                              ),
                              DataColumn(
                                label: Text('Level'),
                              ),
                              DataColumn(
                                label: Text('Province ID'),
                              ),
                            ],
                            rows: districtList.map((district) =>
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(district.id)),
                                    DataCell(Text(district.name)),
                                    DataCell(Text(district.level)),
                                    DataCell(Text(district.provinceId)),
                                  ],
                                )).toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          ElevatedButton(
            child: Text('Ward'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.7,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text('ID'),
                              ),
                              DataColumn(
                                label: Text('Name'),
                              ),
                              DataColumn(
                                label: Text('Level'),
                              ),
                              DataColumn(
                                label: Text('District ID'),
                              ),
                              DataColumn(
                                label: Text('Province ID'),
                              ),
                            ],
                            rows: wardList.map((ward) =>
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(ward.id)),
                                    DataCell(Text(ward.name)),
                                    DataCell(Text(ward.level)),
                                    DataCell(Text(ward.districtId)),
                                    DataCell(Text(ward.provinceId)),
                                  ],
                                )).toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
  void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyHomePage(title: 'BÀI TẬP TẾT'),
  ));
}