<template>
  <div>
    <page-header />
    <main class="l-main">
      <div class="p-search-list">
        <div class="p-search-list__item input-field" :style="{'--placeholder-color': this.fontColor}">
          <select multiple v-model="selectedMonth" @change="changeMonth()">
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
          <input type="text" placeholder="コード / 銘柄" v-model="searchText" @input="changeSearch()">
          <i class="material-icons">search</i>
        </div>
      </div>
      <div class="p-divide-list">
        <div class="c-card">
          <p class="c-card__title">銘柄リスト</p>
          <table class="highlight">
            <thead>
              <tr>
                <th class="name-column" :class="orderClass('name')" @click="sort('name')">銘柄</th>
                <th :class="orderClass('code')" @click="sort('code') ">コード</th>
                <th :class="orderClass('fiscal_year')" @click="sort('fiscal_year')">会計年度</th>
                <th :class="orderClass('indicated_dividend')" @click="sort('indicated_dividend')">配当金</th>
                <th :class="orderClass('payout_ratio')" @click="sort('payout_ratio')">配当性向</th>
                <th :class="orderClass('continuous_dividend_increase_years')" @click="sort('continuous_dividend_increase_years')">連続増配</th>
                <th :class="orderClass('close_stock_price')" @click="sort('close_stock_price')">前日終値</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="brandLatestDividend in brandLatestDividends" :key="brandLatestDividend.id" 　@click="clickBrandName(brandLatestDividend)" >
                <th>{{brandLatestDividend.name}}</th>
                <td data-label="コード">{{brandLatestDividend.code}}</td>
                <td data-label="会計年度">{{formatDateYYYYMM(brandLatestDividend.fiscal_year)}}</td>
                <td data-label="配当金">{{brandLatestDividend.indicated_dividend}}</td>
                <td data-label="配当性向">{{brandLatestDividend.payout_ratio}} %</td>
                <td data-label="連続増配">{{brandLatestDividend.continuous_dividend_increase_years}}年</td>
                <td data-label="前日終値">{{brandLatestDividend.close_stock_price}}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <ul class="pagination">
          <li class="pagination__item" :class="prevClass" @click="clickFirstPage()">
            <a class="pagination__link">
              <i class="material-icons">first_page</i>
            </a>
          </li>
          <li class="pagination__item" :class="prevClass" @click="clickPrev()">
            <a class="pagination__link">
              <i class="material-icons">navigate_before</i>
            </a>
          </li>
          <li>
            Page {{currentPage }}
          </li>
          <li class="pagination__item" :class="nextClass" @click="clickNext()">
            <a class="pagination__link">
              <i class="material-icons">navigate_next</i>
            </a>
          </li>
          <li class="pagination__item" :class="nextClass" @click="clickLastPage()">
            <a class="pagination__link">
              <i class="material-icons">last_page</i>
            </a>
          </li>
        </ul>
      </div>
    </main>
    <page-footer />
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import { T } from '../store/global-store/types.js'
import PageHeader from "../components/page_header"
import PageFooter from "../components/page_footer"

export default {
  components: {
    PageHeader,
    PageFooter
  },
  data ()  {
    return {
      fontColor: '#999999',
      selectedMonth: [],
      searchText: ''
    }
  },
  computed: {
    ...mapGetters({
      brandLatestDividends: 'getBrandLatestDividends',
      orderClass: 'getOrderClass',
      pagenateSliceNo: 'getPagenateSliceNo',
      nextClass: 'nextClass',
      prevClass: 'prevClass',
      currentPage: 'getCurrentPage',
      loading: 'getLoading'
    })
  },
  mounted () {
    // 参考: https://materializecss.com/select.html
    M.FormSelect.init(document.querySelectorAll('select'))
    this.LOAD_BRAND_LATEST_DIVIDEND()
  },
  methods : {
    ...mapActions(T),
    changeSearch() {
      this.CHANGE_SEARCH_CHAR(this.searchText)
    },
    changeMonth() {
      this.fontColor = this.selectedMonth.length === 0 ? '#999999': '#616161'
      this.CHANGE_MONTH(this.selectedMonth)
    },
    sort (sortColumn) {
      this.SORT_BRAND_LATEST_DIVIIEDEND(sortColumn)
    },
    clickBrandName(brandLatestDividend) {
      this.$router.push(`/brands/${brandLatestDividend.code}`)
    },
    clickPrev() {
      this.CLICK_PREV_PAGENATE()
    },
    clickNext() {
      this.CLICK_NEXT_PAGENATE()
    },
    clickFirstPage() {
      this.CLICK_FIRST_PAGE()
    },
    clickLastPage() {
      this.CLICK_LAST_PAGE()
    },
    formatDateYYYYMM(dateChar) {
      const year = dateChar.substr(0, 4)
      const month = dateChar.substr(5, 2)
      return year + month
    }
  }
}
</script>

<style lang="scss" scoped>
  @import '../../assets/stylesheets/foundation/_variables.scss';

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
      @media screen and (max-width: 600px) {
        display: none;
      }
    }
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

  .name-column {
    width:  40%;
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
</style>
