import {LightningElement, track, wire} from 'lwc';

import getContacts from '@salesforce/apex/ContactController.getContactList';
import delSelectedCons from '@salesforce/apex/ContactController.deleteContacts';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';

import {refreshApex} from '@salesforce/apex';

const columns = [
    {
        label: 'Name',
        fieldName: 'Name'
    }, {
        label: 'Account Name', 
        fieldName: 'accountName', 
        type: 'text'
    }, {
        label: 'Email',
        fieldName: 'Email',
        type: 'email'
    }
];

export default class DeleteListWebComponent extends LightningElement {
    @track data;
    @track columns = columns;
    @track buttonLabel = 'Delete';
    @track isTrue = false;
    @track recordsCount = 0;

    selectedRecords = [];
    refreshTable;
    error;

    @wire(getContacts)
    contacts(result) {
        this.refreshTable = result;
        if (result.data) {
            this.data = result.data.map(row=>{
                return {...row, accountName: (row.Account === undefined) ? '' : row.Account.Name}
            });
            this.error = undefined;

        } else if (result.error) {
            this.error = result.error;
            this.data = undefined;
        }
    }


    getSelectedRecords(event) {
        const selectedRows = event.detail.selectedRows;
        
        this.recordsCount = event.detail.selectedRows.length;

        let conIds = new Set();

        for (let i = 0; i < selectedRows.length; i++) {
            conIds.add(selectedRows[i].Id);
        }

        this.selectedRecords = Array.from(conIds);
    }


    deleteAccounts() {
        if (this.selectedRecords) {
            this.buttonLabel = 'Processing....';
            this.isTrue = true;

            this.deleteCons();
        }
    }


    deleteCons() {
        delSelectedCons({lstConIds: this.selectedRecords})
        .then(result => {
            window.console.log('result ====> ' + result);

            this.buttonLabel = 'Delete';
            this.isTrue = false;

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!', 
                    message: this.recordsCount + ' Contacts are deleted.', 
                    variant: 'success'
                }),
            );
            
            this.template.querySelector('lightning-datatable').selectedRows = [];

            this.recordsCount = 0;

            return refreshApex(this.refreshTable);

        })
        .catch(error => {
            window.console.log(error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error while getting Contacts', 
                    message: error.message, 
                    variant: 'error'
                }),
            );
            this.buttonLabel = 'Delete';
            this.isTrue = false;
        });
    }  

}