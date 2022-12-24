<template>
    <teleport to="body">
        <dialog open>
            <slot>
                <h2>{{ title }}</h2>
                <p>{{ message }}</p>
                <button @click="$emit('onCloseAlertDialog')">OK</button>
            </slot>
        </dialog>
    </teleport>
</template>

<script>

import { Teleport } from 'vue';

export default {

    props: ['title', 'message'],

    emits: ['onCloseAlertDialog'],

    components: {
        Teleport
    }
}
</script>

<style scoped>
dialog {
    margin: 0;
    position: fixed;
    top: 20vh;
    left: 30%;
    width: 40%;
    background-color: white;
    box-shadow: 0 2px 8px rbg(0, 0, 0, 0.26);
    padding: 1rem;
}
</style>