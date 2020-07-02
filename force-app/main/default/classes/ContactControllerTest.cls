@isTest
public with sharing class ContactControllerTest {
    @isTest static void getAllContact() {
        List<Contact> contactsFromController = ContactController.getContactList();
        List<Contact> contactsFromSelector = [SELECT Id, Name, Account.Name, Email FROM Contact];
        System.assertEquals(contactsFromSelector.toString(), contactsFromController.toString());
    }

    @isTest static void deleteContactByIDs() {
        Contact cont = new Contact(FirstName='fname', LastName = 'lname');
        insert cont;
        List<ID> contactIds = new List<Id>();
        contactIds.add(cont.Id);
        Test.StartTest(); 
        ContactController.deleteContacts(contactIds);
        List<Contact> contactAfterDelete = [SELECT Id, Name, Account.Name, Email FROM Contact WHERE Id IN: contactIds];
        System.assertEquals(contactAfterDelete.size(), 0);
        Test.StopTest();
    }

    @isTest static void deleteContactWithCases(){
        Contact cont = new Contact(FirstName='fname', LastName = 'lname');
        insert cont;
        Case contactCase = new Case(Status = 'New',Origin = 'Email', ContactId = cont.Id);
        insert contactCase;
        List<ID> contactIds = new List<Id>();
        contactIds.add(cont.Id);
        Test.StartTest();
        ContactController.deleteContacts(contactIds);
        List<Contact> contactAfterDelete = [SELECT Id, Name, Account.Name, Email FROM Contact WHERE Id IN: contactIds];
        System.assertEquals(contactAfterDelete.size(), 0);
        Test.StopTest();
    }
}
