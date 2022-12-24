<template>
    <base-card>
        <base-button @click="setSelectedTab('order-list')"
        :mode="ordersButtonMode">Orders</base-button>
        <base-button @click="setSelectedTab('product-list')"
        :mode="productsButtonMode">Products</base-button>
        <base-button @click="setSelectedTab('profile-details')"
        :mode="profileButtonMode">Profile</base-button>
    </base-card>
    <component :is="selectedTab"></component>
</template>


<script>

import ProductList from './products/ProductList.vue';
import OrderList from './orders/OrderList.vue';
import ProfileDetails from './profile/ProfileDetails.vue';

export default {

    components : {
        ProductList,
        OrderList,
        ProfileDetails
    },


    data() {
        return {
            selectedTab: 'order-list'
        };
    },


    computed: {

        ordersButtonMode() {
            return this.selectedTab === 'order-list' ? null : 'flat';
        },

        productsButtonMode() {
            return this.selectedTab === 'product-list' ? null : 'flat';
        },

        profileButtonMode() {
            return this.selectedTab === 'profile-details' ? null : 'flat';
        }
    },

    methods: {

        setSelectedTab(tab) {
            this.selectedTab = tab;
        }

    
    }

}
</script>