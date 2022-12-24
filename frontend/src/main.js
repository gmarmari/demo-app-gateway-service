import { createApp } from 'vue'
import App from './App.vue'


import BaseCard from './components/UI/BaseCard.vue';
import BaseButton from './components/UI/BaseButton.vue';
import AlertDialog from "./components/UI/AlertDialog.vue";

const app = createApp(App);

app.component('base-card', BaseCard);
app.component('base-button', BaseButton);
app.component('alert-dialog', AlertDialog);

app.mount('#app')
