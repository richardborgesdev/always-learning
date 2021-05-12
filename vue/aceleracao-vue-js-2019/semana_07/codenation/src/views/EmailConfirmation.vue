<template>
  <div
    class="columns"
    :class="{'loading': isLoading}"
  >
    <div class="column is-4 is-offset-4 has-text-centered">
      <h1 class="title">Confirmando o usuário</h1>
      <h2 class="has-text-danger" v-if="error">{{error}}</h2>
      <h2 v-else>Email confirado com sucesso</h2>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";

export default {
  data() {
    return {
      error: false,
      isLoading: true,
    }
  },
  props: {
    token: String,
  },
  async created() {
     try {
      await this.confirm(this.token);
    } catch ({response}) {
      this.error = response.data.message;
    } finally {
      this.isLoading = false;
    }
  },
  methods: {
    ...mapActions("login", ["confirm"])
  }
};
</script>
