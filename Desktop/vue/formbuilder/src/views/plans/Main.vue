<template>
  <div class="main">
      <Plans v-if="plan === null" @updateSelectedPlan="updateSelectedPlan"/>
      <Checkout v-if="plan !== null" :plan="plan"/>
  </div>
</template>

<script>
import Plans from "./components/Plans.vue"; 
import Checkout from "./components/Checkout.vue"; 

export default {
  name: "Main",
  components: {
    Plans,  
    Checkout
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
