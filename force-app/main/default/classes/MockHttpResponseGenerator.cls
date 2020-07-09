@isTest
global with sharing class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('callout:WeatherAPI?city=Raleigh,US&key=f6b6ac5356bf40aaa88d10f2fb1e14ae', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{  "data":[  {  "temp":24.19,"city_name":"Raleigh","state_code":"NC","wind_cdir":"NE","timezone":"America/New_York","wind_spd":6.17,"lat":"35.7721","lon":"-78.63861","precip":0}],"count":1}');
        res.setStatusCode(200);
        return res;
    }
}
