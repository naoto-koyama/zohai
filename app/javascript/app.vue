<template>
  <div>
    <spinner :loading="loading" />
    <transition name="fade">
      <div v-show="!loading">
        <page-header />
        <main class="l-main">
          <div class="p-table-list">
            <div class="c-card p-divide-list" :class="{ 'is-show-detail': is_show_detail }">
              <p class="c-card__title">銘柄リスト</p>
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
                  <tr class="hoverable" v-for="brand_latest_dividend in brand_latest_dividends" :key="brand_latest_dividend.id"　@click="clickBrandName(brand_latest_dividend)">
                    <td>{{brand_latest_dividend.code}}</td>
                    <td class="p-brand-name--truncate" >{{brand_latest_dividend.name}}</td>
                    <td>{{brand_latest_dividend.fiscal_year}}</td>
                    <td>{{brand_latest_dividend.indicated_dividend}}</td>
                    <td>{{brand_latest_dividend.payout_ratio}} %</td>
                    <td>{{brand_latest_dividend.continuous_dividend_increase_years}}年</td>
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
              <div class="c-card p-divide-trend-list" v-if="is_show_detail">
                <p class="c-card__title">{{trend_list_title}}</p>
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
                      <td>{{dividend_trend.payout_ratio}} %</td>
                      <td>{{dividend_trend.continuous_dividend_increase_years}}年</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </transition>
          </div>
        </main>
        <page-footer />
      </div>
    </transition>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { T } from './store/global-store/types.js'
import Spinner from "./component/spinner";
import PageHeader from "./component/page_header";
import PageFooter from "./component/page_footer";
export default {
  components: {
    Spinner,
    PageHeader,
    PageFooter
  },
  data ()  {
    return {
      select_brand_dividend: ''
    }
  },
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
      current_page: 'getCurrentPage',
      loading: 'getLoading'
    }),
    trend_list_title() {
      return this.select_brand_dividend.code + ' : ' + this.select_brand_dividend.name
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
    clickBrandName(brand_latest_dividend) {
      this.select_brand_dividend = brand_latest_dividend
      this.GET_DIVIDEND_TREND(brand_latest_dividend.id)
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
  .c-card {
    &__title {
      padding: 10px;
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

    thead > tr {
      border-bottom: 3px solid rgba(0, 0, 0, 0.12);
      border-top: 3px solid rgba(0, 0, 0, 0.12);
    }
    tr {
      line-height: 0.5;
    }
  }

  .p-divide-list {
    width: 100%;

    &.is-show-detail {
      width: 65%;
    }
  }

  .p-divide-trend-list {
    position: relative;
    width: 30%;
  }

  @media screen and (max-width: 960px) {
    .p-divide-list {
      &.is-show-detail {
        width: 100%;
        margin: 0 0 20px;
      }
    }

    .p-divide-trend-list {
      position: relative;
      width: 100%;
    }
  }

  .pagination {
    text-align: center;
    .active {
      background: #bdbdbd;
    }
  }

  .p-close {
    position: absolute;
    top: 0;
    right: 0;
  }

  .p-brand-name--truncate {
    overflow:hidden;
    text-overflow: ellipsis;
    max-width: 100px;
  }

  .fade-enter-active {
    transition: opacity 2s;
  }

  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
</style>
