public with sharing class TestUtils {
    public static Contact insertContactWithFirstAndLastName(String fname, String lname){
        Contact cont = new Contact(FirstName = fname, LastName = lname);
        insert cont;
        return cont;
    }

    public static Case insertCaseWithContact(Contact cont, String stat , String orig){
        Case contactCase = new Case(Status = stat, Origin = orig, ContactId = cont.Id);
        insert contactCase;
        return contactCase;
    }
}
