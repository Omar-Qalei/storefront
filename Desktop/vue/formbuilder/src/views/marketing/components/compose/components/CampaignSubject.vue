<template>
  <div>
    <v-card class="ma-4 pa-4">
      <h2>Email Subject Line</h2>
      <p>
        Enter the subject line that recipients will see.
      </p>
      <v-row>
        <v-col cols="12">
          <v-text-field
            label="Subject Line"
            placeholder="ex. Find your Fall Favorites Here!"
            outlined
          ></v-text-field>
        </v-col>
      </v-row>
    </v-card>
    <v-card class="ma-4 pa-4">
      <h2>Sender Information</h2>
      <p>
        Enter the name and email address that recipients will see.
      </p>
      <v-row>
        <v-col cols="12" v-if="senders.length">
          <v-radio-group v-model="selectedSender">
            <v-list>
              <v-list-item-group :loading="loading">
                <v-list-item
                  v-for="sender in senders"
                  :key="sender.id"
                  @click="chooseSender(sender)"
                >
                  <v-radio :value="sender.id"></v-radio>
                  <v-list-item-content>
                    <v-list-item-title>
                      {{ sender.nick_name }}</v-list-item-title
                    >
                    <v-list-item-title> {{ sender.email }}</v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list-item-group>
            </v-list>
          </v-radio-group>
        </v-col>
        <v-col cols="12">
          <v-btn class="w-100 text-left" @click="dialog = !dialog">
            <v-icon class="mx-2">mdi-account-plus</v-icon>Add New
          </v-btn>
        </v-col>
      </v-row>
    </v-card>
    <!-- Add Sender -->
    <v-dialog v-model="dialog" persistent max-width="600px">
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

              <v-col cols="12" sm="12" md="12">
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
          <v-btn color="blue darken-1" text @click="dialog = false">
            Close
          </v-btn>
          <v-btn color="blue darken-1" text @click="addSender()">
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Add Sender -->
  </div>
</template>
<script>
import { SendersService } from "../../../../../services/marketing/senders";

export default {
  name: "CampaignSubject",
  components: {},
  data() {
    return {
      e6: 1,
      loading: true,
      selectedSender: "",
      dialog: false,
      senders: [],
      nick_name: "",
      email: "",
    };
  },
  methods: {
    getListedSenders: function() {
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
  created() {
    this.loading = true;
    this.getListedSenders();
  },
};
</script>

<style scoped>
h2 {
  font-size: 30px;
  margin-bottom: 10px;
}
p {
  line-height: 30px;
  color: #70767c;
  margin-bottom: 30px;
}
</style>
