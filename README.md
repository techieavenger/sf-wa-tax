Salesforce Code Share:: Washington State tax
=========
Apex code to call Washington State DOR servers and return tax rates based on destination.  Test method included for deployment.

For an easy, 1-click installation: [Washington State Destination-Based Tax Code Share](http://developer.force.com/codeshare/project/xxx).

To use the source code with a Salesforce org: [How To Use Github and the Force.com IDE](http://blog.sforce.com/sforce/2011/04/how-to-use-git-github-force-com-ide-open-source-labs-apps.html)

Files
-----
### Pages
* test_salestax -- Simple Visual Force page that allows you to input address, city and zip, click Get Rate and it returns rate and location code.  This 	should help you see how to use the class in your pages.  

### Classes
* WAStateDOR -- Class used to call state servers and return location code and rate information
*testWAStateDOR -- Test used for code coverage
*testMockHTTPCalloutResponse -- Creates mock response from WA State servers to run tests for code coverage.

Setup
-----
1.  In Setup > Security Controls > Remote Site Settings, add the site http://dor.wa.gov 

View functionality
------------------
1.  Browse to [your Salesforce instance]/apex/test_salestax
2.  Put in an address, city and zip
3.  Click "Get Rate"
4.  You will see the returned rate and location code
