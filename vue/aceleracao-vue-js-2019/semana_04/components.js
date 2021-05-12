const CodeTable = {
    props: [
        'items'
    ],
    template: `
        <table class="table">
            <thead>
            <tr>
                <th>Nome</th>
                <th>Idade</th>
            </tr>
            </thead>
            <tbody>
                <tr v-for="item in items">
                    <td>{{item.name}}</td>
                    <td>{{item.age}}</td>
                </tr>
            </tbody>
        </table>
    `
};

const CodeNav = {
    template: `
        <nav class="navbar is-info">
            <div class="navbar-start">
                <slot name="left"></slot>
            </div>
            <div class="navbar-end">
                <slot name="right"></slot>
            </div>
        </nav>
    `
}

const CodeContainer = {
    template: `
        <div class="container">
            <slot></slot>
        </div>
    `
};

const CodeButton = {
    props: [
        'title',
        'message',
        'disabled'
    ],
    template: `
        <button
            @click="$emit('insert')"
            @mouseover="over()"
            :disabled="disabled"
        >
            {{title}}
        </button>
    `,
    methods: {
        over() {
            console.log('passou por aqui');
        }
    }
};

const CodeList = {
    props: [
        'items'
    ],
    template: `
        <ul>
            <li
                v-for="item in items"
            >
                {{item}}
            </li>
        </ul>
    `
};