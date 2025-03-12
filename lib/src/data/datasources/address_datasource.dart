import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

class AddressDataSource extends IAddressDataSource {
  @override
  Future<Address> getAddressByUserId({required String userId}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/get-address-by-user-id')
                   .replace(queryParameters: {'userId': userId});
                   
      final response = await http.get(
        uri, 
        headers: { 'Content-Type': 'application/json', },
      );

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }
      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final addressResponse = Address.fromMap(jsonResponse['data'] ?? {});
      return addressResponse;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<Address> saveAddress({required Address addressRequest}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/save-address');
      String body = json.encode({...addressRequest.toJson(), 'cityId': addressRequest.city.id });
      final response = await http.post(
        uri,
        headers: { 'Content-Type': 'application/json', },
        body: body
      );

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }
      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final addressResponse = Address.fromMap(jsonResponse['data']);
      return addressResponse;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

}