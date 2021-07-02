<template>
  <div class="companies">
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
  </div>
</template>

<script>
import { ContactService } from "../../../services/contacts/contacts";
export default {
  name: "Companies",
  data() {
    return {
      tab: null,
      loading: true,
      show: false,
      selected: [],
      singleSelect: null,
      headers: [
        { text: "First Name", value: "first_name" },
        { text: "Last Name", value: "last_name" },
        { text: "Email", value: "email" },
        { text: "Job Title", value: "job_title" },
        { text: "Mobile", value: "mobile" },
        { text: "Address", value: "address" },
        { text: "Company ID", value: "company_id" },
        { text: "", value: "actions" },
      ],
      desserts: [],
    };
  },
  methods: {
    getContacts: function() {
      ContactService.getContacts()
        .then((result) => {
          const data = result.data.data.contacts.data || [];
          if (data.length > 0) this.desserts = data;
        })
        .catch((error) => console.log(error))
        .finally(() => {
          this.loading = false;
        });
    },
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
  created() {
    this.getContacts();
  },
};
</script>

<style></style>
