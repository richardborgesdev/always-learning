import Vue from "vue";
import Vuex from 'vuex';
import login from './login';
import VuexPersistence from "vuex-persist";

Vue.use(Vuex);

export default new Vuex.Store({
    plugins: [
        new VuexPersistence({storage: global.localStorage, key: "state"}).plugin
    ],
    modules: {
        login,
    }
});