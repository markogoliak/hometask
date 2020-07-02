@isTest
public with sharing class ContactControllerTest {
    @isTest static void verifyGetAllContact() {
        List<Contact> contactsFromController = ContactController.getContactList();
        List<Contact> contactsFromDatabase = [SELECT Id, Name, Account.Name, Email FROM Contact];
        System.assertEquals(contactsFromDatabase.toString(), contactsFromController.toString(), 
            'Something wrong with ContactController.getContactList');
    }

    @isTest static void verifyDeletedContact() {
        Contact cont = TestUtils.insertContactWithFirstAndLastName();
        List<ID> contactIds = new List<Id>();
        contactIds.add(cont.Id);
        Test.StartTest(); 
        ContactController.deleteContacts(contactIds);
        List<Contact> contactAfterDelete = [SELECT Id, Name, Account.Name, Email FROM Contact WHERE Id IN: contactIds];
        Test.stopTest();
        System.assertEquals(contactAfterDelete.size(), 0, 'Delete contact failed');
    }

    @isTest static void verifyDeletedContactWithCases(){
        Contact cont = TestUtils.insertContactWithFirstAndLastName();
        Case contactCase = TestUtils.insertCaseWithContact(cont);
        List<ID> contactIds = new List<Id>();
        contactIds.add(cont.Id);
        Test.StartTest();
        ContactController.deleteContacts(contactIds);
        List<Contact> contactAfterDelete = [SELECT Id, Name, Account.Name, Email FROM Contact WHERE Id IN: contactIds];
        Test.StopTest();
        System.assertEquals(contactAfterDelete.size(), 0, 'Delete contact with case failed');
    }
}
