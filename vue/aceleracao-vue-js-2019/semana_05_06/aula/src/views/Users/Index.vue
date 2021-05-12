<template>
    <div>
    <NavBar>
      <div class="navbar-end">
        <div class="navbar-item">{{`${user.id} - ${user.name}`}}</div>
      </div>
    </NavBar>
    <div class="container">
      <Bar>
          <button v-if="hasPermission('users:write')" slot="right" class="button is-primary" @click="showModal">
              novo usuario
          </button>
      </Bar>
      <Table class="is-fullwidth" :columns="columns1" :rows="rows1" >
        <tr slot-scope="row">
          <td>{{row.item.id}}</td>
          <td>{{row.item.name}}</td>
          <td>{{row.item.email}}</td>
          <td>
            <div class="tags has-addons is-marginless" v-for="(scope, index) in row.item.scope" :key="index">
              <span class="tag">{{scope.object}}</span>
              <span class="tag is-primary">{{scope.action}}</span>
            </div>
          </td>
        </tr>
      </Table>
      <Table :columns="columns2" :rows="rows2"></Table>
    </div>
    <Modal :is-opened="isOpened" @close="isOpened = false" title="Novo Animal">
        <Form>

        </Form>
        <!--<p slot="foot">foot</p>-->
    </Modal>
  </div>
</template>

<script>
import axios from 'axios';
import {domain} from 'env';
import {mapGetters} from 'vuex';

import Table from "@/components/Table";
import NavBar from "@/components/NavBar";
import Bar from "@/components/Bar";
import Modal from "@/components/Modal";
import Form from "./Form";

export default {
  name: "app",
  components: {
    Table,
    NavBar,
    Bar,
    Modal,
    Form,
  },
  data() {
    return {
      isOpened: false,
      columns1: ['Id', 'Nome', 'Email', 'Permissão'],
      rows1: [],
      columns2: ['Id'],
      rows2: [
        ['id2'],
      ],
    }
  },
  methods: {
    showModal() {
      this.isOpened = true;
    },
    hasPermission(scope) {
      return this.user.scope.includes(scope);
    },
  },
  async created() {
    const {data} = await axios.get(
      `${domain}/users`
    );

    this.rows1 = data.map((row) => {
      row.scope = row.scope.map((scope) => {
        const [object, action] = scope.split(':');
        return {object, action};
      });
      return row;
    });
  },
  computed: {
    ...mapGetters(
          'login',
          ['user']
      )
  }
};
</script>