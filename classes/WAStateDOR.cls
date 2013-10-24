/**
author        : techieavenger.com
date          : 22 Oct, 2013
description   : This is the main Lib class which handles and contains all methods representing 
                transaction related to calls to the Washington State servers to retrieve sales tax
                information.
*/
public class WAStateDOR{
    //Class variables
    public string address{get;set;}
    public string city{get;set;}
    public string zip{get;set;}
    public string rate{get;set;}
    public TaxInfo taxi{get;set;}
    
    //Class to hold results
    public class TaxInfo {
        public integer location_code{get;set;}
        public decimal rate{get;set;}
    }
    
    //Encode URL
    public string getEncodedURL() {
        String url = 'http://dor.wa.gov/AddressRates.aspx?' +
                     'output=xml&addr=' +
                     EncodingUtil.urlEncode(this.address, 'UTF-8') +
                     '&city=' + EncodingUtil.urlEncode(this.city, 'UTF-8') +
                     '&zip=' + EncodingUtil.urlEncode(this.zip, 'UTF-8');
        
        //System.debug('encodedURL= ' + url);
        return url;
    }
    
    Public HTTPResponse getWAStateDORResponse(string url) {
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        request.setMethod('GET');
        
        request.setEndpoint(url);
        HTTPResponse response = http.send(request);
        //system.debug('FULL RESPONSE ' + response);
        string xml_response = response.getBody().replace('\n', ' ');
        //system.debug('response is:: '+xml_response);
        
        return response;
    }
    
    public void process() {
        //Variable to hold results
        taxi = getWATaxInfo(getWAStateDORResponse(getEncodedURL()));
    }
    
    
    public Taxinfo getWATaxInfo(HTTPResponse response){
        // Generate the HTTP response as an XML stream
        XmlStreamReader reader = response.getXmlStreamReader();
        System.debug('#XML DATA#'+response.getXmlStreamReader());
        
        //Create new tax info item for storage
        TaxInfo taxinfo = new TaxInfo();
        
        while(reader.hasNext()) {
        if (reader.getEventType() == XmlTag.START_ELEMENT) {
            system.debug(reader.getLocalName());
            if ('response' == reader.getLocalName()) {
                //System.debug(reader.getAttributeValue(null, 'loccode'));
                taxinfo.location_code = Integer.valueOf(reader.getAttributeValue(null, 'loccode'));
                //System.debug('LC variable = ' +taxinfo.location_code);
                
                //System.debug(reader.getAttributeValue(null, 'rate'));
                taxinfo.rate = Decimal.valueOf(reader.getAttributeValue(null, 'rate'));
                //System.debug('Rate variable = ' +taxinfo.rate);
            }
        }
            reader.next();
        } 
        
        return taxinfo;
    }
}