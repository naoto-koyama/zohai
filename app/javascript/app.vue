<template>
  <div>
    <table>
      <thead>
        <tr>
          <th @click="sort('code')">コード</th>
          <th @click="sort('name')">銘柄</th>
          <th @click="sort('latest_fiscal_year')">会計年度</th>
          <th @click="sort('latest_dividend')">配当金</th>
          <th @click="sort('payout_ratio')">配当性向</th>
          <th @click="sort('continuous_dividend_increase_years')">連続増配年数</th>
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
      sort_order: 'asc'
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
      this.sort_column = select_column
      this.companies = _.orderBy(this.companies, this.sort_column, this.sort_order)
    },
    getSortOrder(isChangeOrder) {
      if (!isChangeOrder) return this.sort_order
      return this.sort_order === 'asc' ? 'desc' : 'asc'
    }
  }
}
</script>

<style scoped>
</style>
