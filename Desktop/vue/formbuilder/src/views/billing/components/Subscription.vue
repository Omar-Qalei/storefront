<template>
  <div class="Subscriptions">
    <v-row class="my-4">
      <v-col cols="12">
        <div class="text-xs-center col-12" v-if="desserts.length === 0">
          <h2 class="body-1" align="center">
            <v-icon disabled size="75">mdi-clipboard-list-outline</v-icon>
            <p class="font-weight-light">
              You don’t have any active Premium subscriptions.
            </p>
            <p class="font-weight-light">
              Once you purchase a subscription, you'll find it right here.
            </p>
            <v-btn outlined color="primary" small @click="goToPath('plans')"
              >Plans</v-btn
            >
          </h2>
        </div>
        <v-data-table
          v-if="desserts.length !== 0"
          :headers="headers"
          :items="desserts"
          sort-by="id"
          class="contact-listing-app"
        >
          <template v-slot:item.subscription_start_time="{ item }">
            <v-btn icon small>
              <v-chip class="ma-2" small color="primary">{{
                item.subscription_start_time
              }}</v-chip>
            </v-btn>
          </template>
          <template v-slot:item.subscription_end_time="{ item }">
            <v-btn icon small>
              <v-chip class="ma-2" small color="primary">{{
                item.subscription_end_time
              }}</v-chip>
            </v-btn>
          </template>
          <template v-slot:item.status_description="{ item }">
            <v-btn icon small>
              <v-chip class="ma-2" small color="info">{{
                item.status_description
              }}</v-chip>
            </v-btn>
          </template>
        </v-data-table>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import { SubscriptionService } from "../../../services/billing/subscription.js";
export default {
  name: "Subscription",
  data() {
    return {
      tab: null,
      loading: true,
      addDialog: false,
      editDialog: false,
      selected: [],
      singleSelect: false,
      subscription_start_time: null,
      subscription_end_time: null,
      status: null,
      status_description: null,
      package: null,
      subscriptionId: null,
      headers: [
        { text: "Package", value: "package.name" },
        { text: "Starts at", value: "subscription_start_time" },
        { text: "Renew at", value: "subscription_end_time" },
        { text: "Status", value: "status_description" },
        { text: "", value: "actions" },
      ],
      desserts: [],
    };
  },
  methods: {
    getSubscriptions: function() {
      SubscriptionService.getSubscriptions()
        .then((result) => {
          const data = result.data.data || [];
          if (data.length > 0) this.desserts = data;
        })
        .catch((error) => console.log(error))
        .finally(() => {
          this.loading = false;
        });
    },
    goToPath: function(path) {
      console.log(path);
      this.$emit("goToPath", path);
    },
  },
  created() {
    this.getSubscriptions();
  },
};
</script>

<style></style>
