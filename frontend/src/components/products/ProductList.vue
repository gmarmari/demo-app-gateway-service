<template>
    <product-details v-if="mode == 'DETAILS'" :details="productDetails" @onEditProduct="editProduct"
        @onDeleteProduct="deleteProduct"></product-details>
    <product-edit v-else-if="mode == 'EDIT'" :details="productDetails" @onSaveProduct="saveProduct"></product-edit>
    <div v-else>
        <base-button @click="addProduct()">Add</base-button>
        <ul>
            <product-basic-info v-for="p in products" :key="p.id" :product="p" @onSelectProduct="showProductDetails">
            </product-basic-info>
        </ul>
        <p class="center" v-if="products.length === 0">No products</p>
    </div>

    <alert-dialog v-if="showAlert" :title="allertTitle" :message="allertMessage"
        @onCloseAlertDialog="closeAlert"></alert-dialog>
</template>

<script>
import ProductBasicInfo from './ProductBasicInfo.vue';
import ProductDetails from './ProductDetails.vue';
import ProductEdit from './ProductEdit.vue';

export default {

    components: {
        ProductBasicInfo,
        ProductDetails,
        ProductEdit
    },

    data() {
        return {
            products: [],
            productDetails: null,

            showAlert: false,
            allertTitle: 'An error occured',
            allertMessage: '',

            mode: 'LIST'
        }
    },

    methods: {
        loadProducts() {
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
                    this.showAlert = true;
                    this.allertTitle = 'An error occured';
                    this.allertMessage = error.message;
                });
        },

        showProductDetails(product) {
            this.showAlert = false;
            fetch('/products/' + product.id + "/details")
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .then((data) => {
                    this.productDetails = data;
                    this.mode = 'DETAILS';
                })
                .catch((error) => {
                    this.showAlert = true;
                    this.allertTitle = 'An error occured';
                    this.allertMessage = error.message;
                });
        },

        saveProduct(details) {
            this.showAlert = false;
            fetch('/products/', {
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
                        this.allertMessage = 'Product was saved';
                        this.mode = 'LIST';
                        this.loadProducts();
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

        deleteProduct(details) {
            this.showAlert = false;
            fetch('/products/' + details.product.id, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                },
            })
                .then((response) => {
                    if (response.ok) {
                        this.showAlert = true;
                        this.allertMessage = 'Success';
                        this.allertMessage = 'Product was deleted';
                        this.mode = 'LIST';
                        this.loadProducts();
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

        editProduct(details) {
            this.productDetails = details;
            this.mode = 'EDIT';
        },

        addProduct() {
            this.productDetails = {
                product: {
                    id: 0,
                    name: "",
                    amount: 1,
                    prize: {
                        amount: 1,
                        unit: "EURO"
                    }
                },
                info: {
                    id: 0,
                    productId: 0,
                    size: {
                        amount: 0,
                        unit: "NONE"
                    },
                    countryOfOrigin: "",
                    description: ""
                },
                contact: {
                    id: 0,
                    productId: 0,
                    name: "",
                    address: "",
                    tel: "",
                    email: "",
                    website: ""
                }
            };
            this.mode = 'EDIT';
        },

        closeAlert() {
            this.showAlert = false;
        }

    },

    mounted() {
        this.loadProducts();
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
}

p.center {
    max-width: 40rem;
    margin: auto;
    text-align: center;
}
</style>