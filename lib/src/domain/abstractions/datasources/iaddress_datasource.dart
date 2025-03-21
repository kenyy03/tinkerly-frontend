import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IAddressDataSource {
  Future<Address> getAddressByUserId({required String userId});
  Future<Address> saveAddress({required Address addressRequest});
}