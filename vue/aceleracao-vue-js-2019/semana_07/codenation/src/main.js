import Vue from "vue";
import axios from "axios";
import App from "./App.vue";
import Vuelidate from "vuelidate";
import VueRouter from "vue-router";
import router from "./routes";
import store from "./store/index";
import interceptor from "@/utils/interceptor";

axios.interceptors.request.use(interceptor);

Vue.use(Vuelidate);
Vue.use(VueRouter);
Vue.config.productionTip = false;

new Vue({
  store,
  router,
  render: h => h(App)
}).$mount("#app");
