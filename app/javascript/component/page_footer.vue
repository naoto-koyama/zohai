<template>
  <footer class="l-footer">
    <span>© {{current_year}} Copyright, All rights reserved.</span>
  </footer>
</template>

<script>
  import {mapGetters} from "vuex";

  export default {
    computed: {
      current_year() {
        return new Date().getFullYear()
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>
