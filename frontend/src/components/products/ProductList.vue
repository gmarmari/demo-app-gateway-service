<template>
    <ul>
        <product-basic-info v-for="p in products" :key="p.id" :id="p.id" :name="p.name" :prize="p.prize">
        </product-basic-info>
    </ul>
    <p class="center" v-if="products.length === 0">No products</p>
    <alert-dialog v-if="error != null" :title="'An error occured'" :message="error.message" @onCloseAlertDialog="closeErrorAlert"></alert-dialog>
</template>

<script>
import ProductBasicInfo from './ProductBasicInfo.vue';

export default {

    components: {
        ProductBasicInfo
    },

    data() {
        return {
            products: [],
            error: null
        }
    },

    methods: {
        loadProducts() {

            this.error = null;
            fetch('/products')
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .then((data) => {
                    this.products = data;
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
        this.loadProducts();
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