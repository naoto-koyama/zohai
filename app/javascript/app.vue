<template>
  <div>
    <table>
      <tbody>
        <tr>
          <th>コード</th>
          <th>銘柄</th>
        </tr>
        <tr v-for="company in companies" :key="company.id">
          <td>{{company.code}}</td>
          <td>{{company.name}}</td>
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
      .get('/api/dividends')
      .then(response => (this.companies = response.data))
  }
}
</script>

<style scoped>
</style>
