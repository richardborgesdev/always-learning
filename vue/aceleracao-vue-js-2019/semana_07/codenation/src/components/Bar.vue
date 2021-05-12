<template>
  <div class="level">
    <div class="level-left">
      <slot name="left"></slot>
    </div>
    <div class="level-right">
      <slot name="right"></slot>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.level {
  padding: 10px;
}
</style>
