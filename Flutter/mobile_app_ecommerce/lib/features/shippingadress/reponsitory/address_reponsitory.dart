import 'package:mobile_app_ecommerce/features/shippingadress/model/address.dart';

class AddressReponsitory {
  List<Address> getAddresses(){
    return const[
      Address(
        id: '1', 
        label: 'Nhà riêng', 
        fullAdress: 'số nhà 127 Phú Lương, Hà đông', 
        city: 'Hà Nội', 
        state: 'HN', 
        zipCode: '10001',
        isDefault: true,
        type: AddressType.home,
        ),
      Address(
        id: '2', 
        label: 'Trường Học', 
        fullAdress: 'Đường Nguyễn Trãi, Phường Thanh Xuân ', 
        city: 'Hà Nội', 
        state: 'HN', 
        zipCode: '10002',
        type: AddressType.office,
        ),
    ];
  }

  Address? getDefaultAdsress(){
    return getAddresses().firstWhere(
      (address)=> address.isDefault,
      orElse: () => getAddresses().first,
    );
  }
}