<template>
  <div>
    <div class="field">
      <label class="label">Nome</label>
      <div class="control">
        <input
          v-model="form.name"
          class="input"
          :class="{ 'is-danger': $v.form.name.$invalid }"
          type="text"
        />
      </div>
      <p v-if="$v.form.name.$invalid" class="help is-danger">
        O campo nome é obrigatório e deve conter pelo menos três caracteres
      </p>
    </div>
    <div class="field">
      <label class="label">Patas</label>
      <div class="control">
        <input
          v-model="form.paws"
          class="input"
          :class="{ 'is-danger': $v.form.paws.$invalid }"
          type="number"
        />
      </div>
      <p v-if="$v.form.paws.$invalid" class="help is-danger">
        O campo patas é obrigatório
      </p>
    </div>
    <div class="field">
      <label class="label">Tipo</label>
      <div class="control">
        <input
          v-model="form.type"
          class="input"
          :class="{ 'is-danger': $v.form.type.$invalid }"
          type="text"
        />
      </div>
      <p v-if="$v.form.type.$invalid" class="help is-danger">
        O campo tipo é obrigatório
      </p>
    </div>
    <div class="field">
      <label class="label">Data Nascimento</label>
      <div class="control">
        <input
          v-model="form.date"
          class="input"
          :class="{ 'is-danger': $v.form.date.$invalid }"
          type="text"
        />
      </div>
      <p v-if="$v.form.date.$invalid" class="help is-danger">
        O campo data de nascimento é obrigatório
      </p>
    </div>
    <button class="button" @click="submit(form)" :disabled="$v.form.$invalid">
      Salvar
    </button>
  </div>
</template>

<script>
import { required, maxLength, minLength } from "vuelidate/lib/validators";
import axios from "axios";

const isRequired = { required };

export default {
  data() {
    return {
      form: {
        name: "",
        paws: "",
        type: "",
        date: ""
      }
    };
  },
  validations: {
    form: {
      name: {
        required,
        minLength: minLength(2),
        maxLength: maxLength(100)
      },
      paws: isRequired,
      type: isRequired,
      date: isRequired
    }
  },
  methods: {
    async submit(form) {
      if (!this.$v.form.$invalid) {
        form.id = Math.round(Math.random() * 100);
        try {
          await axios.post("http://172.28.8.98:3000/animals", form);
          console.log("Inserido com sucesso");
        } catch {
          console.error("Não inserido");
        }
      }
    }
  }
};
</script>
