<template>
  <div class="columns">
    <div class="column is-4 is-offset-4">
      <h1 class="title has-text-centered">Cadastrar novo usuário</h1>
      <div class="notification is-danger" v-show="errors.length > 0">
        <p v-for="({message}, index) in errors" :key="index">
          {{message}}
        </p>
      </div>
      <form
        @submit.prevent="submit(form)"
      >
        <div class="field">
          <input v-model="form.name" class="input" placeholder="Name" :class="{'is-danger': $v.form.name.$invalid}"/>
          <p class="help is-danger" v-show="$v.form.name.$invalid">Nome é obrigatório</p>
        </div>
        <input v-model="form.email" class="input" placeholder="Email" />
        <p class="help is-danger" v-show="$v.form.email.$invalid">Email inválido</p>
        <input
          v-model="form.password"
          class="input"
          placeholder="Senha"
          type="password"
          autocomplete="new-password"
        />
        <p class="help is-danger" v-show="$v.form.password.$invalid">No minimo 8 caracteres</p>
        <button class="button" :disabled="$v.form.$invalid">Cadastrar</button>
      </form>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";
import { required, maxLength, minLength, email } from "vuelidate/lib/validators";

export default {
  data() {
    return {
      errors: [],
      form: {
        email: "",
        password: "",
        name: "",
      },
    };
  },
  validations: {
    form: {
      name: {
        required,
      },
      email: {
        required,
        email,
      },
      password: {
        required,
        minLength: minLength(8),
      },
    }
  },
  methods: {
    ...mapActions("login", ["signup"]),
    async submit(form) {
      try {
        await this.signup(form);
      } catch ({response}) {
        this.errors = response.data.errors;
      }
    }
  }
};
</script>
