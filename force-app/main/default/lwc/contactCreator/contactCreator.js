import { LightningElement,api,track,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const COLUMNS = [
    { label: 'FirstName', fieldName: FIRSTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'LastName', fieldName: LASTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: EMAIL_FIELD.fieldApiName, type: 'text' }
];

export default class ContactCreator extends LightningElement {
    @api recordId;
    @api objectApiName = CONTACT_OBJECT;
    @track fields = [FIRSTNAME_FIELD, LASTNAME_FIELD, EMAIL_FIELD];

    columns = COLUMNS;
    @wire(getContacts)
    contacts;

    handleSuccess(event){
        
        const toastEvent = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }

}