<template>
  <div class="sites">
    <v-card class="pa-4">
      <v-tabs v-model="tab">
        <v-tabs-slider color="orange lighten-2"></v-tabs-slider>

        <v-tab>
          Contacts
        </v-tab>
        <v-tab>
          Companies
        </v-tab>
      </v-tabs>
      <v-divider></v-divider>
      <v-tabs-items v-model="tab">
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-row class="my-4" align="center">
                <h2 class="body-1">
                  View all interactions with this contact’s company in one place
                </h2>
                <v-spacer></v-spacer>
                <v-btn outlined color="primary"
                  ><v-icon>mdi-plus</v-icon> Contact</v-btn
                >
              </v-row>
            </v-card-text>
          </v-card>
          <v-row class="my-4">
            <v-col cols="12">
              <v-data-table
                v-model="selected"
                :headers="headers"
                :items="desserts"
                :single-select="singleSelect"
                item-key="name"
                show-select
              >
                <template v-slot:item.actions="{ item }">
                  <v-icon small class="mr-2" @click="editItem(item)">
                    mdi-pencil
                  </v-icon>
                </template>
              </v-data-table>
            </v-col>
          </v-row>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-row class="my-4" align="center">
                <h2 class="body-1">
                  View all interactions with this Companies in one place
                </h2>
                <v-spacer></v-spacer>
                <v-btn outlined color="primary"
                  ><v-icon>mdi-plus</v-icon> Company</v-btn
                >
              </v-row>
            </v-card-text>
          </v-card>
          <v-row class="my-4">
            <v-col cols="12">
              <v-data-table
                v-model="selected"
                :headers="headers"
                :items="desserts"
                :single-select="singleSelect"
                item-key="name"
                show-select
              >
                <template v-slot:item.actions="{ item }">
                  <v-icon small class="mr-2" @click="editItem(item)">
                    mdi-pencil
                  </v-icon>
                  <v-icon small @click="deleteItem(item)">
                    mdi-delete
                  </v-icon>
                </template>
              </v-data-table>
            </v-col>
          </v-row>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
// import { SiteService } from "../../services/site/site";
export default {
  name: "Contacts",
  data() {
    return {
      tab: null,
      show: false,
      selected: [],
      headers: [
        { text: "Name", value: "name" },
        { text: "Email", value: "email" },
        { text: "Job Title", value: "jobTitle" },
        { text: "Mobile", value: "mobile" },
        { text: "Address", value: "address" },
        { text: "", value: "actions" },
      ],
      desserts: [
        {
          name: "Omar Qalei",
          email: "Omar-Qalei@test.com",
          jobTitle: "Software Developer",
          mobile: "+962795011227",
          address: "Amman, Jordan",
        },
        {
          name: "Omar Qalei",
          email: "Omar-Qalei@test.com",
          jobTitle: "Software Developer",
          mobile: "+962795011227",
          address: "Amman, Jordan",
        },
        {
          name: "Omar Qalei",
          email: "Omar-Qalei@test.com",
          jobTitle: "Software Developer",
          mobile: "+962795011227",
          address: "Amman, Jordan",
        },
      ],
    };
  },
  methods: {
    editItem(item) {
      console.log(item);
    },
    deleteItem(item) {
      console.log(item);
    },
    // addSite: function() {
    //   const data = {
    //     domain: "welcomejor",
    //     name: "Our Office",
    //   };
    //   SiteService.addSite(data);
    // },
  },
};
</script>

<style></style>
