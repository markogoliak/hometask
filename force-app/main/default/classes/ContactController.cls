public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Account.Name, Email FROM Contact];
    }

    @AuraEnabled
    public static void deleteContacts(List<Id> lstConIds){
        try {
            List<Contact> lstConsToDelete = new List<Contact>();
            List<Case> cases = [SELECT ID, contactId FROM Case WHERE contactId IN: lstConIds];
            delete cases;
            for(Id itemId:lstConIds ){
                lstConsToDelete.add(new Contact(Id = itemId));
            }
            delete lstConsToDelete;
        }
        catch(DmlException ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}
