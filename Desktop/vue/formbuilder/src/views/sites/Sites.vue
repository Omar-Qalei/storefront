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
              <div class="mx-auto">
                <v-card
                  class="mb-10"
                  max-width="344"
                  height="193"
                  @mouseover="showSettings = item.id"
                  @mouseleave="showSettings = null"
                >
                  <v-row class="position-absolute three-dots">
                    <v-col>
                      <v-icon
                        :color="showSettings === item.id ? 'red' : ''"
                        x-small
                      >
                        {{
                          showSettings === item.id
                            ? "mdi-circle"
                            : "mdi-circle-outline"
                        }}
                      </v-icon>
                      <v-icon
                        :color="showSettings === item.id ? 'yellow' : ''"
                        x-small
                      >
                        {{
                          showSettings === item.id
                            ? "mdi-circle"
                            : "mdi-circle-outline"
                        }}
                      </v-icon>
                      <v-icon
                        :color="showSettings === item.id ? 'green' : ''"
                        x-small
                      >
                        {{
                          showSettings === item.id
                            ? "mdi-circle"
                            : "mdi-circle-outline"
                        }}
                      </v-icon>
                    </v-col>
                  </v-row>
                  <v-img
                    height="100%"
                    src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
                  >
                    <v-fade-transition>
                      <v-row
                        v-show="showSettings === item.id"
                        class="position-absolute h-100 show-settings"
                      >
                        <v-col class="text-end" cols="12">
                          <v-menu
                            bottom
                            origin="center center"
                            transition="scale-transition"
                          >
                            <template v-slot:activator="{ on, attrs }">
                              <v-btn dark icon v-bind="attrs" v-on="on">
                                <v-icon>mdi-cog-outline</v-icon>
                              </v-btn>
                            </template>

                            <v-list>
                              <v-list-item @click="removeSite(item.id)" link>
                                <v-list-item-title>Delete</v-list-item-title>
                              </v-list-item>
                            </v-list>
                          </v-menu>
                        </v-col>
                        <v-col class="text-center" cols="12">
                          <div>
                            <v-btn
                              class="text-capitalize"
                              light
                              :to="{
                                path: 'formBuilder',
                                query: { siteId: item.id },
                              }"
                              >Edit Website</v-btn
                            >
                          </div>
                          <div class="mt-4">
                            <v-btn class="text-capitalize" light
                              >Settings</v-btn
                            >
                          </div>
                        </v-col>
                      </v-row>
                    </v-fade-transition>
                  </v-img>

                  <!-- <v-card-actions>
                  <v-btn
                    color="orange lighten-2"
                    text
                    
                  >
                    Explore
                  </v-btn>
                  <v-btn
                    color="red lighten-2"
                    text
                    
                  >
                    Remove
                  </v-btn>
                </v-card-actions> -->
                </v-card>
                <p class="name-webiste">{{ item.name }}</p>
                <p class="domain-website">{{ item.domain }}</p>
              </div>
            </v-col>
          </v-row>
        </v-tab-item>
        <v-tab-item>
          <v-card flat>
            Test2
          </v-card>
        </v-tab-item>

        <!-- Tempaltes -->
        <v-tab-item>
          <v-card class="pa-4" flat>
            <div>
              <h2>What kind of websites will you be building?</h2>
              <p class="template">
                Pick the option that best applies to the purpose of your
                websites. You'll be able to edit the contents later.
              </p>
              <v-tabs
                light
                next-icon="mdi-arrow-right-bold-box-outline"
                prev-icon="mdi-arrow-left-bold-box-outline"
                show-arrows
                v-model="selectedChooseTemplateTab"
              >
                <v-tabs-slider></v-tabs-slider>
                <v-tab
                  v-for="(item, index) of chooseTemplateTabs"
                  :key="index"
                  :href="'#tab-' + index"
                >
                  {{ item }}
                </v-tab>
              </v-tabs>
              <v-tabs-items v-model="selectedChooseTemplateTab">
                <v-tab-item
                  v-for="(item, index) of chooseTemplateTabs"
                  :key="index"
                >
                  <v-card flat>
                    <v-card-text v-text="item"></v-card-text>
                  </v-card>
                </v-tab-item>
              </v-tabs-items>
            </div>
          </v-card>
        </v-tab-item>
        <!-- Tempaltes -->
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
          <v-btn
            color="red"
            text
            @click="
              dialog = false;
              siteName = null;
              domainName = null;
            "
          >
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
      chooseTemplateTabs: ["General", "Commerce", "Announcements", "Saved"],
      selectedChooseTemplateTab: null,
      showSettings: 0,
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
          this.siteName = null;
          this.domainName = null;
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

<style scoped>
h2 {
  font-size: 30px;
  margin-bottom: 10px;
}
p.template {
  line-height: 30px;
  color: #70767c;
  margin-bottom: 30px;
}
.name-webiste {
  color: black;
  font-size: 16px;
  font-weight: 700;
  margin-bottom: 0;
}
.domain-website {
  color: #9da3a9;
  font-size: 16px;
}
.show-settings {
  background-color: rgba(0, 0, 0, 0.75);
}
.three-dots {
  top: -10px !important;
  max-height: 40px;
  position: relative;
}
</style>
