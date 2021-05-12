import axios from 'axios';
import {domain} from 'env';

export default {
    namespaced: true,
    state: {
        oauth: {

        },
    },
    actions: {
        async login({commit}, form) {
            const headers = {
                Authorization: "Basic dWFhY2xpZW50OnVhYXNlY3JldA=="
            };
            const {data} = await axios.post(
                `${domain}/oauth/token`,
                {...form, grant_type: "password"},
                { headers }
            );

            commit('save_token', data);
        }
    },
    mutations: {
        save_token(state, oauth) {
            state.oauth = oauth;
        },
    },
    getters: {
        user(state) {
            const [, body,] = state.oauth.access_token.split('.');
            const user = JSON.parse(atob(body));

            if (user.scope) {
                user.scope = user.scope.split(',');
            }

            return user;
        },
    }
}