@isTest
global with sharing class WebServiceLWCTest {
    @isTest
    global static void verifyCallout(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        WeatherData weatherData = WebServiceLWC.performCallout('Raleigh,US');
        System.assertEquals(weatherData.cityTemp, 24.19, 'Temperature field is incorrect');
    }
}
