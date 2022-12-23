<template>
  <ul>
      <the-header title="Spring Cloud Demo App"></the-header>
      <the-menu></the-menu>
  </ul>
</template>

<script>

import TheHeader from './components/TheHeader.vue';
import TheMenu from './components/TheMenu.vue';


export default {
  components: {
    TheHeader,
    TheMenu
  }
}
</script>

<style>

* {
  box-sizing: border-box;
}

html {
  font-family: 'Roboto', sans-serif;
}

body {
  margin: 0;
}

</style>