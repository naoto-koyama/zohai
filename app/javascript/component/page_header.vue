<template>
  <nav class="l-nav grey darken-2">
    <span class="l-nav__title">Kabu</span>
    <ul>
      <li class="l-nav__search">
        <input type="text" placeholder="Code or Name" v-model="search_text" @input="changeSearch()">
        <i class="material-icons">search</i>
      </li>
    </ul>
  </nav>
</template>

<script>
  import {mapActions} from "vuex";
  import {T} from "../store/global-store/types";

  export default {
    data ()  {
      return {
        search_text: ''
      }
    },
    methods : {
      ...mapActions(T),
      changeSearch() {
        this.CHANGE_SEARCH_CHAR(this.search_text)
      }
    }
  }
</script>

<style scoped>

</style>