<template>
    <li @click="emitOnSelectOrder">
      <base-card>
        <header class="flexSpaceBetween">
          <h3>{{ order.name }}</h3>
          <p>{{ order.creationDate }}</p>
        </header>
        <div class="flexSpaceBetween">
          <p>{{ order.prize.amount }} {{ order.prize.unit }}</p>
          <p>{{ order.status }}</p>
        </div>
      </base-card>
    </li>
</template>

<script>
export default {

  props: ['order'],

  emits: ['onSelectOrder'],

  methods: {

    emitOnSelectOrder() {
      this.$emit('onSelectOrder', this.order);
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

.flexSpaceBetween {
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

