<template>
    <base-card>
        <header>
            <h3 v-if="address.type == 'SHIPPING'">Shipping address</h3>
            <h3 v-else-if="address.type == 'BILLING'">Billing address</h3>
        </header>
        <p>{{ address.name }}</p>
        <p>{{ address.street }} {{ address.postalCode }} {{ address.city }}</p>
        <p v-if="address.state != null">{{ address.state }} {{ address.country }}</p>
        <p v-else>{{ address.country }}</p>
        <p v-if="address.tel != null">Tel: {{ address.tel }}</p>
    </base-card>
</template>

<script>
export default {

    props: ['address'],
    
}
</script>