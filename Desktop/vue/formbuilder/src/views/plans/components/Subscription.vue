<template>
  <div class="Subscriptions"> 
    <v-row class="my-4"> 
      <v-col cols="12">
        <div class="text-xs-center col-12">
           <h2 class="body-1" align="center">
              <v-icon disabled   size="75">mdi-clipboard-list-outline</v-icon>
              <p class="font-weight-light">
              You don’t have any active Premium subscriptions.
              </p>
               <p class="font-weight-light">
              Once you purchase a subscription, you'll find it right here.
               </p>
            <v-btn outlined color="primary" small  @click="showPlans()" >Plans</v-btn>
          </h2>
           <v-data-table
          :headers="headers"
          :items="desserts"
          sort-by="id"
          class="contact-listing-app"
          :search="search"
        >
          <template v-slot:top>
            <v-toolbar flat class="mb-8">
              <v-row>
                <v-col cols="12" lg="6">
                  <v-text-field
                    v-model="search"
                    append-icon="mdi-magnify"
                    label="Search Contacts"
                    filled
                    background-color="transparent"
                    hide-details
                  ></v-text-field>
                </v-col>
              </v-row>

              <v-spacer></v-spacer>
              <v-dialog v-model="dialog" max-width="700">
                <template v-slot:activator="{ on }">
                  <v-btn
                    color="primary"
                    dark
                    class="mb-2 text-capitalize"
                    v-on="on"
                  >
                    <v-icon class="mr-2">mdi-account-multiple-plus</v-icon>New
                    Contact
                  </v-btn>
                </template>
                <v-card>
                  <v-card-title class="pa-4 info">
                    <span class="title white--text">{{ formTitle }}</span>
                  </v-card-title>

                  <v-card-text>
                    <v-container>
                      <v-row>
                        <v-col cols="12" sm="6">
                          <v-text-field
                            outlined
                            hide-details
                            v-model="editedItem.id"
                            label="Id"
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6">
                          <v-text-field
                            outlined
                            hide-details
                            v-model="editedItem.userinfo"
                            label="User info"
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6">
                          <v-text-field
                            outlined
                            hide-details
                            v-model="editedItem.usermail"
                            label="User email"
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6">
                          <v-text-field
                            outlined
                            hide-details
                            v-model="editedItem.phone"
                            label="Phone"
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6">
                          <v-text-field
                            outlined
                            hide-details
                            v-model="editedItem.jdate"
                            label="Joining Date"
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6">
                          <v-text-field
                            outlined
                            hide-details
                            v-model="editedItem.role"
                            label="Role"
                          ></v-text-field>
                        </v-col>
                      </v-row>
                    </v-container>
                  </v-card-text>

                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="error" dark @click="close">Cancel</v-btn>
                    <v-btn color="success" dark @click="save">Save</v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </v-toolbar>
          </template>
          <template v-slot:item.id="{ item }">
            <v-chip pill>{{ item.id }}</v-chip>
          </template>
          <template v-slot:item.userinfo="{ item }">
            <div class="d-flex align-center">
              <div class="ml-5">
                <h4>{{ item.userinfo }}</h4>
                <span class="subtitle-2 d-block font-weight-regular">{{
                  item.usermail
                }}</span>
              </div>
            </div>
          </template>
          <template v-slot:item.role="{ item }">
            <v-chip :color="item.rolestatus" label>{{ item.role }}</v-chip>
          </template>
          <template v-slot:item.actions="{ item }">
            <v-icon small class="mr-2 info--text" @click="editItem(item)"
              >mdi-pencil</v-icon
            >
            <v-icon small class="error--text" @click="deleteItem(item)"
              >mdi-delete</v-icon
            >
          </template>
          <template v-slot:no-data>
            <v-btn color="primary" @click="initialize">Reset</v-btn>
          </template>
        </v-data-table>
         </div>
      </v-col>
    </v-row>
    <!-- Add Subscription -->
    <v-dialog v-model="addDialog" width="500">
      <v-card>
        <v-card-title class="text-h5 grey lighten-2">
          Add Subscription
        </v-card-title>

        <v-card-text>
          <v-row class="mt-4">
            <v-col cols="12" sm="6">
              <v-text-field
                label="Domain"
                v-model="domain"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Mobile"
                v-model="mobile"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Address"
                v-model="address"
                outlined
              ></v-text-field>
            </v-col>
          </v-row>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="red" text @click="addDialog = false">
            Cancel
          </v-btn>
          <v-btn color="primary" text @click="addSubscription()">
            Add
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Add Subscription -->
    <!-- Edit Subscription -->
    <v-dialog v-model="editDialog" width="500">
      <v-card>
        <v-card-title class="text-h5 grey lighten-2">
          Modify Subscription
        </v-card-title>

        <v-card-text>
          <v-row class="mt-4">
            <v-col cols="12" sm="6">
              <v-text-field
                label="Domain"
                v-model="domain"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Mobile"
                v-model="mobile"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Address"
                v-model="address"
                outlined
              ></v-text-field>
            </v-col>
          </v-row>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="red" text @click="editDialog = false">
            Cancel
          </v-btn>
          <v-btn color="primary" text @click="modifySubscription()">
            Modify
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Edit Subscription -->
  </div>
</template>

<script>
import { SubscriptionsService } from "../../../services/billing/subscription.js"
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
      package: null,
      payment_method: null,
      subscriptionId: null,
      headers: [
        { text: "Package", value: "package" },
        { text: "Starts at", value: "subscription_start_time" },
        { text: "Renew at", value: "subscription_end_time" },
        { text: "Payment Method", value: "payment_method" },
        { text: "Status", value: "status" },
        { text: "", value: "actions" },
      ],
      desserts: [],
    };
  },
  methods: {
    getSubscriptions: function() {
      SubscriptionsService.getSubscriptions()
        .then((result) => {
          const data = result.data.data || [];
          console.log(data);
        })
        .catch((error) => console.log(error))
        .finally(() => {
          this.loading = false;
        });
    }, 
    showSubscription: function(item) {
      this.domain = item.domain;
      this.mobile = item.mobile;
      this.address = item.address;
      this.editDialog = true;
    },
    modifySubscription: function() {
      const data = {
        domain: this.domain,
        mobile: this.mobile,
        address: this.address,
      };
      SubscriptionsService.modifySubscription(this.contactId, data)
        .then((result) => {
          console.log(result);
          this.getSubscriptions();
          this.editDialog = false;
        })
        .catch((error) => console.log(error));
    },
    showPlans(){
      this.$emit("showPlans",true);
    },
  },
  created() {
    this.getSubscriptions();
  },
};
</script>

<style></style>
