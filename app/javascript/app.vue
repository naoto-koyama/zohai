<template>
  <div>
    <table>
      <thead>
        <tr>
          <th :class="orderClass['code']" @click="sort('code') ">コード</th>
          <th :class="orderClass['name']" @click="sort('name')">銘柄</th>
          <th :class="orderClass['latest_fiscal_year']" @click="sort('latest_fiscal_year')">会計年度</th>
          <th :class="orderClass['latest_dividend']" @click="sort('latest_dividend')">配当金</th>
          <th :class="orderClass['payout_ratio']" @click="sort('payout_ratio')">配当性向</th>
          <th :class="orderClass['continuous_dividend_increase_years']" @click="sort('continuous_dividend_increase_years')">連続増配年数</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="brand_latest_dividend in brand_latest_dividends.slice(0, 100)" :key="brand_latest_dividend.code">
          <td>{{brand_latest_dividend.code}}</td>
          <td>{{brand_latest_dividend.name}}</td>
          <td>{{brand_latest_dividend.fiscal_year}}</td>
          <td>{{brand_latest_dividend.indicated_dividend}}</td>
          <td>{{brand_latest_dividend.payout_ratio}}</td>
          <td>{{brand_latest_dividend.continuous_dividend_increase_years}}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios'
import _ from 'lodash'
export default {
  data: function () {
    return {
      brand_latest_dividends: [],
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
        latest_fiscal_year: {
          'p-asc': false,
          'p-desc': false
        },
        latest_dividend: {
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
      }

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
    }
  }
}
</script>

<style lang="scss" scoped>
  .p-asc {
    &::before {
      content: '▲';
    }
  }
  .p-desc {
    &::before {
      content: '▼';
    }
  }
</style>
