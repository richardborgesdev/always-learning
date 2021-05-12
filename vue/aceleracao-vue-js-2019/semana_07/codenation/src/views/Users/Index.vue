<template>
  <div>
    <Navbar>
      <div class="navbar-end is-hidden-touch">
        <div class="navbar-item">{{ user.name }}</div>
      </div>
    </Navbar>
    <div class="container">
      <Table class="is-fullwidth" :columns="columns" :rows="rows">
        <tr slot-scope="row">
          <td>{{ row.item.name }}</td>
          <td>{{ row.item.email }}</td>
        </tr>
      </Table>
    </div>
    <Modal @close="isOpened = false" title="Novo Animal" :is-opened="isOpened">
      <Form />
    </Modal>
  </div>
</template>

<script>
import axios from "axios";
import { mapGetters } from "vuex";
import { domain } from "env";

import Table from "@/components/Table";
import Navbar from "@/components/Navbar";
import Modal from "@/components/Modal";

import Form from "./Form";

export default {
  name: "app",
  components: { Table, Navbar, Modal, Form },
  data() {
    return {
      email: "",
      isOpened: false,
      columns: ["Nome", "Email"],
      rows: []
    };
  },
  async created() {
    const { data } = await axios.get(`${domain}/users`);
    this.rows = data.items;
  },
  computed: {
    ...mapGetters("login", ["user"])
  },
  methods: {
    showModal() {
      this.isOpened = true;
    }
  }
};
</script>
z
