<template>
    <header>
        <h2>Order</h2>
    </header>

    <base-card>
        <header>
            <h3>Status</h3>
        </header>
        <p>{{ details.order.name }}</p>
        <p>{{ details.order.status }}</p>
        <p>Created on: {{ details.order.creationDate }}</p>
    </base-card>

    <base-card>
        <header>
            <h3>Prize</h3>
        </header>
        <p>Prize: {{ details.order.prize.amount }} {{ details.order.prize.unit }}</p>
        <p v-if="details.order.deliveryDate !== null">Delivery date: {{ details.order.deliveryDate }}</p>
        <p>Delivery fee: {{ details.order.deliveryFee.amount }} {{ details.order.deliveryFee.unit }}</p>
        <p>Payment method: {{ details.order.paymentMethod }}</p>
    </base-card>


    <header>
        <h2>Addresses</h2>
    </header>
    <base-card v-for="a in details.addresses" :key="a.id">
        <header>
            <h3 v-if="a.type == 'SHIPPING'">Shipping address</h3>
            <h3 v-else-if="a.type == 'BILLING'">Billing address</h3>
        </header>
        <p>{{ a.name }}</p>
        <p>{{ a.street }} {{ a.postalCode }} {{ a.city }}</p>
        <p v-if="a.state != null">{{ a.state }} {{ a.country }}</p>
        <p v-else>{{ a.country }}</p>
        <p v-if="a.tel != null">Tel: {{ a.tel }}</p>
    </base-card>

    <header>
        <h2>Products</h2>
    </header>
    <order-product v-for="p in details.products" :key="p.productId" :productId="p.productId" :amount="p.amount">
    </order-product>

    <footer>
        <base-button v-if="allowEdit" @click="emitOnEditOrder">Edit</base-button>
        <base-button v-if="allowDelete" @click="emitOnDeleteOrder">Delete</base-button>
    </footer>

</template>


<script>
import OrderProduct from './OrderProduct.vue'

export default {

    components: { OrderProduct },

    props: ['details'],

    emits: ['onEditOrder', 'onDeleteOrder'],

    computed: {

        allowEdit() {
            return this.details.order.status == 'SUBMITTED'
        },

        allowDelete() {
            return this.details.order.status == 'SUBMITTED'
        }

    },

    methods: {

        emitOnEditOrder() {
            if (this.allowEdit) {
                this.$emit('onEditOrder', this.details);
            }
        },

        emitOnDeleteOrder() {
            if (this.allowDelete) {
                this.$emit('onDeleteOrder', this.details);
            }
        }

    },

}
</script>

<style scoped>
header,
footer {
    margin: auto;
    max-width: 40rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

h2 {
    font-size: 1.5rem;
    margin: 0.5rem 0;
}

h3 {
    font-size: 1.25rem;
    margin: 0.5rem 0;
}

p {
    margin: 0.5rem 0;
}
</style>

