<template>
    <form @submit.prevent="emitSavePaymentMethod">
        <div class="form-control">
            <label for="type">Type</label>
            <select id="type" name="type" v-model="mPaymentMethod.type">
                <option value="CREDIT_CARD">Credit Card</option>
                <option value="PAYPAL">Paypal</option>
                <option value="CASH_ON_DELIVERY">Cash on delivery</option>
            </select>
        </div>
        <div v-if="isText1Available" class="form-control" :class="{ invalid: text1Validity === 'invalid' }">
            <label for="text1">{{ text1Label }}</label>
            <input id="text1" name="text1" type="text" v-model.trim="mPaymentMethod.text1" @blur="validateText1" />
            <p v-if="text1Validity === 'invalid'">Please enter valid input!</p>
        </div>
        <div v-if="isText2Available" class="form-control" :class="{ invalid: text2Validity === 'invalid' }">
            <label for="text2">{{ text2Label }}</label>
            <input id="text2" name="text2" type="text" v-model.trim="mPaymentMethod.text2" @blur="validateText2" />
            <p v-if="text2Validity === 'invalid'">Please enter valid input!</p>
        </div>
        <div class="form-control">
            <button v-if="isSaveEnabled">Save Data</button>
        </div>
    </form>

</template>


<script>

export default {

    props: ['paymentMethod'],

    emits: ['onSavePaymentMethod'],

    data() {
        return {
            mPaymentMethod: this.paymentMethod,
            text1Validity: 'pending',
            text2Validity: 'pending'
        }
    },

    computed: {

        isText1Available() {
            return this.mPaymentMethod.type === 'CREDIT_CARD'
                || this.mPaymentMethod.type === 'PAYPAL';
        },

        isText2Available() {
            return this.mPaymentMethod.type === 'CREDIT_CARD';
        },

        text1Label() {
            if (this.mPaymentMethod.type === 'CREDIT_CARD') {
                return "Number";
            } else if (this.mPaymentMethod.type === 'PAYPAL') {
                return "E-Mail";
            } else {
                return "";
            }
        },

        text2Label() {
            if (this.mPaymentMethod.type === 'CREDIT_CARD') {
                return "Valid until";
            } else {
                return "";
            }
        },

        isSaveEnabled() {
            return this.isText1Valid()
                && this.isText2Valid();
        }
    },

    methods: {

        isText1Valid() {
            if (this.mPaymentMethod.type === 'CREDIT_CARD'
            || this.mPaymentMethod.type === 'PAYPAL') {
                return this.mPaymentMethod.text1.length > 0 && this.mPaymentMethod.text1.length <= 100;
            } else {
                this.mPaymentMethod.text1 = null;
                return true;
            }
        },

        isText2Valid() {
            if (this.mPaymentMethod.type === 'CREDIT_CARD') {
                return this.mPaymentMethod.text2.length > 0 && this.mPaymentMethod.text2.length <= 100;
            } else {
                this.mPaymentMethod.text2 = null;
                return true;
            }
        },

        validateText1() {
            if (this.isText1Valid()) {
                this.text1Validity = 'valid';
            } else {
                this.text1Validity = 'invalid';
            }
        },

        validateText2() {
            if (this.isText2Valid()) {
                this.text2Validity = 'valid';
            } else {
                this.text2Validity = 'invalid';
            }
        },

        emitSavePaymentMethod() {
            this.$emit('onSavePaymentMethod', this.mPaymentMethod);
        }

    }


}
</script>
