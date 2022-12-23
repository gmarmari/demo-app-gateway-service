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
    <teleport to="body">
            <error-alert v-if="error !== null">
                <h2>Error!</h2>
                <p>Error occurred: {{ error.message }}</p>
                <button @click="closeErrorAlert">OK</button>
            </error-alert>
        </teleport>
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