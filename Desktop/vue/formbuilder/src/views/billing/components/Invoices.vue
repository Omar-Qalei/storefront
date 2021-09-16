<template>
  <div class="Invoices" :loading="loading" v-if="loading === false">
       <v-row class="my-4"> 
      <v-col cols="12">
        <div class="text-xs-center col-12" v-if="desserts.length === 0">
           <h2 class="body-1" align="center">
              <v-icon disabled   size="75">mdi-receipt</v-icon>
              <p class="font-weight-light">
              Once you make a purchase, you'll find your
              </p>
               <p class="font-weight-light">
              payment history and invoices from Wimmly right here.
               </p>
          </h2></div>
           <v-data-table
           v-if="desserts.length !== 0"
          :headers="headers"
          :items="desserts" 
          sort-by="id"
          class="contact-listing-app">   
            <template v-slot:item.total="{ item }">
            <v-btn icon small>
                <v-chip  class="ma-2"  small color="info">{{ item.total }}</v-chip>
            </v-btn>
          </template>
          <template v-slot:item.actions="{ item }">
              <v-tooltip bottom>
                <template v-slot:activator="{on,attrs}">
                 <v-btn icon small>
                  <v-icon  @click="downloadInvoice(item)"
                   v-bind="attrs"
                   v-on="on">
                    mdi-download
                  </v-icon>
                </v-btn>
                </template>
                <span>Download Invoice</span>
              </v-tooltip> 
          </template>
        </v-data-table>
      </v-col>
    </v-row>
  </div>
</template>

<script> 
import { SubscriptionService } from "../../../services/billing/subscription.js"

  export default {
    name: "Invoices",
    data() {
      return {
        loading: true,
        number: null,
        date: null,
        status: null,
        total: null,
        url:null,
        headers: [
          { text: "Invoice Number", value: "number" },
          { text: "Date", value: "date" },
          { text: "Status", value: "status" },
          { text: "Payment Method", value: "payment_method" },
          { text: "Total Amount", value: "total" },
          { text: "Actions", value: "actions" },
        ],
        desserts: [],
      };
    }, 
    methods: {
      getInvoices: function () {
        SubscriptionService.getInvoices()
          .then((result) => {
            const data = result.data.data || [];
            if (data.length > 0) this.desserts = data;
          })
          .catch((error) => console.log(error))
          .finally(() => {
            this.loading = false;
          });
      },
        downloadInvoice: function(item) {
          window.open(item.url, '_blank');
      },   
    },
    created() {
      this.loading = true;
      this.getInvoices();
    },
  };
</script>

<style></style>