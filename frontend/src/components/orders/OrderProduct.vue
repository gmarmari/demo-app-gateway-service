<template>
    <base-card v-if="isLoading">
        <p>Loading....</p>
    </base-card>
    <base-card v-else>
        <header>
            <h3>{{ product.name }}</h3>
        </header>
        <div v-if="editMode" class="form-control form-control-custom" :class="{ invalid: !isAmountValid }">
            <label for="amount">Amount</label>
            <input id="amount" name="amount" type="number" step="1" v-model.trim="mAmount" @blur="amountChanged" />
            <base-button mode="flat" @click="emitOnDeleteProduct">Delete</base-button>
            <p v-if="!isAmountValid">Please enter a valid amount!</p>
        </div>
        <p v-else>Amount: {{ mAmount }}</p>
        <p>Prize: {{ totalPrize }} {{ product.prize.unit }}</p>
    </base-card>
</template>


<script>

export default {

    props: ['productId', 'amount', 'editMode'],

    emits: ['onProductLoaded', 'onAmountChange', 'onDeleteProduct'],

    data() {
        return {
            product: {
                id: this.productId,
                name: '',
                prize: {
                    amount: 0,
                    unit: 'NONE'
                }
            },

            mAmount: this.amount,

            isLoading: false
        }
    },

    computed: {

        totalPrize() {
            return this.product.prize.amount * this.mAmount;
        },

        isAmountValid() {
            return this.mAmount > 0;
        }

    },


    methods: {

        amountChanged() {
            if (this.isAmountValid) {
                this.$emit('onAmountChange', this.product, this.mAmount);
            }
        },

        emitOnDeleteProduct() {
            this.$emit('onDeleteProduct', this.product);
        },

        loadProduct() {
            this.isLoading = true;
            fetch('/products/' + this.productId)
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    }
                })
                .then((data) => {
                    this.isLoading = false;
                    this.product = data;
                    this.$emit('onProductLoaded', this.product);
                });
        }

    },

    mounted() {
        this.loadProduct();
    }


}
</script>

<style scoped>
header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.form-control-custom>input {
    display: initial !important;
    width: auto !important;
    margin-top: 0 !important;
    margin-right: 0.5rem;
}

.form-control-custom>label {
    font-weight: bold;
    margin-right: 0.5rem;
}
</style>

