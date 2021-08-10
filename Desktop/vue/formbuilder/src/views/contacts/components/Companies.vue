<template>
  <div class="companies">
    <v-card flat>
      <v-card-text>
        <v-row class="my-4" align="center">
          <h2 class="body-1">
            View all interactions with this Companies in one place
          </h2>
          <v-spacer></v-spacer>
          <v-btn outlined color="primary" @click="addDialog = true"
            ><v-icon>mdi-plus</v-icon> Company</v-btn
          >
        </v-row>
      </v-card-text>
    </v-card>
    <v-row class="my-4">
      <v-col cols="12">
        <v-btn class="text-capitalize" text @click="removeCompanies()">
          <v-icon>mdi-delete-outline</v-icon>
          Companies
        </v-btn>
      </v-col>
      <v-col cols="12">
        <v-data-table
          v-model="selected"
          :headers="headers"
          :items="desserts"
          :expanded.sync="expanded"
          :single-select="singleSelect"
          item-key="domain"
          show-expand
          show-select
          :loading="loading"
          loading-text="Loading... Please wait"
        >
          <template v-slot:item.actions="{ item }">
            <v-icon small class="mr-2" @click="showCompany(item)">
              mdi-pencil
            </v-icon>
          </template>
          <template v-slot:expanded-item="{ headers, item }">
            <td :colspan="headers.length">
              More info about {{ item.description }}
            </td>
          </template>
        </v-data-table>
      </v-col>
    </v-row>
    <!-- Add Company -->
    <v-dialog v-model="addDialog" width="500">
      <v-card>
        <v-card-title class="text-h5 grey lighten-2">
          Add Company
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
          <v-btn color="primary" text @click="addCompany()">
            Add
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Add Company -->

    <!-- Edit Company -->
    <v-dialog v-model="editDialog" width="500">
      <v-card>
        <v-card-title class="text-h5 grey lighten-2">
          Modify Company
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
          <v-btn color="primary" text @click="modifyCompany()">
            Modify
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Edit Company -->
  </div>
</template>

<script>
import { CompaniesService } from "../../../services/companies/companies.service";
export default {
  name: "Companies",
  data() {
    return {
      tab: null,
      loading: true,
      addDialog: false,
      editDialog: false,
      selected: [],
      expanded: [],
      singleSelect: null,
      headers: [
        { text: "Name", value: "name" },
        { text: "Domain", value: "domain" },
        { text: "Industry", value: "industry" },
        { text: "Mobile", value: "mobile" },
        { text: "Address", value: "address" },
        { text: "Number of employees", value: "number_of_employees" },
        { text: "", value: "actions" },
      ],
      desserts: [],
      domain: null,
      mobile: null,
      address: null,
    };
  },
  methods: {
    getCompanies: function() {
      CompaniesService.getCompanies()
        .then((result) => {
          console.log(result);
          const data = result.data.data || [];
          if (data.length > 0) this.desserts = data;
        })
        .catch((error) => console.log(error))
        .finally(() => {
          this.loading = false;
        });
    },
    addCompany: function() {
      const data = {
        domain: this.domain,
        mobile: this.mobile,
        address: this.address,
      };
      CompaniesService.addCompany(data)
        .then((result) => {
          console.log(result);
          this.getCompanies();
          this.addDialog = false;
        })
        .catch((error) => console.log(error));
    },
    showCompany: function(item) {
      this.domain = item.domain;
      this.mobile = item.mobile;
      this.address = item.address;
      this.editDialog = true;
    },
    modifyCompany: function() {
      const data = {
        domain: this.domain,
        mobile: this.mobile,
        address: this.address,
      };
      CompaniesService.modifyCompany(this.contactId, data)
        .then((result) => {
          console.log(result);
          this.getCompanies();
          this.editDialog = false;
        })
        .catch((error) => console.log(error));
    },
    removeCompanies: function() {
      if (this.selected.length) {
        const companies = this.selected.map((company) => company.id);
        const thiz = this;
        CompaniesService.removeCompany(companies)
          .then((result) => {
            console.log(result);
            thiz.getCompanies();
          })
          .catch((error) => console.log(error));
      }
    },
  },
  created() {
    this.getCompanies();
  },
};
</script>

<style></style>
