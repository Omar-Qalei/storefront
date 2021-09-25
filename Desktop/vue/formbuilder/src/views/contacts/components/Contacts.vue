<template>
  <div class="contacts">
    <v-card flat>
      <v-card-text>
        <v-row class="my-4" align="center">
          <h2 class="body-1">
            View all interactions with this contact’s company in one place
          </h2>
          <v-spacer></v-spacer>
          <v-btn outlined color="primary" @click="addDialog = true">
            <v-icon>mdi-plus</v-icon> Contact
          </v-btn>
        </v-row>
      </v-card-text>
    </v-card>
    <v-row class="my-4">
      <v-col cols="12">
        <v-btn class="text-capitalize" text @click="removeContact()">
          <v-icon>mdi-delete-outline</v-icon>
          Contacts
        </v-btn>
      </v-col>
      <v-col cols="12">
        <v-data-table
          v-model="selected"
          :headers="headers"
          :items="desserts"
          item-key="email"
          show-select
          :loading="loading"
          loading-text="Loading... Please wait"
        >
          <template v-slot:item.actions="{ item }">
            <v-btn icon small>
              <v-icon small @click="showContact(item)">
                mdi-pencil
              </v-icon>
            </v-btn>
          </template>
        </v-data-table>
      </v-col>
    </v-row>

    <!-- Add Contact -->
    <v-navigation-drawer
      v-model="addDialog"
      class="mx-auto"
      right
      fixed
      temporary
      width="500"
    >
      <!-- <v-dialog v-model="addDialog" width="500"> -->
      <v-card flat>
        <v-card-title class="text-h5 grey lighten-2">
          Add Contact
        </v-card-title>

        <v-card-text>
          <v-row class="mt-4">
            <v-col cols="12" sm="6">
              <v-text-field
                label="First Name"
                v-model="firstName"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Last Name"
                v-model="lastName"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Email"
                v-model="email"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Job Title"
                v-model="jobTitle"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Mobile"
                v-model="phone"
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
          <v-btn color="primary" text @click="addContact()">
            Add
          </v-btn>
        </v-card-actions>
      </v-card>
      <!-- </v-dialog> -->
    </v-navigation-drawer>
    <!-- Add Contact -->

    <!-- Edit Contact -->
    <v-navigation-drawer
      v-model="editDialog"
      class="mx-auto"
      right
      fixed
      temporary
      width="500"
    >
      <!-- <v-dialog v-model="editDialog" width="500"> -->
      <v-card flat>
        <v-card-title class="text-h5 grey lighten-2">
          Modify Contact
        </v-card-title>

        <v-card-text>
          <v-row class="mt-4">
            <v-col cols="12" sm="6">
              <v-text-field
                label="First Name"
                v-model="firstName"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Last Name"
                v-model="lastName"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Email"
                v-model="email"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Job Title"
                v-model="jobTitle"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6">
              <v-text-field
                label="Mobile"
                v-model="phone"
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
          <v-btn color="primary" text @click="modifyContact()">
            Modify
          </v-btn>
        </v-card-actions>
      </v-card>
      <!-- </v-dialog> -->
    </v-navigation-drawer>
    <!-- Edit Contact -->
  </div>
</template>

<script>
import { ContactService } from "../../../services/contacts/contacts";
export default {
  name: "Contacts",
  data() {
    return {
      tab: null,
      loading: true,
      addDialog: false,
      editDialog: false,
      selected: [],
      singleSelect: false,
      firstName: null,
      lastName: null,
      email: null,
      jobTitle: null,
      phone: null,
      address: null,
      contactId: null,
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
    addContact: function() {
      const data = {
        first_name: this.firstName,
        last_name: this.lastName,
        email: this.email,
        job_title: this.jobTitle,
        phone: this.phone,
        address: this.address,
      };
      ContactService.addContact(data)
        .then((result) => {
          console.log(result);
          this.getContacts();
          this.addDialog = false;
        })
        .catch((error) => console.log(error));
    },
    showContact: function(item) {
      this.firstName = item.firstName;
      this.lastName = item.lastName;
      this.email = item.email;
      this.jobTitle = item.jobTitle;
      this.phone = item.phone;
      this.address = item.address;
      this.contactId = item.id;
      this.editDialog = true;
    },
    modifyContact: function() {
      const data = {
        first_name: this.firstName,
        last_name: this.lastName,
        email: this.email,
        job_title: this.jobTitle,
        phone: this.phone,
        address: this.address,
      };
      ContactService.modifyContact(this.contactId, data)
        .then((result) => {
          console.log(result);
          this.getContacts();
          this.editDialog = false;
        })
        .catch((error) => console.log(error));
    },
    removeContact: function() {
      if (this.selected.length) {
        const users = this.selected.map((user) => user.id);
        ContactService.removeContact(users)
          .then((result) => {
            console.log(result);
            this.getContacts();
          })
          .catch((error) => console.log(error));
      }
    },
  },
  created() {
    this.getContacts();
  },
};
</script>

<style></style>
