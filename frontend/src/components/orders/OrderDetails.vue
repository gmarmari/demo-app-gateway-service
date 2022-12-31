<template>
    <header>
        <h2>Order</h2>
        <div>
            <base-button v-if="allowEdit" @click="emitOnEditOrder" mode="flat">Edit</base-button>
            <base-button v-if="allowDelete" @click="emitOnDeleteOrder" mode="flat">Delete</base-button>
        </div>
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
    <order-address v-for="a in details.addresses" :key="a.id" :address="a"></order-address>

    <header>
        <h2>Products</h2>
    </header>
    <order-product v-for="p in details.products" :key="p.productId" :productId="p.productId" :amount="p.amount">
    </order-product>

</template>


<script>
import OrderProduct from './OrderProduct.vue'
import OrderAddress from './OrderAddress.vue'

export default {

    components: {
        OrderProduct,
        OrderAddress
    },

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
</style>

