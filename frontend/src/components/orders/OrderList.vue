<template>
    <order-details v-if="mode == 'DETAILS'" :details="orderDetails" @onEditOrder="editOrder" @onDeleteOrder="deleteOrder"></order-details>
    <div v-else>
        <ul>
            <order-basic-info v-for="o in orders" :key="o.id" :order="o" @onSelectOrder="showOrderDetails">
            </order-basic-info>
        </ul>
        <p class="center" v-if="orders.length === 0">No Orders</p>
    </div>
    <alert-dialog v-if="showAlert" :title="allertTitle" :message="allertMessage"
        @onCloseAlertDialog="closeAlert"></alert-dialog>
</template>


<script>
import OrderBasicInfo from './OrderBasicInfo.vue';
import OrderDetails from './OrderDetails.vue';

export default {

    components: {
        OrderBasicInfo,
        OrderDetails
    },

    data() {
        return {
            orders: [],
            orderDetails: null,

            showAlert: false,
            allertTitle: 'An error occured',
            allertMessage: '',

            mode: 'LIST'
        }
    },

    methods: {
        loadOrders() {

            this.showAlert = false;
            fetch('/orders')
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .then((data) => {
                    this.orders = data;
                })
                .catch((error) => {
                    this.showAlert = true;
                    this.allertTitle = 'An error occured';
                    this.allertMessage = error.message;
                });
        },

        showOrderDetails(order) {
            this.showAlert = false;
            fetch('/orders/' + order.id + "/details")
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .then((data) => {
                    this.orderDetails = data;
                    this.mode = 'DETAILS';
                })
                .catch((error) => {
                    this.showAlert = true;
                    this.allertTitle = 'An error occured';
                    this.allertMessage = error.message;
                });
        },

        editOrder(details) {
            if (details != null) {
                // TODO:
            }
        },

        deleteOrder(details) {
            if (details != null) {
                // TODO:
            }
        },

        closeAlert() {
            this.showAlert = false;
        }

    },

    mounted() {
        this.loadOrders();
    }



}
</script>

<style scoped>
ul {
    list-style: none;
    margin: 0;
    padding: 0;
    margin: auto;
    max-width: 40rem;
}

p.center {
    max-width: 40rem;
    margin: auto;
    text-align: center;
}
</style>