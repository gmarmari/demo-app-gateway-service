<template>
    <payment-method-edit v-if="editMode" :paymentMethod="paymentMethod" @onSavePaymentMethod="savePaymentMethod">
    </payment-method-edit>
    <div v-else>
        <base-button @click="addPaymentMethod()">Add</base-button>
        <ul>
            <payment-method-details v-for="p in paymentMethods" :key="p.id" :paymentMethod="p" @editPaymentMethod="editPaymentMethod"
                @deletePaymentMethod="deletePaymentMethod">
            </payment-method-details >
        </ul>
        <p class="center" v-if="paymentMethods.length === 0">No payment methods</p>
    </div>

    <alert-dialog v-if="error != null" :title="'An error occured'" :message="error.message"
        @onCloseAlertDialog="closeErrorAlert"></alert-dialog>

    <alert-dialog v-if="saveFinished" :title="'OK'" :message="'Payment method was saved!'"
        @onCloseAlertDialog="closeSaveAlert"></alert-dialog>

        <alert-dialog v-if="deleteFinished" :title="'OK'" :message="'Payment method was deleted!'"
        @onCloseAlertDialog="closeDeleteAlert"></alert-dialog>
</template>


<script>
import PaymentMethodDetails from './PaymentMethodDetails.vue';
import PaymentMethodEdit from './PaymentMethodEdit.vue';

export default {

    components: {
        PaymentMethodDetails,
        PaymentMethodEdit
    },

    data() {
        return {
            paymentMethods: [],
            error: null,
            editMode: false,
            saveFinished: false,
            deleteFinished: false,

            paymentMethod: {
                id: 0,
                type: 'CREDIT_CARD',
                text1: '',
                text2: ''
            },
        }
    },

    methods: {
        loadPaymentMethods() {

            this.error = null;
            fetch('/profile/payment-methods')
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .then((data) => {
                    this.paymentMethods = data;
                })
                .catch((error) => {
                    this.error = error;
                });
        },

        addPaymentMethod() {
            this.paymentMethod = {
                id: 0,
                type: 'CREDIT_CARD',
                text1: '',
                text2: ''
            };
            this.editMode = true;
        },

        editPaymentMethod(paymentMethod) {
            this.paymentMethod = paymentMethod;
            this.editMode = true;
        },


        savePaymentMethod(paymentMethod) {
            this.error = null;
            this.saveFinished = false;
            fetch('/profile/payment-methods', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(paymentMethod),
            })
                .then((response) => {
                    if (response.ok) {
                        this.saveFinished = true;
                        this.editMode = false;
                        this.loadPaymentMethods();
                    } else {
                        throw new Error('Could not save payment method. Response: ' + response.status + ". Note: every payment method type can olny exists once.");
                    }
                })
                .catch((error) => {
                    this.error = error;
                });
        },


        deletePaymentMethod(paymentMethod) {
            this.error = null;
            this.deleteFinished = false;
            fetch('/profile/payment-methods/' + paymentMethod.id, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(paymentMethod),
            })
                .then((response) => {
                    if (response.ok) {
                        this.deleteFinished = true;
                        this.loadPaymentMethods();
                    } else {
                        throw new Error('Could not delete payment method!');
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
        this.loadPaymentMethods();
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