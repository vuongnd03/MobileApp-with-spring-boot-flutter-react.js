import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mobile_app_ecommerce/features/shippingadress/model/address.dart';
import 'package:mobile_app_ecommerce/features/shippingadress/reponsitory/address_reponsitory.dart';
import 'package:mobile_app_ecommerce/features/shippingadress/widget/address_card.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class ShippingAddressScreen extends StatelessWidget {
  final AddressReponsitory _addressReponsitory = AddressReponsitory();
  ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
          ),
        title: Text(
          'Địa chỉ giao hàng',
          style: AppTestStyle.withColor(
            AppTestStyle.h3,
             isDark ? Colors.white : Colors.black,
            ),
        ),
        actions: [
          IconButton(
            onPressed: ()=>_showAddAddressBottomSheet(context), 
            icon: Icon(
              Icons.add_circle_outline,
              color:  isDark ? Colors.white : Colors.black,
            ),
            ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _addressReponsitory.getAddresses().length,
        itemBuilder: (context, index) => _buildAddressCard(context,index),
        ),
    );
  }

  Widget _buildAddressCard(BuildContext context,int index){
    final address = _addressReponsitory.getAddresses()[index];

    return AddressCard(
      address: address,
      onEdit: () => _showEditAddressBottomSheet(context, address),
      onDelete: () =>_showDeleteConfirmation(context, address),
    );
  }
  void _showEditAddressBottomSheet(BuildContext context,Address address){
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),

        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chỉnh sửa địa chỉ',
                  style: AppTestStyle.withColor(
                      AppTestStyle.h3,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                ),
                IconButton(
                  onPressed: ()=> Get.back(), 
                  icon: Icon(
                    Icons.close,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextField(
                context,
                'Label (e.g. Home, Office)',
                Icons.label_outline,
                initialValue: address.label
            ),
            const SizedBox(height: 16),
            _buildTextField(
                context,
                'Địa chỉ đầy đủ',
                Icons.location_on_outlined,
                initialValue: address.fullAdress,
            ),
            const SizedBox(height: 16),
            _buildTextField(
                context,
                'Thành phố',
                Icons.location_city_outlined,
                initialValue: address.city,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    context, 
                    'Tình trạng', 
                    Icons.map_outlined,
                    initialValue: address.state,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                  child: _buildTextField(
                    context, 
                    'Mã bưu điện', 
                    Icons.pin_outlined,
                    initialValue: address.zipCode,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                //handle update address
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),

                ),
              ),
              child: Text(
                'Cập nhật địa chỉ',
                style: AppTestStyle.withColor(
                      AppTestStyle.buttonMedium,
                      Colors.white,
                      ),
              ),
              ),
            ),
            const SizedBox(height: 16),

          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showDeleteConfirmation(BuildContext context, Address address){
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child:const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Xoá địa chỉ',
              style:  AppTestStyle.withColor(
                      AppTestStyle.h3,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bạn có chắc chắn muốn xoá địa chỉ này không?',
              textAlign: TextAlign.center,
              style:  AppTestStyle.withColor(
                      AppTestStyle.h3,
                       isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(), 
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                        color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTestStyle.withColor(
                          AppTestStyle.buttonMedium,
                         Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    ), 
                  ), 
                  const SizedBox(width: 16),
                  Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      //handle delete address
                      Get.back();

                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Xoá',
                      style: AppTestStyle.withColor(
                          AppTestStyle.buttonMedium,
                         Colors.white,
                      ),
                    ),
                    ), 
                  ),
              ],
            )
          ],
        ),
      ),
      barrierColor: Colors.black54,
    );
  }

  Widget _buildTextField(BuildContext context, String label, IconData icon,{String? initialValue}){
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon,color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          )
        ),
      ),
    );
  }
  void _showAddAddressBottomSheet(BuildContext context){
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thêm địa chỉ mới',
                    style: AppTestStyle.withColor(
                          AppTestStyle.h3,
                          Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                ),
                IconButton(
                  onPressed: () => Get.back(), 
                  icon: Icon(
                    Icons.close, color: isDark ? Colors.white : Colors.black,
                  ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextField(
                context, 
                'Label (e.g. , Home, Office)', 
                Icons.label_outline,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context, 
                'Full Address', 
                Icons.location_on_outlined,
              ),
              const SizedBox(height: 16),
               _buildTextField(
                context, 
                'City ', 
                Icons.location_city_outlined,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      context, 
                      'State', 
                      Icons.map_outlined,
              ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                    child: _buildTextField(
                      context, 
                      'ZIP Code', 
                      Icons.pin_outlined,
              ),
                    ),

                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    //handle save address
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Address',
                    style: AppTestStyle.withColor(
                          AppTestStyle.buttonMedium,
                          Colors.white,
                      ),
                  ),
                  ),
              )
          ],
        ),
      )
    );
  }
}