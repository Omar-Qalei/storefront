<template>
  <div class="main">
    <v-card class="pa-4">
      <v-tabs v-model="tab">
        <v-tabs-slider color="orange lighten-2"></v-tabs-slider>
        <v-tab>
          Subscriptions
        </v-tab>
        <v-tab>
          Billing History
        </v-tab>
             <v-tab>
          Payment Methods
        </v-tab>
      </v-tabs>
      <v-divider></v-divider>
      <v-tabs-items v-model="tab">
         <v-tab-item>
          <Subscription/>  
        </v-tab-item>
        <v-tab-item>
          <Invoices/>
        </v-tab-item>
        <v-tab-item>
          <PaymentMethods/>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
import Invoices from "./components/Invoices.vue"; 
import Subscription from "./components/Subscription.vue"; 
import PaymentMethods from "./components/PaymentMethods.vue"; 

export default {
  name: "Main",
  components: {
    Invoices,  
    Subscription,
    PaymentMethods
  },
  data() {
    return {
      tab: null,
      plan:null,
      hasPlans:null,
    };
  },
methods:{
  updateSelectedPlan(plan){ 
    this.plan= plan
    },
    showPlans(hasPlans){ 
    this.hasPlans = hasPlans;
    }
  }
};
</script>

<style></style>
