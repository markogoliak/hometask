import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class DeleteListWebComponent extends LightningElement {
    contacts;
    error;
    wiredAccountsResult;

    @wire(getContactList)
    wiredAccounts(result) {
        this.wiredAccountsResult = result;
        if (result.data) {
            this.contacts = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.contacts = undefined;
        }
    }

   deleteContact(event) {
        const recordId = event.target.dataset.recordid;
        deleteRecord(recordId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact deleted',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredAccountsResult);
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting contact',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}