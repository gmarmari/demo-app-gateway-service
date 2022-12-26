<template>
    <li>
      <base-card>
        <header>
          <h3>{{ paymentMethod.type }}</h3>
        </header>
        <p v-if="paymentMethod.text1 !== null">{{ paymentMethod.text1 }}</p>
        <p v-if="paymentMethod.text2 !== null">{{ paymentMethod.text2 }}</p>
        <footer>
            <base-button @click="emitEditPaymentMethod">Edit</base-button>
            <base-button @click="emitDeletePaymentMethod">Delete</base-button>
        </footer>
      </base-card>
    </li>
</template>


<script>
export default {

  props: ['paymentMethod'],

  emits: ['editPaymentMethod', 'deletePaymentMethod'],

  methods: {

    emitEditPaymentMethod() {
      this.$emit('editPaymentMethod', this.paymentMethod);
    },

    emitDeletePaymentMethod() {
      this.$emit('deletePaymentMethod', this.paymentMethod);
    }
  }

}
</script>

<style scoped>
li {
  margin: auto;
  max-width: 40rem;
}

header,
footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}


h3 {
  font-size: 1.25rem;
  margin: 0.5rem 0;
}

p {
  margin: 0.5rem 0;
}

</style>

