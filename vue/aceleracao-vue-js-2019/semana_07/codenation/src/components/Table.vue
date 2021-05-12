<template>
  <table class="table">
    <thead>
      <tr>
        <th v-for="(column, index) in columns" :key="index">{{ column }}</th>
      </tr>
    </thead>
    <tbody>
      <template v-if="$scopedSlots.default">
        <slot v-for="row in rows" :item="row"></slot>
      </template>
      <tr v-else v-for="(row, index) in rows" :key="index">
        <td v-for="(value, index) in row" :key="index">{{ value }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
export default {
  props: {
    columns: Array,
    rows: Array
  }
};
</script>

<style></style>
