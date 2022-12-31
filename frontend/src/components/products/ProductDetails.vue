<template>

    <base-card>
        <header>
            <h3>Details</h3>
        </header>
        <p>{{ details.product.name }}</p>
        <p>{{ details.product.prize.amount }} {{ details.product.prize.unit }}</p>
        <p>{{ details.info.size.amount }} {{ details.info.size.unit }}</p>
        <p>{{ details.info.countryOfOrigin }}</p>

    </base-card>

    <base-card v-if="details.info.description !== null">
        <header>
            <h3>Description</h3>
        </header>
        <p>{{ details.info.description }}</p>
    </base-card>

    <base-card>
        <header>
            <h3>Contact</h3>
        </header>
        <p>{{ details.contact.name }}</p>
        <p>{{ details.contact.address }}</p>
        <p v-if="details.contact.tel !== null">{{ details.contact.tel }}</p>
        <p v-if="details.contact.email !== null">{{ details.contact.email }}</p>
        <p v-if="details.contact.website !== null">{{ details.contact.website }}</p>
    </base-card>

    <footer>
        <base-button @click="emitOnEditProduct">Edit</base-button>
        <base-button @click="emitOnDeleteProduct">Delete</base-button>
    </footer>

</template>


<script>
export default {

    props: ['details'],

    emits: ['onEditProduct', 'onDeleteProduct'],

    methods: {

        emitOnEditProduct() {
            this.$emit('onEditProduct', this.details);
        },

        emitOnDeleteProduct() {
            this.$emit('onDeleteProduct', this.details);
        }
    }

}
</script>

<style scoped>
header,
footer {
    margin: auto;
    max-width: 40rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

</style>

