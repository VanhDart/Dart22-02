import 'dart:convert';

import 'package:bai1/page_1.dart';
import 'package:bai1/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'province_view.dart';
import 'district_view.dart';
import 'ward_view.dart';
import 'new_page.dart';
import 'address_info.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
 final RegistrationData registrationData;

  const CounterPage({Key? key, required this.registrationData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CounterPageState(); 
  }
}

class _CounterPageState extends State<CounterPage> {
  late List<Province> provinceList;
  late List<District> districtList;
  late List<Ward> wardList;
  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;

 void _navigateToNewPage() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NextPage(
        userInfo: UserInfo(
          name: widget.registrationData.name,
          email: widget.registrationData.email,
          phoneNumber: widget.registrationData.phoneNumber,
          birthDate: widget.registrationData.birthDate,
          address: AddressInfo(street: widget.registrationData.street),
        ),
      ),
    ),
  );
}

  @override
  void initState() {
    super.initState();
    provinceList = [];
    districtList = [];
    wardList = [];
    selectedProvince = null;
    selectedDistrict = null;
    selectedWard = null;
    loadLocationData();
  }
  
  Future<void> loadLocationData() async {
    try {
      String data = await rootBundle.loadString('don_vi_hanh_chinh.json'); // Đảm bảo rằng tên tệp JSON đúng và đã được đặt trong thư mục assets
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
      debugPrint('Error loading location data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Địa chỉ'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector( 
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: DropdownButton<Province>(
                value: selectedProvince,
                hint: const Text('Select Province'),
                onChanged: (newValue) {
                  setState(() {
                    selectedProvince = newValue;
                    selectedDistrict = null; 
                    selectedWard = null; 
                  });
                },
                items: provinceList.map((Province province) {
                  return DropdownMenuItem<Province>(
                    value: province,
                    child: Text(province.name),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: DropdownButton<District>(
                value: selectedDistrict,
                hint: const Text('Select District'),
                onChanged: (newValue) {
                  setState(() {
                    selectedDistrict = newValue;
                    selectedWard = null; 
                  });
                },
                items: districtList.map((District district) {
                  if (selectedProvince != null &&
                      district.provinceId == selectedProvince!.id) {
                    return DropdownMenuItem<District>(
                      value: district,
                      child: Text(district.name),
                    );
                  } else {
                    return const DropdownMenuItem<District>(
                      value: null,
                      child: Text(''),
                    );
                  }
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: DropdownButton<Ward>(
                value: selectedWard,
                hint: const Text('Select Ward'),
                onChanged: (newValue) {
                  setState(() {
                    selectedWard = newValue;
                  });
                },
                items: wardList.map((Ward ward) {
                  if (selectedDistrict != null &&
                      ward.districtId == selectedDistrict!.id) {
                    return DropdownMenuItem<Ward>(
                      value: ward,
                      child: Text(ward.name),
                    );
                  } else {
                    return const DropdownMenuItem<Ward>(
                      value: null,
                      child: Text(''),
                    );
                  }
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToNewPage,
              child: const Text('Kết quả'),
            ),
          ],
        ),
      ),
    );
  }
}

