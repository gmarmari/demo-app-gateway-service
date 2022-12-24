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

form {
    max-width: 40rem;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26);
    padding: 2rem;
    background-color: #ffffff;
}

.form-control {
    margin: 0.5rem 0;
}

.form-control.invalid input {
    border-color: red;
}

.form-control.invalid label {
    color: red;
}

.form-control > button {
  padding: 0.75rem 1.5rem;
  font-family: inherit;
  background-color: #3a0061;
  border: 1px solid #3a0061;
  color: white;
  cursor: pointer;
}

.form-control > button:hover,
.form-control > button:active {
  color: #3a0061;
  background-color: #edd2ff;
  border-color: #edd2ff;
}


.form-control > label {
    font-weight: bold;
}

.form-control > input,
.form-control > select {
    display: block;
    width: 100%;
    font: inherit;
    margin-top: 0.5rem;
}

.form-control > select {
    width: auto;
}

.form-control > input[type='checkbox'],
.form-control > input[type='radio'] {
    display: inline-block;
    width: auto;
    margin-right: 1rem;
}

.form-control > input[type='checkbox']+label,
.form-control > input[type='radio']+label {
    font-weight: normal;
}

</style>