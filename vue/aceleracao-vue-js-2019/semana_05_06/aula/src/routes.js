import VueRouter from 'vue-router';
import Users from '@/views/Users/Index.vue';
import Login from '@/views/Login';

export default new VueRouter({
    mode: 'history',
    routes: [
        {
            name: 'users',
            path: '/users',
            component: Users
        },
        {
            path: '/login',
            component: Login
        },
    ]
});