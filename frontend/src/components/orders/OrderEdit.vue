<template>

    <header class="flexSpaceBetween">
        <h2>Order</h2>
        <base-button @click="emitSaveOrder" mode="flat">Save</base-button>
    </header>

    <base-card>
        <div class="form-control" :class="{ invalid: nameValidity === 'invalid' }">
            <input id="name" name="name" type="text" v-model.trim="mDetails.order.name" @blur="validateName" />
            <p v-if="nameValidity === 'invalid'">Please enter a valid name!</p>
        </div>
    </base-card>

    <header>
        <h2>Products</h2>
        <base-button @click="showAddProductDialog" mode="flat">Add</base-button>
    </header>
    <order-product v-for="p in mDetails.products" :key="p.productId" :productId="p.productId" :amount="p.amount"
        editMode="true" @onProductLoaded="productLoaded" @onAmountChange="productAmountChanged"
        @onDeleteProduct="productDeleted"></order-product>
    <base-card v-if="!isAnyProduct">
        <div class="form-control invalid">
            <p>No products</p>
        </div>
    </base-card>

    <header>
        <h2>Total Prize</h2>
    </header>
    <base-card>
        <p> {{ mDetails.order.prize.amount }} {{ mDetails.order.prize.unit }}</p>
        <p> Delivery fee: {{ mDetails.order.deliveryFee.amount }} {{ mDetails.order.deliveryFee.unit }}</p>
    </base-card>

    <header>
        <h2>Payment method</h2>
    </header>
    <order-payment-method :initialPaymentMethod="mDetails.order.paymentMethod"
        @onSelectPaymentMethodType="paymentMethodSelected"></order-payment-method>
    <base-card v-if="!isAnyPaymentMethod">
        <div class="form-control invalid">
            <p>Please configure some payment methods on your profile.</p>
        </div>
    </base-card>

    <header>
        <h2>Addresses</h2>
    </header>
    <order-address v-for="a in mDetails.addresses" :key="a.id" :address="a"></order-address>
    <base-card v-if="!isAnyAddress">
        <div class="form-control invalid">
            <p>Please configure the shipping and billing address on your profile.</p>
        </div>
    </base-card>

    <order-add-product-dialog v-if="isProductAddDialogOn" @onAddProduct="addProduct"
        @onCancel="cancelProductAddDialog"></order-add-product-dialog>


</template>


<script>

import OrderAddress from './OrderAddress.vue'
import OrderPaymentMethod from './OrderPaymentMethod.vue'
import OrderProduct from './OrderProduct.vue'
import OrderAddProductDialog from './OrderAddProductDialog.vue'

export default {

    props: ['details'],

    emits: ['onSaveOrder'],

    components: {
        OrderAddress,
        OrderPaymentMethod,
        OrderProduct,
        OrderAddProductDialog
    },

    data() {
        return {
            mDetails: this.details,

            productMap: new Map(),

            availablePaymentMethods: [],

            nameValidity: 'pending',

            isProductAddDialogOn: false
        }
    },

    computed: {

        isOrderOk() {
            return this.isNameValid()
                && this.isAnyAddress
                && this.isAnyPaymentMethod
                && this.isAnyProduct;
        },

        isAnyProduct() {
            return this.mDetails.products.length > 0;
        },

        isAnyAddress() {
            return this.mDetails.addresses.length > 0;
        },

        isAnyPaymentMethod() {
            return this.mDetails.order.paymentMethod !== null && this.mDetails.order.paymentMethod.length > 0;
        },
    },

    methods: {

        isNameValid() {
            return this.mDetails.order.name.length > 0 && this.mDetails.order.name.length <= 100;
        },

        validateName() {
            if (this.isNameValid()) {
                this.nameValidity = 'valid';
            } else {
                this.nameValidity = 'invalid';
            }
        },

        paymentMethodSelected(paymentMethod) {
            this.mDetails.order.paymentMethod = paymentMethod;
        },

        loadAddressesFromProfile() {
            fetch('/profile/addresses')
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    }
                }).then((data) => {
                    for (let i = 0; i < data.length; i++) {
                        this.mDetails.addresses.push(
                            {
                                id: 0,
                                orderId: 0,
                                type: data[i].type,
                                name: data[i].name,
                                street: data[i].street,
                                postalCode: data[i].postalCode,
                                city: data[i].city,
                                state: data[i].state,
                                country: data[i].country,
                                tel: data[i].tel
                            }
                        );
                    }
                })
        },


        productLoaded(product) {
            this.productMap.set(product.id, product);

            this.updateTotalPrize();
        },

        productAmountChanged(product, amount) {
            this.mDetails.products.find(p => p.productId === product.id).amount = amount;
            this.updateTotalPrize();
        },

        productDeleted(product) {
            const index = this.mDetails.products.findIndex(p => p.productId === product.id);

            this.mDetails.products.splice(index, 1);
            this.productMap.delete(product.id);

            this.updateTotalPrize();
        },

        showAddProductDialog() {
            this.isProductAddDialogOn = true;
        },

        addProduct(product) {
            this.isProductAddDialogOn = false;

            if (this.productMap.has(product.id)) {
                // Product is allready in the list
                return;
            }

            this.mDetails.products.push(
                {
                    productId: product.id,
                    amount: 1
                }
            );
            this.productMap.set(product.id, product);
        },

        cancelProductAddDialog() {
            this.isProductAddDialogOn = false;
        },

        updateTotalPrize() {
            var totalPrize = 0;
            for (let i = 0; i < this.mDetails.products.length; i++) {
                const p = this.mDetails.products[i];
                const productId = p.productId;
                const amount = p.amount;

                const product = this.productMap.get(productId);
                if (product !== null) {
                    const prize = product.prize.amount;
                    totalPrize += (prize * amount);
                }
            }
            this.mDetails.order.prize.amount = totalPrize;

            if (totalPrize >= 50) {
                // Free delivery when order cost more than 50 (Euro) ! :P
                this.mDetails.order.deliveryFee.amount = 0;
            } else {
                this.mDetails.order.deliveryFee.amount = 5;
            }
        },

        emitSaveOrder() {
            if (this.isOrderOk) {
                this.$emit('onSaveOrder', this.mDetails);
            }
        }

    },

    mounted() {
        if (this.mDetails.addresses.length == 0) {
            this.loadAddressesFromProfile();
        }
    }




}
</script>

<style scoped>
header {
    margin: auto;
    max-width: 40rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
</style>