<template>
    <div>
        <ul>
            <li>
                <base-button @click="setSelectedTab('personal-data')" :mode="personalDataButtonMode">Personal
                    data</base-button>
            </li>
            <li>
                <base-button @click="setSelectedTab('address-list')" :mode="addressButtonMode">Addresses</base-button>
            </li>
            <li>
                <base-button @click="setSelectedTab('payment-method-list')" :mode="paymentMethodButtonMode">Payment
                    methods</base-button>
            </li>
        </ul>
        <component class="flexGrow" :is="selectedTab"></component>
    </div>
</template>



<script>

import PersonalData from './PersonalData.vue';
import AddressList from './AddressList.vue';
import PaymentMethodList from './PaymentMethodList.vue';


export default {

    components: {
        PersonalData,
        AddressList,
        PaymentMethodList
    },


    data() {
        return {
            selectedTab: 'personal-data'
        };
    },


    computed: {

        personalDataButtonMode() {
            return this.selectedTab === 'personal-data' ? null : 'flat';
        },

        addressButtonMode() {
            return this.selectedTab === 'address-list' ? null : 'flat';
        },

        paymentMethodButtonMode() {
            return this.selectedTab === 'payment-method-list' ? null : 'flat';
        }
    },

    methods: {

        setSelectedTab(tab) {
            this.selectedTab = tab;
        }


    }

}
</script>


<style scoped>
div {
    display: flex;
    margin: auto;
    max-width: 40rem;
}

ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

.flexGrow {
    flex-grow: 1;
}
</style>