<template>
  <v-row justify="center">
    <v-dialog
      v-model="dialog"
      persistent
      max-width="600px"
    > 
      <v-card>
        <v-card-title>
          <span class="text-h5">Add Sender</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field
                  label="Email*"
                  v-model="email"
                  name="email"
                  required
                ></v-text-field>
              </v-col>
              
              <v-col
                cols="12"
                sm="12"
                md="12"
              >
                <v-text-field
                  label="Name*"
                  v-model="nick_name"
                  name="nick_name"
                  required
                ></v-text-field>
              </v-col> 
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
            color="blue darken-1"
            text
            @click="dialog = false"
          >
            Close
          </v-btn>
          <v-btn
            color="blue darken-1"
            text
            @click="addSender()">
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>
<script>
  import {
    SendersService
  } from "../../../services/marketing/senders";
  export default {
    name: "AddSender",
    data() {
      return {
        loading: true,
        dialog: true,
        nick_name : '',
        email : '',
      };
    },
    methods: {
        addSender: function() {
        const data = {
          nick_name: this.nick_name,
          email: this.email,
        };
        SendersService.addSender(data)
          .then((result) => {
            console.log(result);
            this.dialog = false;
          })
          .catch((error) => console.log(error));
      },
    }, 
  };
</script>

<style></style>