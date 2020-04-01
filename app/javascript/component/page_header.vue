<template>
  <nav class="l-nav grey darken-2">
    <span class="p-title">Kabu</span>
    <ul>
      <li class="l-nav__search">
        <input type="text" placeholder="Code or Name" v-model="search_text" @input="changeSearch()">
      <li class="p-search-text">
        <input type="text" placeholder="コード / 銘柄" v-model="search_text" @input="changeSearch()">
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

<style lang="scss" scoped>
  .p-title {
    font-size: 50px;
    font-family: 'Indie Flower', cursive;
    display: flex;

    &:before {
     content: '';
     background: #f57c00;
     width: 15px;
     height: 100%;
     border-radius: 5px;
     margin: 0 10px 0 0;
    }
  }
  
  .p-search-text {
    display: flex;
    align-items: center;
    input {
      height: 1.5em;
      margin: 0;
      color: #ffffff;
      font-family: 'Noto Sans JP', 'Roboto', sans-serif;
      &::placeholder {
        opacity: 0.5;
      }
    }
  }
</style>