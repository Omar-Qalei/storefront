<template>
  <div class="sites">
    <v-card class="pa-4">
      <v-tabs v-model="tab">
        <v-tabs-slider color="orange lighten-2"></v-tabs-slider>

        <v-tab>
          Sites
        </v-tab>
        <v-tab>
          Domains
        </v-tab>
        <v-tab>
          Templates
        </v-tab>
      </v-tabs>
      <v-divider></v-divider>
      <v-tabs-items v-model="tab">
        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-row class="my-4" align="center">
                <h2 class="body-1">
                  View all your websites that you manage currently
                </h2>
                <v-spacer></v-spacer>
                <v-btn @click="dialog = true" outlined color="primary"
                  >Create Site</v-btn
                >
              </v-row>
            </v-card-text>
          </v-card>
          <v-row class="my-4">
            <v-col v-for="(item, index) in websites" :key="index">
              <v-card class="mx-auto" max-width="344">
                <v-img
                  src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
                  height="200px"
                ></v-img>

                <v-card-title>
                  {{ item.name }}
                </v-card-title>

                <v-card-subtitle>
                  {{ item.domain }}
                </v-card-subtitle>

                <v-card-actions>
                  <v-btn
                    color="orange lighten-2"
                    text
                    :to="{ path: 'formBuilder', query: { siteId: item.id } }"
                  >
                    Explore
                  </v-btn>
                  <v-btn
                    color="red lighten-2"
                    text
                    @click="removeSite(item.id)"
                  >
                    Remove
                  </v-btn>

                  <v-spacer></v-spacer>

                  <v-btn icon @click="show = !show">
                    <v-icon>{{
                      show ? "mdi-chevron-up" : "mdi-chevron-down"
                    }}</v-icon>
                  </v-btn>
                </v-card-actions>

                <v-expand-transition>
                  <div v-show="show">
                    <v-divider></v-divider>

                    <v-card-text>
                      I'm a thing. But, like most politicians, he promised more
                      than he could deliver. You won't have time for sleeping,
                      soldier, not with all the bed making you'll be doing. Then
                      we'll go with that data file! Hey, you add a one and two
                      zeros to that or we walk! You're going to do his laundry?
                      I've got to find a way to escape.
                    </v-card-text>
                  </div>
                </v-expand-transition>
              </v-card>
            </v-col>
          </v-row>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <!-- <v-card-text v-text="text"></v-card-text> -->
            Test2
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            <!-- <v-card-text v-text="text"></v-card-text> -->
            Test3
          </v-card>
        </v-tab-item>
      </v-tabs-items>
    </v-card>

    <!-- Create Site -->
    <v-dialog v-model="dialog" width="500">
      <v-card>
        <v-card-title class="text-h5 grey lighten-2">
          Create site
        </v-card-title>

        <v-card-text>
          <v-row class="mt-4">
            <v-col cols="12">
              <v-text-field
                v-model="siteName"
                label="Name"
                outlined
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="domainName"
                label="Domain"
                outlined
              ></v-text-field>
            </v-col>
          </v-row>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="red" text @click="dialog = false">
            Cancel
          </v-btn>
          <v-btn color="primary" text @click="addSite()">
            Create
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <!-- Create Site -->
  </div>
</template>

<script>
import { SiteService } from "../../services/site/site";
import { mapActions } from "vuex";
export default {
  name: "Sites",
  data() {
    return {
      tab: null,
      show: false,
      dialog: false,
      websites: [],
      siteName: null,
      domainName: null,
      siteId: null,
    };
  },
  methods: {
    ...mapActions(["fetchPages"]),
    getSites: function() {
      SiteService.getSites()
        .then((result) => {
          const data = result.data.data;
          this.websites = data;
        })
        .catch((err) => console.log(err));
    },
    getSiteById: function() {
      SiteService.getSitePages(this.siteId)
        .then((result) => {
          const data = result.data.data;
          this.fetchPages(data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    addSite: function() {
      const data = {
        domain: this.domainName,
        name: this.siteName,
      };
      SiteService.addSite(data)
        .then((event) => {
          const result = event.data.data;
          this.siteId = result.id;
          if (this.siteId) {
            this.$router.push({
              path: "formBuilder",
              query: { siteId: this.siteId },
            });
            this.getSiteById();
          }
        })
        .catch((result) => console.log(result));
    },
    removeSite: function(siteId) {
      SiteService.removeSite(siteId)
        .then(() => {
          this.getSites();
        })
        .catch((result) => console.log(result));
    },
  },
  created() {
    this.getSites();
  },
};
</script>

<style></style>
