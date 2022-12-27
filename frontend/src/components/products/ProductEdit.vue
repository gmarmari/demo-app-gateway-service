<template>
    <form @submit.prevent="emitSaveProduct">
        <div class="form-control" :class="{ invalid: nameValidity === 'invalid' }">
            <label for="name">Name</label>
            <input id="name" name="name" type="text" v-model.trim="mDetails.product.name" @blur="validateName" />
            <p v-if="nameValidity === 'invalid'">Please enter a valid name!</p>
        </div>

        <div class="form-control" :class="{ invalid: prizeValidity === 'invalid' }">
            <label for="prize">Prize</label>
            <input id="prize" name="prize" type="number" step="0.01" v-model.trim="mDetails.product.prize.amount"
                @blur="validatePrize" />
            <p v-if="prizeValidity === 'invalid'">Please enter a valid prize!</p>
        </div>

        <div class="form-control">
            <label for="prizeUnit">Prize Unit</label>
            <select id="prizeUnit" name="prizeUnit" v-model="mDetails.product.prize.unit">
                <option value="NONE">None</option>
                <option value="EURO">Euro</option>
                <option value="DOLLAR">Dollar</option>
            </select>
        </div>


        <div class="form-control" :class="{ invalid: sizeValidity === 'invalid' }">
            <label for="size">Size</label>
            <input id="size" name="size" type="number" step="1" v-model.trim="mDetails.info.size.amount"
                @blur="validateSie" />
            <p v-if="sizeValidity === 'invalid'">Please enter a valid size!</p>
        </div>

        <div class="form-control">
            <label for="sizeUnit">Size Unit</label>
            <select id="sizeUnit" name="sizeUnit" v-model="mDetails.info.size.unit">
                <option value="NONE">None</option>
                <option value="GRAMS">Grams</option>
                <option value="MILLI_LITER">Milli liter</option>
                <option value="LITER">Liter</option>
            </select>
        </div>

        <div class="form-control" :class="{ invalid: countryOfOriginValidity === 'invalid' }">
            <label for="countryOfOrigin">Country of origin</label>
            <input id="countryOfOrigin" name="countryOfOrigin" type="text" v-model.trim="mDetails.info.countryOfOrigin"
                @blur="validateCountryOfOrigin" />
            <p v-if="countryOfOriginValidity === 'invalid'">Please enter a valid country!</p>
        </div>

        <div class="form-control" :class="{ invalid: descriptionValidity === 'invalid' }">
            <label for="description">Description</label>
            <input id="description" name="description" type="text" v-model.trim="mDetails.info.description"
                @blur="validateDescription" />
            <p v-if="descriptionValidity === 'invalid'">Please enter a valid description!</p>
        </div>

        <div class="form-control" :class="{ invalid: contactNameValidity === 'invalid' }">
            <label for="contactName">Contact name</label>
            <input id="contactName" name="contactName" type="text" v-model.trim="mDetails.contact.name"
                @blur="validateContactName" />
            <p v-if="contactNameValidity === 'invalid'">Please enter a valid name!</p>
        </div>

        <div class="form-control" :class="{ invalid: addressValidity === 'invalid' }">
            <label for="address">Address</label>
            <input id="address" name="address" type="text" v-model.trim="mDetails.contact.address"
                @blur="validateAddress" />
            <p v-if="addressValidity === 'invalid'">Please enter a valid address!</p>
        </div>

        <div class="form-control" :class="{ invalid: telValidity === 'invalid' }">
            <label for="tel">Tel</label>
            <input id="tel" name="tel" type="tel" v-model.trim="mDetails.contact.tel" @blur="validateTel" />
            <p v-if="telValidity === 'invalid'">Please enter a valid tel!</p>
        </div>

        <div class="form-control" :class="{ invalid: emailValidity === 'invalid' }">
            <label for="email">E-mail</label>
            <input id="email" name="email" type="email" v-model.trim="mDetails.contact.email" @blur="validateEmail" />
            <p v-if="emailValidity === 'invalid'">Please enter a valid e-mail!</p>
        </div>

        <div class="form-control" :class="{ invalid: websiteValidity === 'invalid' }">
            <label for="website">Website</label>
            <input id="website" name="website" type="text" v-model.trim="mDetails.contact.website"
                @blur="validateWebsite" />
            <p v-if="websiteValidity === 'invalid'">Please enter a valid website!</p>
        </div>

        <div class="form-control">
            <button v-if="isSaveEnabled">Save Data</button>
        </div>
    </form>
