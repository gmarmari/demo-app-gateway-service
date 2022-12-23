<template>
    <li>
      <base-card>
        <header>
          <h3>{{ name }}</h3>
          <p>#{{ id }}</p>
        </header>
        <p>{{ prize.amount }} {{ prize.unit }}</p>
      </base-card>
    </li>
</template>


<script>
export default {

  props: ['id', 'name', 'prize']


}
</script>

<style scoped>
li {
  margin: auto;
  max-width: 40rem;
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

