/**
author        : techieavenger.com using www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_httpcalloutmock.htm
date          : 24 Oct, 2013
description   : Creates mock httpresponse for testing code that calls remote servers
*/

global class testMockHTTPCalloutResponse implements HttpCalloutMock {
    // Implement this interface method
    public HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'text/xml');
        res.setBody('<response loccode="3900" localrate="0.014" rate="0.079" code="2"><addressline/><rate name="YAKIMA COUNTY" code="3900" staterate="0.065" localrate="0.014"/></response>');
        res.setStatusCode(200);
        return res;
    }
}