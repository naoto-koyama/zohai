<template>
  <div class="p-table-list">
    <table class="p-divide-list" :class="{ 'is_show_detail': is_show_detail }">
      <thead>
        <tr>
          <th :class="orderClass['code']" @click="sort('code') ">コード</th>
          <th :class="orderClass['name']" @click="sort('name')">銘柄</th>
          <th :class="orderClass['fiscal_year']" @click="sort('fiscal_year')">会計年度</th>
          <th :class="orderClass['indicated_dividend']" @click="sort('indicated_dividend')">配当金</th>
          <th :class="orderClass['payout_ratio']" @click="sort('payout_ratio')">配当性向</th>
          <th :class="orderClass['continuous_dividend_increase_years']" @click="sort('continuous_dividend_increase_years')">連続増配</th>
        </tr>
      </thead>
      <tbody>
        <tr class="hoverable" v-for="brand_latest_dividend in brand_latest_dividends.slice(0, 100)" :key="brand_latest_dividend.code"　@click="clickBrandName(brand_latest_dividend.id)">
          <td>{{brand_latest_dividend.code}}</td>
          <td class="p-brand-name--truncate" >{{brand_latest_dividend.name}}</td>
          <td>{{brand_latest_dividend.fiscal_year}}</td>
          <td>{{brand_latest_dividend.indicated_dividend}}</td>
          <td>{{brand_latest_dividend.payout_ratio}}</td>
          <td>{{brand_latest_dividend.continuous_dividend_increase_years}}</td>
        </tr>
      </tbody>
    </table>

    <transition name="fade">
      <div class="p-divide-trend-list" v-if="is_show_detail">
        <i class="material-icons p-close" @click="is_show_detail = !is_show_detail">close</i>
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
</template>

<script>
import axios from 'axios'
import _ from 'lodash'
export default {
  data: function () {
    return {
      brand_latest_dividends: [],
      dividend_trends: [],
      sort_column: '',
      sort_order: 'asc',
      orderClass: {
        code: {
          'p-asc': false,
          'p-desc': false
        },
        name: {
          'p-asc': false,
          'p-desc': false
        },
        fiscal_year: {
          'p-asc': false,
          'p-desc': false
        },
        indicated_dividend: {
          'p-asc': false,
          'p-desc': false
        },
        payout_ratio: {
          'p-asc': false,
          'p-desc': false
        },
        continuous_dividend_increase_years: {
          'p-asc': false,
          'p-desc': false
        }
      },
      is_show_detail: false
    }
  },
  mounted () {
    axios
      .get('/api/dividends.json')
      .then(response => {
        this.brand_latest_dividends = response.data
        this.sort('code')
      })
  },
  methods : {
    sort (select_column) {
      this.sort_order = this.getSortOrder(select_column === this.sort_column)
      this.modifyOrderClass(select_column)
      this.sort_column = select_column
      this.brand_latest_dividends = _.orderBy(this.brand_latest_dividends, this.sort_column, this.sort_order)
    },
    getSortOrder(isChangeOrder) {
      if (!isChangeOrder) {
        return 'asc'
      }
      return this.sort_order === 'asc' ? 'desc' : 'asc'
    },
    modifyOrderClass(order_column) {
      this.orderClass[this.sort_column] = {
        'p-asc': false,
        'p-desc': false
      }
      this.orderClass[order_column] = {
        'p-asc': this.sort_order === 'asc',
        'p-desc': this.sort_order === 'desc'
      }
    },
    clickBrandName(id) {
      axios
        .get('/api/dividend_trends/' + id + '.json')
        .then(response => {
          this.dividend_trends = response.data
        })
      this.is_show_detail = true
    }
  }
}
</script>

<style lang="scss" scoped>
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
