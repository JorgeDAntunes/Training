public  class CaseService {
    public static void closeCases(Set<ID> caseSet, String closeReason)
    {
        List<Case> caseToUpdate = new List<Case>();
        for (Id caseId : caseSet) {
            Case caseRecord = new Case(Id = caseId);
            caseRecord.Reason = closeReason;
            caseRecord.Status = 'Closed'; 
            
            caseToUpdate.add(caseRecord);
        }
        if (!caseToUpdate.isEmpty()){
            update caseToUpdate;
        }    
    }
}