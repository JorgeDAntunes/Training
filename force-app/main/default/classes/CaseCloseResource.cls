@RestResource(urlMapping='/case/*/close')
global class CaseCloseResource {
    @httpPost
    global static void closeCase(String closeReason)
    {
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        Id caseId = uriParts[2];
        
        CaseService.closeCases(new Set<ID> { caseId }, closeReason);  
        
    }
}