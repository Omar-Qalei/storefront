<template>
  <div class="email_information">
    <v-card class="mb-10" max-width="1000">
      <v-card-title>
        <v-icon large left>
          mdi-email
        </v-icon>
        <span class="text-h6 font-weight-light">Email Subject</span>
      </v-card-title>
      <v-card-text class="text-h5 font-weight-bold">
        <v-text-field label="Subject Line"></v-text-field>
      </v-card-text>
    </v-card>
    <v-card class="mb-10" max-width="1000">
      <v-card-title>
        <v-icon large left>
          mdi-account-settings
        </v-icon>
        <span class="text-h6 font-weight-light">Sender Information</span>
      </v-card-title>
      <v-card-text class="text-h5 font-weight-bold">
      <v-row class="my-4">  
            <v-col cols="12"> 
              <v-radio-group v-model="selectedSender">
                <v-list>
                    <v-list-item-group :loading="loading" >
                        <v-list-item v-for="sender in senders" :key="sender.id" @click="chooseSender(sender)" > 
                           <v-radio :value="sender.id"></v-radio>
                        <v-list-item-content> 
                           <v-list-item-title> {{ sender.nick_name }}</v-list-item-title>
                           <v-list-item-title> {{ sender.email }}</v-list-item-title>
                        </v-list-item-content>
                        </v-list-item>
                    </v-list-item-group>
                </v-list> 
                </v-radio-group>
                  <v-divider class="my-2"></v-divider>
                   <v-list-item @click="senderDialog = !senderDialog"><v-icon class="mr-2">mdi-account-plus</v-icon>Add New</v-list-item>
                   <AddSender v-if="senderDialog"/>
            </v-col>
      </v-row>
      </v-card-text>
    </v-card>
  </div>
</template>
<script>
  import { SendersService } from "../../../services/marketing/senders";
  import AddSender from "../components/AddSender.vue";

  export default {
    name: "CampaignSubject",
    components: {
      AddSender,
    },
    data() {
      return {
        e6: 1,
        loading: true,
        senderDialog : false,
        selectedSender:'',
        dialog: '',
        senders: []
      };
    },
    methods: { 
      getListedSenders: function () {
        SendersService.getSenders()
          .then((result) => {
            const data = result.data.data || [];
            if (data.length > 0) this.senders = data;
          })
          .catch((error) => console.log(error))
          .finally(() => {
            this.loading = false;
          });
      },
    },
    created() {
      this.loading = true;
      this.getListedSenders();
    },
  };
</script>

<style></style>