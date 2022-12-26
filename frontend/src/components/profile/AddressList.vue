<template>
    <address-edit v-if="editMode" :address="address" @onSaveAddress="saveAddress">

    </address-edit>
    <div v-else>
        <base-button @click="addAddress()">Add</base-button>
        <ul>
            <address-details v-for="a in addresses" :key="a.id" :address="a" @editAddress="editAddress"
                @deleteAddress="deleteAddress">
            </address-details>
        </ul>
        <p class="center" v-if="addresses.length === 0">No Addresses</p>
    </div>


    <alert-dialog v-if="error != null" :title="'An error occured'" :message="error.message"
        @onCloseAlertDialog="closeErrorAlert"></alert-dialog>

    <alert-dialog v-if="saveFinished" :title="'OK'" :message="'Address was saved!'"
        @onCloseAlertDialog="closeSaveAlert"></alert-dialog>

        <alert-dialog v-if="deleteFinished" :title="'OK'" :message="'Address was deleted!'"
        @onCloseAlertDialog="closeDeleteAlert"></alert-dialog>
</template>


<script>
import AddressDetails from './AddressDetails.vue';
import AddressEdit from './AddressEdit.vue';

export default {

    components: {
        AddressDetails,
        AddressEdit
    },

    data() {
        return {
            addresses: [],
            error: null,
            editMode: false,
            saveFinished: false,
            deleteFinished: false,

            address: {
                id: 0,
                type: 'BILLING',
                name: '',
                street: '',
                postalCode: '',
                city: '',
                state: '',
                country: '',
                tel: ''
            },
        }
    },

    methods: {
        loadAddresses() {

            this.error = null;
            fetch('/profile/addresses')
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .then((data) => {
                    this.addresses = data;
                })
                .catch((error) => {
                    this.error = error;
                });
        },

        addAddress() {
            this.editMode = true;
            this.address = {
                id: 0,
                type: 'BILLING',
                name: '',
                street: '',
                postalCode: '',
                city: '',
                state: '',
                country: '',
                tel: ''
            }
        },

        editAddress(address) {
            this.address = address;
            this.editMode = true;
        },


        saveAddress(address) {
            this.error = null;
            this.saveFinished = false;
            fetch('/profile/addresses', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(address),
            })
                .then((response) => {
                    if (response.ok) {
                        this.saveFinished = true;
                        this.editMode = false;
                        this.loadAddresses();
                    } else {
                        throw new Error('Could not save address. Response: ' + response.status + ". Note: only one address for every type is allowed!" );
                    }
                })
                .catch((error) => {
                    this.error = error;
                });
        },


        deleteAddress(address) {
            this.error = null;
            this.deleteFinished = false;
            fetch('/profile/addresses/' + address.id, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(address),
            })
                .then((response) => {
                    if (response.ok) {
                        this.deleteFinished = true;
                        this.loadAddresses();
                    } else {
                        throw new Error('Could not delete address!');
                    }
                })
                .catch((error) => {
                    this.error = error;
                });
        },


        closeErrorAlert() {
            this.error = null;
        },

        closeSaveAlert() {
            this.saveFinished = false;
        },

        closeDeleteAlert() {
            this.deleteFinished = false;
        }

    },

    mounted() {
        this.loadAddresses();
    }



}
</script>

<style scoped>
ul {
    list-style: none;
    margin: 0;
    padding: 0;
    max-width: 40rem;
}

p.center {
    max-width: 40rem;
    margin: auto;
    text-align: center;
}
</style>