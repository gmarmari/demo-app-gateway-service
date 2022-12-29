<template>
    <form @submit.prevent="emitSaveAddress">
        <div class="form-control">
            <label for="type">Type</label>
            <select id="type" name="type" v-model="mAddress.type">
                <option value="BILLING">Billing</option>
                <option value="SHIPPING">Shipping</option>
            </select>
        </div>
        <div class="form-control" :class="{ invalid: nameValidity === 'invalid' }">
            <label for="name">Name</label>
            <input id="name" name="name" type="text" v-model.trim="mAddress.name" @blur="validateName" />
            <p v-if="nameValidity === 'invalid'">Please enter a valid name!</p>
        </div>
        <div class="form-control" :class="{ invalid: streetValidity === 'invalid' }">
            <label for="street">Street</label>
            <input id="street" name="street" type="text" v-model.trim="mAddress.street" @blur="validateStreet" />
            <p v-if="streetValidity === 'invalid'">Please enter a valid street!</p>
        </div>
        <div class="form-control" :class="{ invalid: postalCodeValidity === 'invalid' }">
            <label for="postalCode">Postal Code</label>
            <input id="postalCode" name="postalCode" type="text" v-model.trim="mAddress.postalCode"
                @blur="validatePostalCode" />
            <p v-if="postalCodeValidity === 'invalid'">Please enter a valid postal code!</p>
        </div>
        <div class="form-control" :class="{ invalid: cityValidity === 'invalid' }">
            <label for="city">City</label>
            <input id="city" name="city" type="text" v-model.trim="mAddress.city" @blur="validateCity" />
            <p v-if="cityValidity === 'invalid'">Please enter a valid city!</p>
        </div>
        <div class="form-control" :class="{ invalid: stateValidity === 'invalid' }">
            <label for="state">State</label>
            <input id="state" name="state" type="text" v-model.trim="mAddress.state" @blur="validateState" />
            <p v-if="stateValidity === 'invalid'">Please enter a valid state!</p>
        </div>
        <div class="form-control" :class="{ invalid: countryValidity === 'invalid' }">
            <label for="country">Country</label>
            <input id="country" name="country" type="text" v-model.trim="mAddress.country" @blur="validateCountry" />
            <p v-if="countryValidity === 'invalid'">Please enter a valid country!</p>
        </div>
        <div class="form-control" :class="{ invalid: telValidity === 'invalid' }">
            <label for="tel">Tel</label>
            <input id="tel" name="tel" type="tel" v-model.trim="mAddress.tel" @blur="validateTel" />
            <p v-if="telValidity === 'invalid'">Please enter a valid tel!</p>
        </div>
        <div class="form-control">
            <button v-if="isSaveEnabled">Save Data</button>
        </div>
    </form>

</template>


<script>

export default {

    props: ['address'],

    emits: ['onSaveAddress'],

    data() {
        return {
            mAddress: this.address,
            nameValidity: 'pending',
            streetValidity: 'pending',
            postalCodeValidity: 'pending',
            cityValidity: 'pending',
            stateValidity: 'pending',
            countryValidity: 'pending',
            telValidity: 'pending'
        }
    },

    computed: {

        isSaveEnabled() {
            return this.isNameValid()
                && this.isStreetValid()
                && this.isPostalCodeValid()
                && this.isCityValid()
                && this.isStateValid()
                && this.isCountryValid()
                && this.isTelValid();
        }
    },

    methods: {

        isNameValid() {
            return this.mAddress.name.length > 0 && this.mAddress.name.length <= 100;
        },

        validateName() {
            if (this.isNameValid()) {
                this.nameValidity = 'valid';
            } else {
                this.nameValidity = 'invalid';
            }
        },

        isStreetValid() {
            return this.mAddress.street.length > 0 && this.mAddress.street.length <= 100;
        },

        validateStreet() {
            if (this.isStreetValid()) {
                this.streetValidity = 'valid';
            } else {
                this.streetValidity = 'invalid';
            }
        },

        isPostalCodeValid() {
            return this.mAddress.postalCode.length > 0 && this.mAddress.postalCode.length <= 100;
        },

        validatePostalCode() {
            if (this.isPostalCodeValid()) {
                this.postalCodeValidity = 'valid';
            } else {
                this.postalCodeValidity = 'invalid';
            }
        },

        isCityValid() {
            return this.mAddress.city.length > 0 && this.mAddress.city.length <= 100;
        },

        validateCity() {
            if (this.isCityValid()) {
                this.cityValidity = 'valid';
            } else {
                this.cityValidity = 'invalid';
            }
        },


        isStateValid() {
            return this.mAddress.state.length <= 100;
        },

        validateState() {
            if (this.isStateValid()) {
                this.stateValidity = 'valid';
            } else {
                this.stateValidity = 'invalid';
            }
        },

        isCountryValid() {
            return this.mAddress.country.length > 0 && this.mAddress.country.length <= 100;
        },

        validateCountry() {
            if (this.isCountryValid()) {
                this.countryValidity = 'valid';
            } else {
                this.countryValidity = 'invalid';
            }
        },

        isTelValid() {
            return this.mAddress.tel.length > 0 && this.mAddress.tel.length <= 32;
        },

        validateTel() {
            if (this.isTelValid()) {
                this.telValidity = 'valid';
            } else {
                this.telValidity = 'invalid';
            }
        },

        emitSaveAddress() {
            this.$emit('onSaveAddress', this.mAddress);
        }

    }




}
</script>
