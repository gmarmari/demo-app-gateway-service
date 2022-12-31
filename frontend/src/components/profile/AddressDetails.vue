<template>
    <li>
      <base-card>
        <header>
          <h3>{{ address.name }}</h3>
        </header>
        <p>{{ combineStreetPostalCodeAndCity }}</p>
        <p v-if="address.state !== null || address.country !== null">{{ combineStateAndCountry }}</p>
        <p>{{ address.type }}</p>
        <footer>
            <base-button @click="emitEditAddress">Edit</base-button>
            <base-button @click="emitDeleteAddress">Delete</base-button>
        </footer>
      </base-card>
    </li>
</template>


<script>
export default {

  props: ['address'],

  emits: ['editAddress', 'deleteAddress'],

  computed: {

    combineStreetPostalCodeAndCity() {
        return this.address.street + " " + this.address.postalCode + " " + this.address.city;
    },

    combineStateAndCountry() {
        var text = "";
        if (this.address.state != null) {
            text += this.address.state;
            text += " ";
        }
        if (this.address.country != null) {
            text += this.address.country;
        }
        return text;
    }

  }, 

  methods: {


    emitEditAddress() {
      this.$emit('editAddress', this.address);
    },

    emitDeleteAddress() {
      this.$emit('deleteAddress', this.address);
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


</style>