</template>


<script>

export default {

    props: ['details'],

    emits: ['onSaveProduct'],

    data() {
        return {
            mDetails: this.details,
            nameValidity: 'pending',
            prizeValidity: 'pending',
            sizeValidity: 'pending',
            countryOfOriginValidity: 'pending',
            descriptionValidity: 'pending',
            contactNameValidity: 'pending',
            addressValidity: 'pending',
            telValidity: 'pending',
            emailValidity: 'pending',
            websiteValidity: 'pending'
        }
    },

    computed: {

        isSaveEnabled() {
            return this.isNameValid()
                && this.isPrizeValid()
                && this.isSizeValid()
                && this.isCountryOfOriginValid()
                && this.isDescriptionValid()
                && this.isContactNameValid()
                && this.isAddressValid()
                && this.isTelValid()
                && this.isEmailValid()
                && this.isTelValid();
        }
    },

    methods: {

        isNameValid() {
            return this.mDetails.product.name.length > 0 && this.mDetails.product.name.length <= 100;
        },

        validateName() {
            if (this.isNameValid()) {
                this.nameValidity = 'valid';
            } else {
                this.nameValidity = 'invalid';
            }
        },

        isPrizeValid() {
            return this.mDetails.product.prize.amount != null && this.mDetails.product.prize.amount >= 0;
        },

        validatePrize() {
            if (this.isPrizeValid()) {
                this.prizeValidity = 'valid';
            } else {
                this.prizeValidity = 'invalid';
            }
        },

        isSizeValid() {
            return this.mDetails.info.size.amount != null && this.mDetails.info.size.amount >= 0;
        },

        validateSize() {
            if (this.isSizeValid()) {
                this.sizeValidity = 'valid';
            } else {
                this.sizeValidity = 'invalid';
            }
        },

        isCountryOfOriginValid() {
            return this.mDetails.info.countryOfOrigin.length > 0 && this.mDetails.info.countryOfOrigin.length <= 100;
        },

        validateCountryOfOrigin() {
            if (this.isCountryOfOriginValid()) {
                this.countryOfOriginValidity = 'valid';
            } else {
                this.countryOfOriginValidity = 'invalid';
            }
        },

        isDescriptionValid() {
            return this.mDetails.info.description == null || this.mDetails.info.description.length <= 1000;
        },

        validateDescription() {
            if (this.isDescriptionValid()) {
                this.descriptionValidity = 'valid';
            } else {
                this.descriptionValidity = 'invalid';
            }
        },

        isContactNameValid() {
            return this.mDetails.contact.name.length > 0 && this.mDetails.contact.name.length <= 100;
        },

        validateContactName() {
            if (this.isContactNameValid()) {
                this.contactNameValidity = 'valid';
            } else {
                this.contactNameValidity = 'invalid';
            }
        },

        isAddressValid() {
            return this.mDetails.contact.address.length > 0 && this.mDetails.contact.address.length <= 200;
        },

        validateAddress() {
            if (this.isAddressValid()) {
                this.addressValidity = 'valid';
            } else {
                this.addressValidity = 'invalid';
            }
        },

        isTelValid() {
            return this.mDetails.contact.tel == null || this.mDetails.contact.tel.length <= 100;
        },

        validateTel() {
            if (this.isTelValid()) {
                this.telValidity = 'valid';
            } else {
                this.telValidity = 'invalid';
            }
        },

        isEmailValid() {
            return this.mDetails.contact.email == null || this.mDetails.contact.email.length <= 100;
        },

        validateEmail() {
            if (this.isEmailValid()) {
                this.emailValidity = 'valid';
            } else {
                this.emailValidity = 'invalid';
            }
        },

        isWebsiteValid() {
            return this.mDetails.contact.website == null || this.mDetails.contact.website.length <= 100;
        },

        validateWebsite() {
            if (this.isWebsiteValid()) {
                this.websiteValidity = 'valid';
            } else {
                this.websiteValidity = 'invalid';
            }
        },

        emitSaveProduct() {
            this.$emit('onSaveProduct', this.mDetails);
        }

    }




}
</script>


<style scoped>
form {
    margin: auto;
}
</style>