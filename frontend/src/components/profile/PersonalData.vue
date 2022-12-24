<template>
    <form @submit.prevent="savePersonalData">
        <div class="form-control">
            <label for="salutation">Salutation</label>
            <select id="salutation" name="salutation" v-model="salutation">
                <option value="NONE">None</option>
                <option value="MISS">Miss</option>
                <option value="MISTER">Mister</option>
            </select>
        </div>
        <div class="form-control" :class="{ invalid: firstNameValidity === 'invalid' }">
            <label for="first-name">First Name</label>
            <input id="first-name" name="first-name" type="text" v-model.trim="firstName" @blur="validateFirstName" />
            <p v-if="firstNameValidity === 'invalid'">Please enter a valid name!</p>
        </div>
        <div class="form-control" :class="{ invalid: lastNameValidity === 'invalid' }">
            <label for="last-name">Last Name</label>
            <input id="last-name" name="last-name" type="text" v-model.trim="lastName" @blur="validateLastName" />
            <p v-if="lastNameValidity === 'invalid'">Please enter a valid name!</p>
        </div>
        <div class="form-control" :class="{ invalid: emailValidity === 'invalid' }">
            <label for="email">E-mail</label>
            <input id="email" name="email" type="email" v-model.trim="email" @blur="validateEmail" />
            <p v-if="emailValidity === 'invalid'">Please enter a valid email!</p>
        </div>
        <div class="form-control">
            <button v-if="isSaveEnabled">Save Data</button>
        </div>
    </form>
    <alert-dialog v-if="error != null" :title="'An error occured'" :message="error.message" @onCloseAlertDialog="closeErrorAlert"></alert-dialog>
    <alert-dialog v-if="saveFinished" :title="'OK'" :message="'Personal data were saved!'" @onCloseAlertDialog="closeSaveAlert"></alert-dialog>
</template>


<script>

export default {

    data() {
        return {
            id: -1,
            salutation: 'NONE',
            firstName: '',
            firstNameValidity: 'pending',
            lastName: '',
            lastNameValidity: 'pending',
            email: '',
            emailValidity: 'pending',
            error: null,
            saveFinished: false
        }
    },

    computed: {

        isSaveEnabled() {
            return this.isFirstNameValid()
                && this.isLastNameValid()
                && this.isEmailValid();
        }
    },

    methods: {

        isFirstNameValid() {
            return this.firstName.length > 0 && this.firstName.length <= 100;
        },

        isLastNameValid() {
            return this.lastName.length > 0 && this.lastName.length <= 100;
        },

        isEmailValid() {
            return this.email.length > 0
                && this.email.length <= 100
                && /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(this.email);
        },

        validateFirstName() {
            if (this.isFirstNameValid()) {
                this.firstNameValidity = 'valid';
            } else {
                this.firstNameValidity = 'invalid';
            }
        },

        validateLastName() {
            if (this.isLastNameValid()) {
                this.lastNameValidity = 'valid';
            } else {
                this.lastNameValidity = 'invalid';
            }
        },

        validateEmail() {
            if (this.isEmailValid()) {
                this.emailValidity = 'valid';
            } else {
                this.emailValidity = 'invalid';
            }
        },

        loadPersonalData() {
            this.error = null;
            fetch('/profile/personal-data')
                .then((response) => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error("Error with code: " + response.status + " , " + response.statusText);
                    }
                })
                .then((data) => {
                    this.id = data.id;
                    this.salutation = data.salutation;
                    this.lastName = data.lastName;
                    this.firstName = data.firstName;
                    this.email = data.email;
                })
                .catch((error) => {
                    this.error = error;
                });
        },

        savePersonalData() {
            this.error = null;
            this.saveFinished = false;
            fetch('/profile/personal-data', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    id: this.id,
                    salutation: this.salutation,
                    firstName: this.firstName,
                    lastName: this.lastName,
                    email: this.email
                }),
            })
                .then((response) => {
                    if (response.ok) {
                        this.saveFinished = true;
                    } else {
                        throw new Error('Could not save data!');
                    }
                })
                .catch((error) => {
                    this.error = error.message;
                });
        },


        closeErrorAlert() {
            this.error = null;
        },

        closeSaveAlert() {
            this.saveFinished = false;
        }

    },

    mounted() {

        this.loadPersonalData();
    }

}



</script>
