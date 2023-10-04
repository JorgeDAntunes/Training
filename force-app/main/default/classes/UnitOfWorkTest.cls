@isTest
public class UnitOfWorkTest {
    @isTest static void challengeComplete(){
        fflib_SObjectUnitOfWork objUnitOfWork = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[]{
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
            }
        );
        
        for (Integer i=0 ; i<100 ; i++) {
            Account a = new Account(Name= 'Test' + i);
            objUnitOfWork.registerNew(a);
            
            for (Integer j=0 ; j<5 ; j++) {
                Contact c = new Contact(LastName = 'Test'+i + ' ' +j);
                objUnitOfWork.registerNew(c, Contact.AccountId, a);
                
                Note n = new Note(Body='Test '+i + '' + j, Title='Test'+i+j);
                objUnitOfWork.registerRelationship(n, Note.ParentId, a);
                objUnitOfWork.registerNew(n, Note.ParentId, a);
            }
        }

        objUnitOfWork.commitWork();
 
        fflib_SObjectUnitOfWork objUnitOfWork2 = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[]{
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
            }
        );        
        for (Account a : [SELECT Id, Name, (SELECT Id, LastName FROM Contacts), (SELECT Id, ParentId, Title, Body FROM Notes) FROM Account]) {
            a.Name = 'Test';
            objUnitOfWork.registerDirty(a);
            
            Integer i = 0;
            for (Contact c : a.Contacts) {
                c.LastName = 'Test';
                objUnitOfWork.registerDirty(c);
                
                a.Notes[i].Body='Test';
                objUnitOfWork.registerDirty(a.Notes[i]);
                i++;
            }
        }        
        
        test.startTest();
            objUnitOfWork.commitWork();
        test.stopTest();
        
        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }
}