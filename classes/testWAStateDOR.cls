/**
author        : techieavenger.com
date          : 22 Oct, 2013
description   : Test class for WAStateDOR
*/
@isTest
public class testWAStateDOR{
    public static testmethod void RegularTests(){
        WAStateDOR testcall = New WAStateDOR();
        testcall.address = '123 Main Street';
        testcall.city = 'Yakima';
        testcall.zip = '98901';
        
        
        //Test URL Encoding
        string url = testcall.getEncodedURL();
        system.assertEquals('http://dor.wa.gov/AddressRates.aspx?output=xml&addr=123+Main+Street&city=Yakima&zip=98901', url);
        
        //Test Response Parsing
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new testMockHTTPCalloutResponse());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = testcall.getWAStateDORResponse(url);
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'text/xml');
        String actualValue = res.getBody();
        System.assertEquals(200, res.getStatusCode());
        
        WAStateDOR.TaxInfo ti = new WAStateDOR.TaxInfo();
        ti = testcall.getWATaxInfo(res);
        decimal expectedRate = 0.079;
        integer expectedLC = 3900;
        System.assertEquals(ti.rate, expectedRate);
        System.assertEquals(ti.location_code, expectedLC);
    }
}