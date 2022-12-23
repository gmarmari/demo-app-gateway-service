<template>
    <li>
      <base-card>
        <header class="flexSpaceBetween">
          <h3>{{ name }}</h3>
          <p>{{ creationDate }}</p>
        </header>
        <div class="flexSpaceBetween">
          <p>{{ prize.amount }} {{ prize.unit }}</p>
          <p>{{ status }}</p>
        </div>
      </base-card>
    </li>
</template>

<script>
export default {

  props: ['id', 'name', 'creationDate', 'prize', 'status']


}
</script>


<style scoped>
li {
  margin: auto;
  max-width: 40rem;
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

