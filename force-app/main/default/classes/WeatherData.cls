global with sharing class WeatherData {
    @AuraEnabled public String cityName;
    @AuraEnabled public String cityTimeZone;
    @AuraEnabled public Decimal cityTemp;
    @AuraEnabled public String state;
    @AuraEnabled public Decimal cityWindSpeed;
    @AuraEnabled public String cityLat;
    @AuraEnabled public String cityLong;
    @AuraEnabled public Decimal cityPrecip;
}