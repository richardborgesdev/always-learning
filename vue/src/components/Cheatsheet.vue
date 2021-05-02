<template>
  <span>{{bindMe}}</span>
  <button @click="changeBind()">teste</button>
</template>

<script>
export default {
    name: 'Cheatsheet',
    data() {
        return {

            bindMe: ''
        };
    },
    methods: {
        changeBind() {
            this.bindMe = 'bind';
        }
    }
}
</script>

<style>

</style>
