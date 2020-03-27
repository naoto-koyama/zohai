<template>
  <div>
    <nav class="l-nav grey darken-2">
      <div class="p-nav-wrapper">
        <span class="p-nav-title">Kabu</span>
        <ul>
          <li class="p-nav-wrapper__search">
            <input type="text">
            <i class="material-icons">search</i>
          </li>
        </ul>
      </div>
    </nav>
    <main class="l-main">
      <div class="p-table-list">
        <div class="p-divide-list" :class="{ 'is_show_detail': is_show_detail }">
          <table>
            <thead>
              <tr>
                <th :class="order_class('code')" @click="sort('code') ">コード</th>
                <th :class="order_class('name')" @click="sort('name')">銘柄</th>
                <th :class="order_class('fiscal_year')" @click="sort('fiscal_year')">会計年度</th>
                <th :class="order_class('indicated_dividend')" @click="sort('indicated_dividend')">配当金</th>
                <th :class="order_class('payout_ratio')" @click="sort('payout_ratio')">配当性向</th>
                <th :class="order_class('continuous_dividend_increase_years')" @click="sort('continuous_dividend_increase_years')">連続増配</th>
              </tr>
            </thead>
            <tbody>
              <tr class="hoverable" v-for="brand_latest_dividend in brand_latest_dividends" :key="brand_latest_dividend.id"　@click="clickBrandName(brand_latest_dividend.id)">
                <td>{{brand_latest_dividend.code}}</td>
                <td class="p-brand-name--truncate" >{{brand_latest_dividend.name}}</td>
                <td>{{brand_latest_dividend.fiscal_year}}</td>
                <td>{{brand_latest_dividend.indicated_dividend}}</td>
                <td>{{brand_latest_dividend.payout_ratio}}</td>
                <td>{{brand_latest_dividend.continuous_dividend_increase_years}}</td>
              </tr>
            </tbody>
          </table>
          <ul class="pagination">
            <li :class="prev_class" @click="clickFirstPage()">
              <a>
                <i class="material-icons">first_page</i>
              </a>
            </li>
            <li :class="prev_class" @click="clickPrev()">
              <a>
                <i class="material-icons">navigate_before</i>
              </a>
            </li>
            <li :class="page_class(n)" v-for="n in display_page_nos" :key="n">
              <a v-if="n === current_page - 2">...</a>
              <a v-else-if="current_page - 2 < n && n < current_page + 5" @click="clickPage(n)">{{n}}</a>
              <a v-else-if="n === current_page + 5 || n === current_page - 1">...</a>
            </li>
            <li :class="next_class" @click="clickNext()">
              <a>
                <i class="material-icons">navigate_next</i>
              </a>
            </li>
            <li :class="next_class" @click="clickLastPage()">
              <a>
                <i class="material-icons">last_page</i>
              </a>
            </li>
          </ul>
        </div>

        <transition name="fade">
          <div class="p-divide-trend-list" v-if="is_show_detail">
            <i class="material-icons p-close" @click="clickCloseIcon()">close</i>
            <table>
              <thead>
                <tr>
                  <th>会計年度</th>
                  <th>配当金</th>
                  <th>配当性向</th>
                  <th>連続増配</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="dividend_trend in dividend_trends" :v-key="dividend_trend.fiscal_year">
                  <td>{{dividend_trend.fiscal_year}}</td>
                  <td>{{dividend_trend.indicated_dividend}}</td>
                  <td>{{dividend_trend.payout_ratio}}</td>
                  <td>{{dividend_trend.continuous_dividend_increase_years}}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </transition>
      </div>
    </main>
    <footer class="l-footer grey darken-2">
      <span>© {{current_year}} Copyright, All rights reserved.</span>
      <span>Data from <a href="https://irbank.net/download" target="_blank">IR BANK</a></span>
    </footer>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { T } from './store/global-store/types.js'
export default {
  computed: {
    ...mapGetters({
      brand_latest_dividends: 'getBrandLatestDividends',
      dividend_trends: 'getDividendTrends',
      is_show_detail: 'getIsShowDetail',
      order_class: 'getOrderClass',
      pagenate_slice_no: 'getPagenateSliceNo',
      next_class: 'nextClass',
      prev_class: 'prevClass',
      page_class: 'pageClass',
      display_page_nos: 'getDisplayPageNos',
      current_page: 'getCurrentPage'
    }),
    current_year() {
      return new Date().getFullYear()
    }
  },
  mounted () {
    this.LOAD_BRAND_LATEST_DIVIDEND()
  },
  methods : {
    ...mapActions(T),
    sort (sort_column) {
      this.SORT_BRAND_LATEST_DIVIIEDEND(sort_column)
    },
    clickBrandName(id) {
      this.GET_DIVIDEND_TREND(id)
    },
    clickCloseIcon() {
      this.CLOSE_DIVIDEND_TREND()
    },
    clickPrev() {
      this.CLICK_PREV_PAGENATE()
    },
    clickNext() {
      this.CLICK_NEXT_PAGENATE()
    },
    clickPage(n) {
      this.CLICK_PAGENATE(n)
    },
    clickFirstPage() {
      this.CLICK_FIRST_PAGE()
    },
    clickLastPage() {
      this.CLICK_LAST_PAGE()
    }
  }
}
</script>

<style lang="scss" scoped>
  .p-nav-wrapper {
    padding: 0 25px;
    display: flex;
    justify-content: space-between;

    .p-nav-title {
      font-size: 50px;
      font-family: 'Indie Flower', cursive;
    }

    .p-nav-wrapper__search {
      display: flex;
      align-items: center;
      input {
        height: 1.5em;
        margin: 0;
        color: #ffffff;
      }
    }
  }


  .p-table-list {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
  }

  .p-asc {
    &::before {
      content:'arrow_drop_up';
      font-family: "Material Icons";
    }
  }
  .p-desc {
    &::before {
      content:'arrow_drop_down';
      font-family: "Material Icons";
    }
  }

  table {
    white-space:nowrap;

    tr {
      line-height: 0.5;
    }
  }

  .p-divide-list {
    width: 100%;

    &.is_show_detail {
      width: 65%;
    }
  }

  @media screen and (max-width: 960px) {
    .p-divide-list {
      &.is_show_detail {
        width: 100%;
      }
    }
  }

  .pagination {
    text-align: center;
    .active {
      background: #bdbdbd;
    }
  }

  .p-divide-trend-list {
    position: relative;
    width: 30%;
  }

  .p-close {
    position: absolute;
    top: 0;
    right: 0;
  }

  .p-brand-name--truncate {
    overflow:hidden;
    text-overflow: ellipsis;
    max-width: 250px;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity 2s;
  }

  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
</style>
