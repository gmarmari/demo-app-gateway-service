<template>
    <order-details v-if="mode === 'DETAILS'" :details="orderDetails" @onEditOrder="editOrder"
        @onDeleteOrder="deleteOrder"></order-details>
    <order-edit v-else-if="mode === 'EDIT'" :details="orderDetails" @onSaveOrder="saveOrder"></order-edit>
    <div v-else>
        <base-button @click="addOrder()">Add</base-button>
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
import OrderEdit from './OrderEdit.vue';

export default {

    components: {
        OrderBasicInfo,
        OrderDetails,
        OrderEdit
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


        saveOrder(details) {
            console.log("SAVE ORDER!!!");
            this.showAlert = false;
            fetch('/orders/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(details),
            })
                .then((response) => {
                    if (response.ok) {
                        this.showAlert = true;
                        this.allertTitle = 'Success';
                        this.allertMessage = 'Order was saved';
                        this.mode = 'LIST';
                        this.loadOrders();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .catch((error) => {
                    this.showAlert = true;
                    this.allertTitle = 'An error occured';
                    this.allertMessage = error.message;
                });

        },

        editOrder(details) {
            this.orderDetails = details;
            this.mode = 'EDIT';
        },

        deleteOrder(details) {
            this.showAlert = false;
            fetch('/orders/' + details.order.id, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                },
            })
                .then((response) => {
                    if (response.ok) {
                        this.showAlert = true;
                        this.allertTitle = 'Success';
                        this.allertMessage = 'Order was deleted';
                        this.mode = 'LIST';
                        this.loadOrders();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .catch((error) => {
                    this.showAlert = true;
                    this.allertTitle = 'An error occured';
                    this.allertMessage = error.message;
                });
        },

        addOrder() {
            this.orderDetails = {
                order: {
                    id: 0,
                    name: "My order on " + new Date().toLocaleDateString(),
                    creationDate: new Date(),
                    deliveryDate: null,
                    status: "SUBMITTED",
                    paymentMethod: null,
                    prize: {
                        amount: 0,
                        unit: "EURO"
                    },
                    deliveryFee: {
                        amount: 0,
                        unit: "EURO"
                    }
                },
                addresses: [],
                products: []
            }
            this.mode = 'EDIT';
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
div {
    margin: auto;
    max-width: 40rem;
}

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