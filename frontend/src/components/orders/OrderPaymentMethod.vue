<template>
    <base-card>
        <header>
            <div class="form-control">
                <select id="paymentMethodSelect" v-model="paymentMethodType" @change="onPaymentMethodChange()" >
                    <option v-for="p in availablePaymentMethods" :key="p.id" :value="p.type">{{ p.type }}</option>
                </select>
            </div>
        </header>
        <p v-if="paymentMethodText1 !== null">{{ paymentMethodText1 }}</p>
        <p v-if="paymentMethodText2 !== null">{{ paymentMethodText2 }}</p>
    </base-card>
</template>


<script>
export default {

    props: ['initialPaymentMethod'],

    emits: ['onSelectPaymentMethodType'],

    data() {
        return {
            availablePaymentMethods: [],

            paymentMethodType : this.initialPaymentMethod,
            paymentMethodText1 : null,
            paymentMethodText2 : null,
        }
    },

    methods: {

        loadPaymentMethodsFromProfile() {
            fetch('/profile/payment-methods')
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    }
                }).then((data) => {
                    this.availablePaymentMethods = data;
                    if (this.availablePaymentMethods.length > 0) {

                        // Check if initialPaymentMethod is valid
                        if (this.availablePaymentMethods.find(p => p.type === this.initialPaymentMethod) === null) {
                            // If not valid, then hen select the first one
                            this.paymentMethodType = data[0].type;
                        }

                        this.loadPaymentMethodTexts();

                       
                    }
                })
        },

        loadPaymentMethodTexts() {
            const paymentMethod  = this.availablePaymentMethods.find(p => p.type === this.paymentMethodType);
            this.paymentMethodText1 = paymentMethod.text1;
            this.paymentMethodText2 = paymentMethod.text2;
        },


        onPaymentMethodChange() {
            this.loadPaymentMethodTexts();
            this.$emit('onSelectPaymentMethodType', this.paymentMethodType);
        },

    },

    mounted() {
        this.loadPaymentMethodsFromProfile();
    }

}
</script>

<style scoped>
header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
</style>

