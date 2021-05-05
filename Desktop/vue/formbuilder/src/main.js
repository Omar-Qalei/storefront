import Vue from 'vue'
import App from './App.vue'
import './registerServiceWorker'
import router from './router'
import store from './store'
import gridLayout from './plugins/vue-gird-layout'
import './assets/css/styles.css'
import vuetify from './plugins/vuetify';
import 'roboto-fontface/css/roboto/roboto-fontface.css'
import '@mdi/font/css/materialdesignicons.css'

Vue.config.productionTip = false

new Vue({
  router,
  store,
  gridLayout,
  vuetify,
  render: h => h(App)
}).$mount('#app')
