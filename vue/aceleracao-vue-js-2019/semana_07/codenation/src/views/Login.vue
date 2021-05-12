<template>
  <div class="columns">
    <div class="column is-4 is-offset-4 has-text-centered">
      <h1 class="title">Login</h1>
      <div class="notification is-danger" v-show="error">
        <p>
          {{error}}
        </p>
      </div>
      <input v-model="form.username" class="input" placeholder="Email" />
      <input
        v-model="form.password"
        class="input"
        placeholder="Senha"
        type="password"
      />
      <button class="button" @click="submit(form)">Login</button>
      <router-link class="button" :to="{name: 'signup'}">Cadastrar</router-link>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";

export default {
  data() {
    return {
      error: false,
      form: {
        username: "",
        password: ""
      }
    };
  },
  methods: {
    ...mapActions("login", ["login"]),
    async submit(form) {
      try {
        await this.login(form);
        this.$router.push({ name: "users" });
      } catch ({response}) {
        this.error = response.data.message || response.data.errors;
      }
    }
  },
  watch: {
    error() {
      console.log('teste');
    }
  }
};
</script>
