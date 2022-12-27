<template>
    <li @click="emitOnSelectProduct">
      <base-card>
        <header>
          <h3>{{ product.name }}</h3>
          <p>#{{ product.id }}</p>
        </header>
        <p>{{ product.prize.amount }} {{ product.prize.unit }}</p>
      </base-card>
    </li>
</template>


<script>
export default {

  props: ['product'],

  emits: ['onSelectProduct'],

  methods: {

    emitOnSelectProduct() {
      this.$emit('onSelectProduct', this.product);
    }

  }


}
</script>

<style scoped>
li {
  margin: auto;
  max-width: 40rem;
  cursor: pointer;
}

header {
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

