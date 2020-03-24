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
        <tr v-for="company in companies" :key="company.code">
          <td>{{company.code}}</td>
          <td>{{company.name}}</td>
          <td>{{company.latest_fiscal_year}}</td>
          <td>{{company.latest_dividend}}</td>
          <td>{{company.payout_ratio}}</td>
          <td>{{company.continuous_dividend_increase_years}}</td>
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
      companies: [],
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
        this.companies = response.data
        this.sort('code')
      })
  },
  methods : {
    sort (select_column) {
      this.sort_order = this.getSortOrder(select_column === this.sort_column)
      this.modifyOrderClass(select_column)
      this.sort_column = select_column
      this.companies = _.orderBy(this.companies, this.sort_column, this.sort_order)
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
