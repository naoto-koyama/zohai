<template>
  <nav class="l-nav grey darken-2">
    <span class="p-title">Kabu</span>
    <ul>
      <li class="p-search-month">
        <div class="input-field" :style="{'--placeholder-color': this.font_color}">
          <select multiple v-model="selected_month" @change="change_month()">
            <option value="" disabled>配当月</option>
            <option value="01">1月</option>
            <option value="02">2月</option>
            <option value="03">3月</option>
            <option value="04">4月</option>
            <option value="05">5月</option>
            <option value="06">6月</option>
            <option value="07">7月</option>
            <option value="08">8月</option>
            <option value="09">9月</option>
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
        font_color: '#999999',
        selected_month: [],
        search_text: ''
      }
    },
    methods : {
      ...mapActions(T),
      changeSearch() {
        this.CHANGE_SEARCH_CHAR(this.search_text)
      },
      change_month() {
        this.font_color = this.selected_month.length === 0 ? '#999999': 'white'
        this.CHANGE_MONTH(this.selected_month)
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

  .l-nav {
    ul {
      & > li {
        height: 100%;
        margin: 0 10px 0 0;

        &:last-child {
          margin: 0;
        }
      }
    }
  }

  .p-search-month {
    --placeholder-color: #999999;

    /deep/
    .select-wrapper {
      height: 100%;

      input.select-dropdown {
        color: var(--placeholder-color);
      }

      svg {
        display: none;
      }
    }
  }

  .p-search-text {
    display: flex;
    align-items: center;
    input {
      height: 1.5em;
      padding: 0 0 10px;
      margin: 0 0 8px;
      color: #ffffff;
      font-family: 'Noto Sans JP', 'Roboto', sans-serif;
      &::placeholder {
        color: #999999;
      }

    }
    .material-icons {
      color: #999999;
    }
  }
</style>