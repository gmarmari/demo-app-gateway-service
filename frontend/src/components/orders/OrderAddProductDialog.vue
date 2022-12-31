<template>
    <teleport to="body">
        <dialog open>
            <div>
                <input id="searchTexm" name="name" type="text" v-model.trim="searchText" />
                <base-button @click="searchProducts" mode="flat">Search</base-button>
                <base-button @click="cancelDialog" mode="flat">Cancel</base-button>
            </div>
            <ul>
                <product-basic-info v-for="p in products" :key="p.id" :product="p" @onSelectProduct="productSelected">
                </product-basic-info>
            </ul>
        </dialog>
    </teleport>
</template>

<script>

import { Teleport } from 'vue';
import ProductBasicInfo from '../products/ProductBasicInfo.vue';

export default {

    components: {
        Teleport,
        ProductBasicInfo
    },

    emits: ['onAddProduct', 'onCancel'],

    data() {
        return {
            products: [],
            searchText: ''
        }
    },

    methods: {


        searchProducts() {
            if (this.searchText.length === 0) {
                return;
            }

            fetch('/products/find-by-name/' + this.searchText)
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    }
                })
                .then((data) => {
                    this.products = data;
                });
        },

        productSelected(product) {
            this.$emit('onAddProduct', product);
        },

        cancelDialog() {
            this.$emit('onCancel');
        }
    }
}
</script>

<style scoped>
dialog {
    margin: 0;
    position: fixed;
    top: 20vh;
    left: 30%;
    width: 40%;
    background-color: white;
    box-shadow: 0 2px 8px rbg(0, 0, 0, 0.26);
    padding: 1rem;
}

ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

</style>