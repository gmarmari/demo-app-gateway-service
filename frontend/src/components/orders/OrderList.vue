<template>
    <ul>
        <order-basic-info v-for="o in orders" 
        :key="o.id" 
        :id="o.id" 
        :name="o.name" 
        :creationDate="o.creationDate" 
        :prize="o.prize"
        :status="o.status">
        </order-basic-info>
    </ul>
    <p class="center" v-if="orders.length === 0">No Orders</p>
    <alert-dialog v-if="error != null" :title="'An error occured'" :message="error.message" @onCloseAlertDialog="closeErrorAlert"></alert-dialog>
</template>


<script>
import OrderBasicInfo from './OrderBasicInfo.vue';

export default {

    components: {
        OrderBasicInfo
    },

    data() {
        return {
            orders: [],
            error: null
        }
    },

    methods: {
        loadOrders() {

            this.error = null;
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
                    this.error = error;
                });
        },


        closeErrorAlert() {
            this.error = null;
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