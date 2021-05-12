import Vue from "vue";
import axios from "axios";

import App from "./App.vue";
import "./registerServiceWorker";

import Vuelidate from 'vuelidate'
Vue.use(Vuelidate);

Vue.config.productionTip = false;

import VueRouter from "vue-router";
Vue.use(VueRouter);

import router from './routes';
import store from './store/index';

import interceptor from "@/utils/interceptor";
axios.interceptors.request.use(interceptor);

new Vue({
  render: h => h(App),
  router,
  store,
}).$mount("#app");
