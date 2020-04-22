<template>
  <div>
    <spinner :loading="loading" />
    <transition name="fade">
      <div v-show="!loading">
        <page-header />
        <main class="l-main">
          <div class="p-search-list">
            <div class="p-search-list__item input-field" :style="{'--placeholder-color': this.font_color}">
              <select multiple v-model="selected_month" @change="change_month()">
                <option value="" disabled style="align-text: center;">配当月</option>
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
            <div class="p-search-list__item p-search-text ">
              <input type="text" placeholder="コード / 銘柄" v-model="search_text" @input="changeSearch()">
              <i class="material-icons">search</i>
            </div>
          </div>
          <div class="p-table-list">
            <div class="p-divide-list" :class="{ 'is-show-detail': is_show_detail }">
              <div class="c-card">
                <p class="c-card__title">銘柄リスト</p>
                <table class="highlight">
                  <thead>
                    <tr>
                      <th class="name-column" :class="order_class('name')" @click="sort('name')">銘柄</th>
                      <th :class="order_class('code')" @click="sort('code') ">コード</th>
                      <th :class="order_class('fiscal_year')" @click="sort('fiscal_year')">会計年度</th>
                      <th :class="order_class('indicated_dividend')" @click="sort('indicated_dividend')">配当金</th>
                      <th :class="order_class('payout_ratio')" @click="sort('payout_ratio')">配当性向</th>
                      <th :class="order_class('continuous_dividend_increase_years')" @click="sort('continuous_dividend_increase_years')">連続増配</th>
                      <th :class="order_class('close_stock_price')" @click="sort('close_stock_price')">前日終値</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="brand_latest_dividend in brand_latest_dividends" :key="brand_latest_dividend.id"　@click="clickBrandName(brand_latest_dividend)">
                      <th>{{brand_latest_dividend.name}}</th>
                      <td data-label="コード">{{brand_latest_dividend.code}}</td>
                      <td data-label="会計年度">{{brand_latest_dividend.fiscal_year}}</td>
                      <td data-label="配当金">{{brand_latest_dividend.indicated_dividend}}</td>
                      <td data-label="配当性向">{{brand_latest_dividend.payout_ratio}} %</td>
                      <td data-label="連続増配">{{brand_latest_dividend.continuous_dividend_increase_years}}年</td>
                      <td data-label="前日終値">{{brand_latest_dividend.close_stock_price}}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <ul class="pagination">
                <li class="pagination__item" :class="prev_class" @click="clickFirstPage()">
                  <a class="pagination__link">
                    <i class="material-icons">first_page</i>
                  </a>
                </li>
                <li class="pagination__item" :class="prev_class" @click="clickPrev()">
                  <a class="pagination__link">
                    <i class="material-icons">navigate_before</i>
                  </a>
                </li>
                <li>
                  Page {{current_page }}
                </li>
                <li class="pagination__item" :class="next_class" @click="clickNext()">
                  <a class="pagination__link">
                    <i class="material-icons">navigate_next</i>
                  </a>
                </li>
                <li class="pagination__item" :class="next_class" @click="clickLastPage()">
                  <a class="pagination__link">
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
import Spinner from "./component/spinner"
import PageHeader from "./component/page_header"
import PageFooter from "./component/page_footer"

export default {
  components: {
    Spinner,
    PageHeader,
    PageFooter
  },
  data ()  {
    return {
      select_brand_dividend: '',
      font_color: '#999999',
      selected_month: [],
      search_text: ''
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
    changeSearch() {
      this.CHANGE_SEARCH_CHAR(this.search_text)
    },
    change_month() {
      this.font_color = this.selected_month.length === 0 ? '#999999': '#616161'
      this.CHANGE_MONTH(this.selected_month)
    },
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
  @import '../assets/stylesheets/foundation/_variables.scss';

  .p-search-list {
    display: flex;
    align-items: stretch;
    margin: 0 auto 10px;
    max-width: 50%;
    min-width: 40%;
    @media screen and (max-width: 600px) {
      flex-direction: column;
    }

    &__item {
      margin: 0 10px 0 0;
      width: calc((100% - 10px) / 2);
      border-radius: 5px;
      background: #f5f5f5;
      @media screen and (max-width: 600px) {
        width: 100%;
        margin: 0 0 10px 0;
      }

      &:last-child {
        margin: 0;
      }
    }

    .input-field {
      --placeholder-color: $input-focus-color;

      /deep/
      .select-wrapper {
        height: 100%;

        input.select-dropdown {
          padding: 0 10px;
          margin: 0;
          text-overflow: ellipsis;
          color: var(--placeholder-color);
          border: none;

          @media screen and (max-width: 600px) {
            font-size: 14px;
          }
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
        margin: 0;
        padding: 0 10px;
        color: #616161;
        font-family: 'Noto Sans JP', 'Roboto', sans-serif;
        border: none;

        @media screen and (max-width: 600px) {
          font-size: 14px;
        }

        &::placeholder {
          color: #999999;
        }
        &:focus {
          border: none;
        }

      }
      .material-icons {
        color: #999999;
      }
    }
  }

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
    table-layout: fixed;
    white-space:nowrap;
    overflow-x: auto;

    thead > tr {
      border-bottom: 3px solid rgba(0, 0, 0, 0.12);
      border-top: 3px solid rgba(0, 0, 0, 0.12);
      margin: 15px 0;
    }

    th, td {
      overflow:hidden;
      text-overflow: ellipsis;
    }

    .name-column {
      width:  40%;
    }

    tr {
      line-height: 0.5;
    }
  }

  @media screen and (max-width: 600px) {
    .c-card__title {
      display: none;
    }
    table {
      border: 0;
      width:100%
    }
    table th{
      background-color: #eee;
      display: block;
      border-right: none;
    }
    table thead {
      border: none;
      clip: rect(0 0 0 0);
      height: 1px;
      margin: -1px;
      overflow: hidden;
      padding: 0;
      position: absolute;
      width: 1px;
      background-color: black;
    }

    table tr {
      display: block;
      margin-bottom: .625em;
    }

    table td {
      border-bottom: 1px solid #bbb;
      display: block;
      font-size: .8em;
      text-align: right;
      position: relative;
      padding: .625em .625em .625em 4em;
      border-right: none;
    }

    table td::before {
      content: attr(data-label);
      font-weight: bold;
      position: absolute;
      left: 10px;
    }

    table td:last-child {
      border-bottom: 0;
    }
  }

  .p-divide-list {
    width: 100%;

    &.is-show-detail {
      width: calc(70% - 20px);
    }
  }

  .p-divide-trend-list {
    position: relative;
    width: calc(30% - 20px);
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

    &__item {
      line-height: 100%;
      height: 100%;
    }

    &__link {
      line-height: 100%;
      padding: 0 5px;
    }

    .active {
      background: #bdbdbd;
    }
  }

  .p-close {
    position: absolute;
    top: 0;
    right: 0;
  }

  .fade-enter-active {
    transition: opacity 2s;
  }

  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
</style>
