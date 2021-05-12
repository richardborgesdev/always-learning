<template>
    <div class="columns">
        <div class="column is-4 is-offset-4 has-text-centered">
            <h1 class="title">Login</h1>
            <input v-model="form.username" class="input" placeholder="Email" />
            <input v-model="form.password" class="input" placeholder="Senha" type="password"/>
            <div v-if="isError" class="notification is-danger">usuário e senha invalidos</div>
            <button class="button" @click="submit(form)">Login</button>
        </div>
    </div>
</template>

<script>
import {mapActions} from "vuex";

export default {
    data() {
        return {
            form: {
                username: 'admin@admin.io',
                password: 'admin@123',
            },
            isError: false,
        }
    },
    methods: {
        ...mapActions(
            'login',
            ['login']
        ),
        async submit(form) {
            try {
                await this.login(form);
                this.$router.push({name: 'users'});
            } catch (error) {
                this.isError = true;
            }
        }
    },
}
</script>