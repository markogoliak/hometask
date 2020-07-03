@isTest
public with sharing class ContactControllerTest {
    @testSetup
    static void makeData(){
        Contact cont = new Contact();
        for(Integer i=0;i<2;i++) {
            cont = TestUtils.insertContactWithFirstAndLastName('TestFirstName' + i, 'TestLastName' + i);
        }
        TestUtils.insertCaseWithContact(cont, 'New', 'Email');
    }

    @isTest static void verifyGetAllContact() {
        List<Contact> contactsFromController = ContactController.getContactList();
        List<Contact> contactsFromDatabase = [SELECT Id, Name, Account.Name, Email FROM Contact];
        System.assertEquals(contactsFromDatabase.toString(), contactsFromController.toString(), 
            'Something wrong with ContactController.getContactList');
    }

    @isTest static void verifyDeletedContact() {
        Contact cont = [SELECT Id FROM Contact WHERE FirstName='TestFirstName0' AND LastName='TestLastName0' LIMIT 1];
        List<ID> contactIds = new List<Id>();
        contactIds.add(cont.Id);
        Test.StartTest(); 
        ContactController.deleteContacts(contactIds);
        List<Contact> contactAfterDelete = [SELECT Id, Name, Account.Name, Email FROM Contact WHERE Id IN: contactIds];
        Test.stopTest();
        System.assertEquals(contactAfterDelete.size(), 0, 'Delete contact failed');
    }

    @isTest static void verifyDeletedContactWithCases(){
        Contact cont =  [SELECT Id FROM Contact WHERE FirstName='TestFirstName1' AND LastName='TestLastName1' LIMIT 1];
        List<ID> contactIds = new List<Id>();
        contactIds.add(cont.Id);
        Test.StartTest();
        ContactController.deleteContacts(contactIds);
        List<Contact> contactAfterDelete = [SELECT Id, Name, Account.Name, Email FROM Contact WHERE Id IN: contactIds];
        Test.stopTest();
        System.assertEquals(contactAfterDelete.size(), 0, 'Delete contact with case failed');
    }
}
