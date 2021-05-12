<template>
    <div>
        <div class="field">
            <label class="label">Nome</label>
            <div class="control">
                <input v-model="name" class="input" type="text" :class="{'is-danger': $v.name.$invalid}">
            </div>
        </div>
        <p v-if="$v.name.$invalid" class="help is-danger">Nome inválido</p>
        <div class="field">
            <label class="label">Patas</label>
            <div class="control">
                <input v-model="paws" class="input" type="number" :class="{'is-danger': $v.paws.$invalid}">
            </div>
        </div>
        <p v-if="$v.paws.$invalid" class="help is-danger">Patas obrigatório</p>
        <div class="field">
            <label class="label">Tipo</label>
            <div class="control">
                <input v-model="type" class="input" type="number" :class="{'is-danger': $v.type.$invalid}">
            </div>
        </div>
        <p v-if="$v.type.$invalid" class="help is-danger">Tipo obrigatório</p>
        <div class="field">
            <label class="label">Data nascimento</label>
            <div class="control">
                <input v-model="born" class="input" type="date" :class="{'is-danger': $v.born.$invalid}">
            </div>
        </div>
        <p v-if="$v.born.$invalid" class="help is-danger">Data obrigatório</p>
        <button class="button" @click="submit(name, paws, type, born)" :disabled="$v.name.$invalid">Salvar</button>
    </div>
</template>

<script>
import { required, maxLength, minLength} from 'vuelidate/lib/validators'
import axios from 'axios';

export default {
    data() {
        return {
            name: '',
            paws: '',
            type: '',
            born: '',
        }
    },
    validations: {
        name: {
            required,
            maxLength: maxLength(100),
            minLength: minLength(2),
        },
        paws: {
            required,
        },
        type: {
            required,
        },
        born: {
            required,
        },
    },
    methods: {
        async submit(name, paws, type, born) {
            // TODO mudar para form
            if (this.$v.name.$invalid) {
                console.log(name, paws, type, born);
                let id = Math.round(Math.random() * 100);
                try {
                    await axios.post(
                        'http://172.28.2.98/animals',
                        {id, name, paws, type, born}
                    );
                    alert('Inserido com sucuesso');
                } catch {
                    alert('Erro não inserido');
                }

            }
        }
    }
}
</script>