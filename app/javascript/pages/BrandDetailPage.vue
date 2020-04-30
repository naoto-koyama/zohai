<template>
  <div>
    <page-header />
    <main class="l-main">
      <div class="c-card p-divide-trend-list">
        <p class="c-card__title">{{trendListTitle}}</p>
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
            <tr v-for="dividendTrend in dividendTrends" :v-key="dividendTrend.fiscal_year">
              <td>{{formatDateYYYYMM(dividendTrend.fiscal_year)}}</td>
              <td>{{dividendTrend.indicated_dividend}}</td>
              <td>{{dividendTrend.payout_ratio}} %</td>
              <td>{{dividendTrend.continuous_dividend_increase_years}}年</td>
            </tr>
          </tbody>
        </table>
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
  computed: {
    ...mapGetters({
      brand: 'getBrand',
      dividendTrends: 'getDividendTrends',
      loading: 'getLoading'
    }),
    trendListTitle() {
      console.log(this.brand)
      return `${this.brand.code} : ${this.brand.name}`
    }
  },
  mounted () {
    this.LOAD_DIVIDEND_TRENDS(this.$route.params.id)
  },
  methods : {
    ...mapActions(T),
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
  .c-card {
    &__title {
      padding: 10px;
      @media screen and (max-width: 600px) {
        display: none;
      }
    }
  }
</style>
