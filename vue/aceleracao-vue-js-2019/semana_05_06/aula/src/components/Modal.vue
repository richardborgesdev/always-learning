<template>
    <div class="modal" :class="{'is-active': isOpened}">
    <div class="modal-background"></div>
    <div class="modal-card">
        <header class="modal-card-head">
            <slot name="head"></slot>
            <p>{{title}}</p>
            <button class="delete" aria-label="close" @click="closeModal"></button>
        </header>
        <section class="modal-card-body">
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
        title: String,
    },
    methods: {
        closeModal() {
            this.$emit('close');
        }
    }
}
</script>

<style lang="scss" scoped>
.level {
    padding: 10px;
}
</style>