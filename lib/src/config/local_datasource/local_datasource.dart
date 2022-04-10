


import 'package:contacts_service/contacts_service.dart';

import '../../model/entities/contact_entity.dart';

abstract class LocalDataSource{
  Future<List<ContactEntity>> getDeviceNumbers();
}

class LocalDataSourceImpl implements LocalDataSource{
  @override
  Future<List<ContactEntity>> getDeviceNumbers()async {
   List<ContactEntity> contacts=[];
   final getContactsData= await ContactsService.getContacts();

   getContactsData.forEach((myContact) {
     myContact.phones!.forEach((phoneData) {
       contacts.add(ContactEntity(
         phoneNumber: phoneData.value.toString(),
         label: myContact.displayName.toString(), uid: '', status: '',
       ));
     });
   });
   return contacts;
  }

}