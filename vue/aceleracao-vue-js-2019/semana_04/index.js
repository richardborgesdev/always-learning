console.log(Vue.version);

new Vue({
    el: '#app',
    components: {
        CodeButton,
        CodeList,
        CodeNav,
        CodeContainer,
        CodeTable
    },
    data() {
        return {
            items: [],
            form: {
                age: '',
                name: ''
            }
        }
    },
    created () {
        this.loadItems();
    },
    template: `
        <div>
            <code-nav>
                <a class="navbar-item" slot="left"><b>Listagem de items</b></a>
                <a class="navbar-item" slot="right">richardborgescc</a>
            </code-nav>
            <code-container class="box">
                <div class="field">
                    <label class="label">Name</label>
                    <div class="control">
                        <input class="input" :class="{'is-danger': !form.name}" type="text" v-model="form.name" placeholder="insira seu nome">
                    </div>
                    <p v-show="!form.name" class="help is-danger">nome invalido</p>
                </div>
                <div class="field">
                    <label class="label">Age</label>
                    <div class="control">
                        <input class="input" :class="{'is-danger': !form.age}" type="number" v-model="form.age" value="0" min="1" max="130" placeholder="insira sua idade">
                    </div>
                    <p v-show="!form.age" :class="{'is-danger': !form.age}" class="help is-danger">idade invalida</p>
                </div>
                <code-button
                    :disabled="!form.name || !form.age"
                    class="button"
                    title="Incluir"
                    message="Incluido"
                    @insert="insert(form)"
                />
                <code-table :items="items">
                </code-table>
            </code-container>
        </div>
    `,
    computed: {
        isValidName() {
            return this.form.name;
        },
        isValidAge() {
            return this.form.age < 1;
        },
    },
    methods: {
        insert(v) {
            this.items.push({...v});
            axios.post(
                'http://172.28.8.98:3000/users',
                {
                    ...v,
                    id: Date.now() + Math.round(Math.random() * 100)
                }
            ).then(() => {
                this.form.name = '';
                this.form.age = '';
                this.loadItems();
            }).catch(() => {
                window.alert('Ocorreu um erro ao inserir os dados');
            });
        },
        loadItems() {
            axios.get('http://172.28.8.98:3000/users').then(
                ({data}) => {
                    this.items = data;
                }
            ).catch(() => {
                window.alert('Ocorreu um erro ao carregar os dados');
            });
        }
    }
});