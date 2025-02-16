import 'package:mobile_frontend/src/domain/domain.dart';

class AddressRepository extends IAddressRepository {
  final IAddressDataSource _dataSource;

  AddressRepository({required IAddressDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Address> getAddressByUserId({required String userId}) {
    return _dataSource.getAddressByUserId(userId: userId);
  }

  @override
  Future<Address> saveAddress({required Address addressRequest}) {
    return _dataSource.saveAddress(addressRequest: addressRequest);
  }
}