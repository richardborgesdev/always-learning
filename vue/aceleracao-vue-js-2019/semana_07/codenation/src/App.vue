<template>
  <transition name="fade">
    <router-view v-show="show"></router-view>
  </transition>
</template>

<script>
export default {
  name: "app",
  data() {
    return {
      show: false,
    }
  },
  mounted() {
    this.show = true;
  }
};
</script>

<style lang="scss">
@import "@/theme/bulma.scss";

.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active em versões anteriores a 2.1.8 */ {
  opacity: 0;
}
</style>
