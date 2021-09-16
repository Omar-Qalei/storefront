<template>
<div class="container">
  <v-card class="mb-7">
    <v-card-text class="pa-5 border-bottom">
      <h3 class="title blue-grey--text text--darken-2 font-weight-regular">Basic Info</h3>
      <h6 class="subtitle-2 font-weight-light">All your basic info details </h6>
    </v-card-text>
    <v-card-text class="pa-5">
      <v-row>
        <v-col cols="12" sm="2" class="align-center d-flex">
          <label class="font-weight-medium subtitle-1">First Name</label>
        </v-col>
        <v-col cols="12" sm="10">
          <v-text-field v-model="first_name" hide-details background-color="transparent" filled></v-text-field>
        </v-col>
      </v-row> 
            <v-row>
        <v-col cols="12" sm="2" class="align-center d-flex">
          <label class="font-weight-medium subtitle-1">Last Name</label>
        </v-col>
        <v-col cols="12" sm="10">
          <v-text-field v-model="last_name" hide-details background-color="transparent" filled></v-text-field>
        </v-col>
      </v-row> 
    </v-card-text>
  </v-card>
    <v-card class="mb-7">
    <v-card-text class="pa-5 border-bottom">
      <h3 class="title blue-grey--text text--darken-2 font-weight-regular">Login Details</h3>
      <h6 class="subtitle-2 font-weight-light">All your login details </h6>
    </v-card-text>
    <v-card-text class="pa-5">
      <v-row>
        <v-col cols="12" sm="2" class="align-center d-flex">
          <label class="font-weight-medium subtitle-1">Email</label>
        </v-col>
        <v-col cols="12" sm="10">
          <v-text-field
            v-model="email"
            type="search"
            hide-details
            filled
            background-color="transparent"
          ></v-text-field>
        </v-col>
      </v-row>
        <v-row>
        <v-col cols="12" sm="2" class="align-center d-flex">
          <label class="font-weight-medium subtitle-1">Current Password</label>
        </v-col>
        <v-col cols="12" sm="10">
          <v-text-field
            v-model="current_password"
            type="password"
            hide-details
            filled
            placeholder="**********"
            background-color="transparent"
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" sm="2" class="align-center d-flex">
          <label class="font-weight-medium subtitle-1">Password</label>
        </v-col>
        <v-col cols="12" sm="10">
          <v-text-field
            v-model="password"
            type="password"
            hide-details
            filled
            placeholder="**********"
            background-color="transparent"
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12" sm="2" class="align-center d-flex">
          <label class="font-weight-medium subtitle-1">Re Password</label>
        </v-col>
        <v-col cols="12" sm="10">
          <v-text-field
            v-model="password_confirmation"
            type="password"
            hide-details
            filled
            placeholder="**********"
            background-color="transparent"
          ></v-text-field>
        </v-col>
      </v-row>
    </v-card-text>
     <div class="pa-5 border-top text-center">
       <v-alert :type="type" transition="scale-transition" :value="showAlert">
         <h6 v-for="(message,index) in messages" v-bind:key="index">{{ message }}</h6>
       </v-alert>
      <v-btn color="info" class="mr-2 text-capitalize" :loading="loading"  @click="modifyAccount()" >Save</v-btn>
      <v-btn color="light-gray" class="text-capitalize" dark>Cancel</v-btn>
    </div>
  </v-card>
  </div>
</template>
<script>
import AccountService from "../../services/account/account"

export default {
  name: "Main",
  data() {
    return {
      loading: true,
      first_name: null,
      last_name: null,
      email:null,
      current_password:null,
      password: null,
      password_confirmation: null,
      showAlert: false,
      messages: [],
      type:null
    };
  },
  methods: {
    getAccount: function() {
      AccountService.getAccountDetails()
        .then((result) => {
          const data = result.data.data || [];
          this.first_name = data.first_name;
          this.last_name = data.last_name;
          this.email = data.email;
        })
        .catch((error) => console.log(error))
        .finally(() => {
          this.loading = false;
        });
    },
    modifyAccount: function() {
      this.loading = true;
      const data = {
        first_name: this.first_name,
        last_name: this.last_name,
        email: this.email,
        current_password:this.current_password,
        password: this.password,
        password_confirmation: this.password_confirmation
      };
      AccountService.modifyAccountDetails(data)
        .then((result) => {
          this.type = "error";
           this.messages = [];
          if(result.data.status == true){
            this.getAccount();  
            this.type = "success";
            this.messages.push([result.data.message]);
          }else{
            this.messages.push([result.data.errors]);
          }
          this.showAlert = true;
          this.loading = false;
        })
        .catch((error) => console.log(error));
    }
  },
  created() {
    this.getAccount();
  },
};
</script>