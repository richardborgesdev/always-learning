<template>
  <div class="modal" :class="{ 'is-active': isOpened }">
    <div class="modal-background"></div>
    <div class="modal-card">
      <header class="modal-card-head">
        <slot name="head">
          <p class="modal-card-title">{{ title }}</p>
        </slot>
        <button @click="closeModal" class="delete" aria-label="close"></button>
      </header>
      <section
        class="modal-card-body"
        :class="{ 'is-border-radius': !$slots.foot }"
      >
        <slot></slot>
      </section>
      <footer v-if="$slots.foot" class="modal-card-foot">
        <slot name="foot"></slot>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    isOpened: Boolean,
    title: String
  },
  methods: {
    closeModal() {
      this.$emit("close");
    }
  }
};
</script>
<style lang="scss" scoped>
.is-border-radius {
  border-bottom-left-radius: 6px;
  border-bottom-right-radius: 6px;
}
</style>
