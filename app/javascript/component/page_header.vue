<template>
  <nav class="l-nav grey darken-2">
    <span class="p-title">Kabu</span>
    <ul>
      <li class="p-search-month">
        <div class="input-field">
          <select multiple v-model="selected_month">
            <option value="" disabled>配当月</option>
            <option value="1">1月</option>
            <option value="2">2月</option>
            <option value="3">3月</option>
            <option value="4">4月</option>
            <option value="5">5月</option>
            <option value="6">6月</option>
            <option value="7">7月</option>
            <option value="8">8月</option>
            <option value="9">9月</option>
            <option value="10">10月</option>
            <option value="11">11月</option>
            <option value="12">12月</option>
          </select>
        </div>
      </li>
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
        selected_month: [],
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

  .select-wrapper {
    .select-dropdown {
      color: white;
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