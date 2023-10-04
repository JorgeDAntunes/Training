public class Accounts extends fflib_SObjectDomain  {
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }
    

    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
		String phrase = 'Domain classes rock!';
        List<Account> updateAccounts = new List<Account>();
        for(Account account : (List<Account>) Records) {
            account.AnnualRevenue = phrase.getLevenshteinDistance(account.Description);
            updateAccounts.add(account);
        }
        fflib_SObjectUnitOfWork objUnitOfWork = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {Account.SObjectType});
        objUnitOfWork.registerDirty(updateAccounts);
    }
    
    public override void onApplyDefaults() {
         for (Account account : (List<Account>) Records) {
            account.Description = 'Domain classes rock!';
        }
    }   
}