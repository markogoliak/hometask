public with sharing class TestUtils {
    public static Contact insertContactWithFirstAndLastName(){
        Contact cont = new Contact(FirstName='fname', LastName = 'lname');
        insert cont;
        return cont;
    }

    public static Case insertCaseWithContact(Contact cont){
        Case contactCase = new Case(Status = 'New', Origin = 'Email', ContactId = cont.Id);
        insert contactCase;
        return contactCase;
    }
}
