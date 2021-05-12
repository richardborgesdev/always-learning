import VueRouter from "vue-router";
import Users from "@/views/Users/Index";
import Login from "@/views/Login";
import Signup from "@/views/Signup";
import EmailConfirmation from "@/views/EmailConfirmation";

export default new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/",
      redirect: "/login",
    },
    {
      path: "/login",
      component: Login,
    },
    {
      name: "users",
      path: "/users",
      component: Users,
    },
    {
      name: "signup",
      path: "/signup",
      component: Signup,
    },
    {
      name: "email-confirmation",
      path: "/email-confirmation/:token",
      props: true,
      component: EmailConfirmation,
    },
    {
      path: "/**",
      redirect: "/login",
    },
  ]
});
