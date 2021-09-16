<template>
  <div class="plans">
    <v-card   :loading="loading">
      <v-card-title class="text-center justify-center py-6">
        <h4 class="font-weight-bold text-h4 basil--text">
          Select Premium Plan
        </h4>
      </v-card-title> 
      <v-tabs v-model="tab" background-color="transparent" grow>
        <v-tab>
          Yearly
        </v-tab>
        <v-tab>
          Monthly
        </v-tab>
      </v-tabs>

      <v-tabs-items v-model="tab">
        <v-tab-item>
          <v-row class="mx-4 my-4" align="center" justify="center">
            <v-col v-for="plan in plans"  :activePlan="activePlan" @click="updateActivePlan(plan,1)" :key="plan.id" class="col-3">
             <v-card   max-width="250" min-height="400"  class="mx-auto">
              <v-card-text>
              <v-row align="center" justify="center">
                <v-card-title class="m-4">
                  {{ plan.name }}
                </v-card-title>
                <div v-if="activePlan.id === plan.id" class="p-2">
                  <svg width="25px" height="25px" viewBox="0 0 200 200" version="1.1" xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink">
                    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                      <g id="checkmark-outline" fill-rule="nonzero">
                        <path
                          d="M31.1442786,171.840796 C5.2779518,146.858262 -5.09578082,109.862896 4.01023318,75.0738981 C13.1162472,40.2848999 40.2848999,13.1162472 75.0738981,4.01023318 C109.862896,-5.09578082 146.858262,5.2779518 171.840796,31.1442786 C209.549474,70.1869539 209.010186,132.247241 170.628714,170.628714 C132.247241,209.010186 70.1869539,209.549474 31.1442786,171.840796 Z"
                          id="Shape" fill="#97EBDC"></path>
                        <polygon id="Path" fill="#00836D"
                          points="66.6666667 89.4527363 89.5522388 112.437811 132.338308 69.6517413 146.268657 83.7810945 89.5522388 140.298507 52.7363184 103.482587 66.6666667 89.3532338">
                        </polygon>
                      </g>
                    </g>
                  </svg>
                </div>
              </v-row>
              <v-row align="center" justify="center">
                <div class="my-2  text-subtitle-1">
                  Yearly {{ plan.price_yearly }}
                </div>
              </v-row>
              <v-row align="center" justify="center">
                <div class="my-2    text-subtitle-1">
                  <v-badge :content="plan.number_of_sites"><strong>Sites</strong></v-badge>
                </div>
              </v-row>
            </v-card-text>
            <v-divider class="mx-4"></v-divider>
            <v-card-text>
              <div>{{ plan.description.slice(0, 100) }}</div>
                <div class="row my-2">
                  <div class="text-center col-12">
                    <v-btn class="ma-2" @click="updateCheckoutPlan()" outlined color="indigo"> Order now</v-btn>
                  </div>
                </div>
            </v-card-text>
          </v-card>
          </v-col>
          </v-row>
        </v-tab-item>
           <v-tab-item>
          <v-row class="mx-4 my-4" align="center" justify="center">
          <v-col v-for="plan in plans"  :activePlan="activePlan" @click="updateActivePlan(plan,0)" :key="plan.id" class="col-3 py-4">
           <v-card max-width="250" min-height="400"  class="mx-auto">
            <v-card-text>
              <v-row align="center" justify="center">
                <v-card-title class="m-4">
                  {{ plan.name }}
                </v-card-title>
                <div v-if="activePlan.id === plan.id" class="p-2">
                  <svg width="25px" height="25px" viewBox="0 0 200 200" version="1.1" xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink">
                    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                      <g id="checkmark-outline" fill-rule="nonzero">
                        <path
                          d="M31.1442786,171.840796 C5.2779518,146.858262 -5.09578082,109.862896 4.01023318,75.0738981 C13.1162472,40.2848999 40.2848999,13.1162472 75.0738981,4.01023318 C109.862896,-5.09578082 146.858262,5.2779518 171.840796,31.1442786 C209.549474,70.1869539 209.010186,132.247241 170.628714,170.628714 C132.247241,209.010186 70.1869539,209.549474 31.1442786,171.840796 Z"
                          id="Shape" fill="#97EBDC"></path>
                        <polygon id="Path" fill="#00836D"
                          points="66.6666667 89.4527363 89.5522388 112.437811 132.338308 69.6517413 146.268657 83.7810945 89.5522388 140.298507 52.7363184 103.482587 66.6666667 89.3532338">
                        </polygon>
                      </g>
                    </g>
                  </svg>
                </div>
              </v-row>
              <v-row align="center" justify="center">
                <div class="mt-4 text-subtitle-1">
                  Monthly {{ plan.price_monthly }}
                </div>
              </v-row>
              <v-row align="center" justify="center">
                <div class="my-2    text-subtitle-1">
                  <v-badge :content="plan.number_of_sites"><strong>Sites</strong></v-badge>
                </div>
              </v-row>
            </v-card-text>
            <v-divider class="mx-4"></v-divider>
            <v-card-text>
              <div>{{ plan.description.slice(0, 100) }}</div>
                <div class="row my-2">
                  <div class="text-center col-12">
                    <v-btn class="ma-2" @click="updateCheckoutPlan()" outlined color="indigo"> Order now</v-btn>
                  </div>
                </div>
            </v-card-text>
          </v-card>
          </v-col>
          </v-row>
        </v-tab-item>
      </v-tabs-items>
  </v-card>
  </div>
</template>

<script>
  import {
    PlanService
  } from "../../../services/billing/plans";
  export default {
    name: "Plans",
    data() {
      return {
        tab: null,
        loading: true,
        activePlan :'',
        PlanId: null,
        plans: [],
        type:null,
        items: [
          'yearly', 'monthly'
        ],
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      };
    }, 
    methods: {
      getPlans: function () {
        PlanService.getPlans()
          .then((result) => {
            const data = result.data.data || [];
            if (data.length > 0) this.plans = data;
          })
          .catch((error) => console.log(error))
          .finally(() => {
            this.loading = false;
          });
      },
      updateActivePlan(plan,type){
        this.activePlan = plan;
        this.activePlan.type = type;
      },
      updateCheckoutPlan(){
        this.$emit("updateSelectedPlan",this.activePlan);
      },
      showPlan: function (item) {
        this.name = item.name;
        this.priceMonthly = item.price_monthly;
        this.priceYearly = item.price_yearly;
        this.currency = item.currency;
        this.numberOfSites = item.number_of_sites;
        this.description = item.description;
        this.PlanId = item.id;
      },
    },
    created() {
      this.loading = true;
      this.getPlans();
    },
  };
</script>

<style></style>