<template>
    <div class="level">
        <div class="level-left">
            <div class="level-item">
                <slot name="left"></slot>
            </div>
        </div>
        <div class="level-right">
            <div class="level-item">
                <slot name="right"></slot>
            </div>
        </div>
        </div>
</template>

<script>

</script>

<style lang="scss" scoped>
.level {
    padding: 10px;
}
</style>