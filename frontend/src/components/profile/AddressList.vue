<template>
    <ul>
        <address-details v-for="a in addresses" 
        :key="a.id" 
        :address="a" 
        @editAddress="editAddress"
        @deleteAddress="deleteAddress">
        </address-details>
    </ul>
    <p class="center" v-if="addresses.length === 0">No Addresses</p>
    <alert-dialog v-if="error != null" :title="'An error occured'" :message="error.message" @onCloseAlertDialog="closeErrorAlert"></alert-dialog>
</template>


<script>
import AddressDetails from './AddressDetails.vue';

export default {

    components: {
        AddressDetails
    },

    data() {
        return {
            addresses: [],
            error: null
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

        editAddress(address) {
            if (address != null) {
                // TODO
            }
        },


        deleteAddress(address) {
            if (address != null) {
                // TODO
            }
        },


        closeErrorAlert() {
            this.error = null;
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