<template>
    <base-card v-if="isLoading">
        <p>Loading....</p>
    </base-card>
    <base-card v-else>
        <header>
            <h3>{{ product.name }}</h3>
        </header>
        <p>Amount: {{ amount }}</p>
        <p>Prize: {{ totalPrize }} {{ product.prize.unit }}</p>
    </base-card>
</template>


<script>
export default {

    props: ['productId', 'amount'],

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

            isLoading: false
        }
    },

    computed: {

        totalPrize() {
            return this.product.prize.amount * this.amount;
        }

    },


    methods: {

        emitOnSelectProduct() {
            this.$emit('onSelectProduct', this.product);
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

h3 {
    font-size: 1.25rem;
    margin: 0.5rem 0;
}

p {
    margin: 0.5rem 0;
}
</style>

