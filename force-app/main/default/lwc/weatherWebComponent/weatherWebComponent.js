import { LightningElement, wire, api,track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import performCallout from '@salesforce/apex/WebServiceLWC.performCallout';

export default class WeatherWebComponent extends LightningElement {
    @api recordId;
    
    @track accountNames;
    @track weatherData;
    @track city;
    @track country;
    @track errors;
    @track tempCity;
    @track windSpeedCity;
    @track precipitation;

    @wire(getRecord, {
        recordId: '$recordId', 
        fields: [ 'Account.Name', 'Account.BillingCity', 'Account.BillingCountry' ]})
     wiredAccounts({ error, data }) {
        if (data) {
            this.accountNames = data;
            console.log(data)
            this.city = this.accountNames.fields.BillingCity.value;
            this.country = this.accountNames.fields.BillingCountry.value;
            if(this.city !== undefined){
                performCallout({location: this.city.replace(" ", "_")}).then(data => {
                  this.weatherData = data;
                  console.log(data);
                  this.tempCity = this.weatherData.cityTemp;
                  this.windSpeedCity = this.weatherData.cityWindSpeed;
                  this.precipitation = this.weatherData.cityPrecip;
                }).catch(err => console.log(err));
            }
        } else if (error) {
            this.errors = error;
        }
    }

    get titleName(){
      return 'Info about weather in '+ this.city;
    }
    get tempCity(){
      return this.tempCity;
    }
    get windSpeedCity(){
      return this.windSpeedCity;
    }
    get getPrecip(){
      return this.precipitation;
    }
}