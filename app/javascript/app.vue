<template>
  <div>
    <table>
      <tbody>
        <tr>
          <th>コード</th>
          <th>銘柄</th>
          <th>会計年度</th>
          <th>配当金</th>
          <th>連続増配年数</th>
        </tr>
        <tr v-for="company in companies" :key="company.id">
          <td>{{company.code}}</td>
          <td>{{company.name}}</td>
          <td>{{company.latest_fiscal_year}}</td>
          <td>{{company.latest_dividend}}</td>
          <td>{{company.continuous_dividend_increase_years}}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data: function () {
    return {
      companies: []
    }
  },
  mounted () {
    axios
      .get('/api/dividends.json')
      .then(response => (this.companies = response.data))
  }
}
</script>

<style scoped>
</style>
