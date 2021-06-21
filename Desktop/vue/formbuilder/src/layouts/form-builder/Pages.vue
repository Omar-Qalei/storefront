<template>
  <div>
    <div class="d-flex">
      <v-navigation-drawer
        height="100%"
        v-model="drawer"
        left
        app
        clipped
        absolute
        temporary
        class="settings"
      >
        <v-list>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Pages</v-list-item-title>
            </v-list-item-content>

            <v-list-item-action>
              <v-btn class="red--text" icon @click="onDrawerPages">
                <v-icon>mdi-window-close</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>
          <v-list-item link @click="dialog = true">
            <v-list-item-icon>
              <v-icon
                color="indigo"
                v-text="'mdi-plus-circle-outline'"
              ></v-icon>
            </v-list-item-icon>
            <v-list-item-title
              class="indigo--text"
              v-text="'Add A New Page'"
            ></v-list-item-title>
          </v-list-item>
        </v-list>
        <v-divider></v-divider>
        <v-list>
          <!-- <draggable v-model="getPages" class="w-100"> -->
          <template v-if="getPages !== undefined">
            <v-list-item
              v-for="(page, index) in getPages"
              :key="index"
              @click="
                selectedPage = page.id;
                onDrawerPages();
              "
            >
              <v-list-item-icon>
                <v-menu offset-y>
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn
                      x-small
                      icon
                      color="primary"
                      v-bind="attrs"
                      v-on="on"
                    >
                      <v-icon color="primary">mdi mdi-cog-outline</v-icon>
                    </v-btn>
                  </template>
                  <v-list>
                    <v-list-item link>
                      <v-list-item-title> Edit</v-list-item-title>
                    </v-list-item>
                    <v-list-item @click="onRemovePage(page.id)" link>
                      <v-list-item-title> Delete</v-list-item-title>
                    </v-list-item>
                  </v-list>
                </v-menu>
              </v-list-item-icon>
              <v-list-item-title>
                <v-flex class="mr-auto">
                  {{ page.name }}
                </v-flex>
                <!-- <v-btn x-small icon color="primary">
                  <v-icon color="primary">mdi mdi-cog-outline</v-icon>
                </v-btn> -->
              </v-list-item-title>
            </v-list-item>
          </template>
          <!-- </draggable> -->
        </v-list>
      </v-navigation-drawer>
    </div>

    <!-- Add Page Dialog -->
    <v-dialog v-model="dialog" width="500">
      <v-card>
        <v-card-title class="text-h5 grey lighten-2">
          Add Page
        </v-card-title>

        <v-card-text>
          <v-col cols="12">
            <h2 class="body-1 font-weight-medium mb-2">
              Name
            </h2>
            <v-text-field outlined v-model="name" hide-details></v-text-field>
          </v-col>
          <v-col cols="12">
            <h2 class="body-1 font-weight-medium mb-2">
              Path
            </h2>
            <v-text-field outlined v-model="path" hide-details></v-text-field>
          </v-col>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="addPage">
            Add
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { SiteService } from "../../services/site/site";
// import draggable from "vuedraggable";

export default {
  name: "Pages",
  // components: { draggable },
  data() {
    return {
      addElement: false,
      drawer: false,
      mini: true,
      selectedPage: null,
      siteId: null,
      dialog: false,
      name: null,
      path: null,
    };
  },
  methods: {
    ...mapActions([
      "onDrawerPages",
      "onSelectedPage",
      "fetchPages",
      "onLoadingPage",
    ]),
    onAddElement: function() {
      this.addElement = !this.addElement;
    },
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
        this.getSiteById();
      }
    },
    addPage: function() {
      const data = {
        name: this.name,
        path: this.path,
      };
      SiteService.addPage(this.siteId, data)
        .then(() => {
          this.dialog = false;
          this.drawer = true;
          this.getSiteById();
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
    // getSitePageResources: function() {
    //   console.log("checked");
    //   SiteService.getSitePageResources(this.siteId, this.pageId)
    //     .then((result) => {
    //       const data = result.data.data;
    //       if (data) {
    //         localStorage.setItem("web", data.web);
    //         localStorage.setItem("mobile", data.mobile);
    //         if (data.web) this.fetchSections(JSON.parse(data.web));
    //       } else {
    //         this.fetchSections([]);
    //       }
    //     })
    //     .catch((err) => {
    //       console.log(err);
    //     });
    // },
    onRemovePage: function(pageId) {
      SiteService.removePage(this.siteId, pageId)
        .then(() => {
          this.dialog = false;
          this.drawer = true;
          this.getSiteById();
        })
        .catch((err) => console.log(err));
    },
  },
  computed: {
    ...mapGetters(["getDrawerPages", "getPages"]),
  },
  watch: {
    getDrawerPages: function(value) {
      this.drawer = value;
    },
    drawer: function(value) {
      this.onDrawerPages(value);
    },
    selectedPage: function(value) {
      this.onSelectedPage(value);
    },
  },
  created() {
    this.getQueryStringParams();
  },
};
</script>

<style scoped>
.sidebar {
  /* width: 240px; */
  box-shadow: 0 10px 20px 0 rgb(0 0 0 / 5%);
  justify-content: center;
  flex-wrap: wrap;
  position: fixed;
  right: 0;
  top: 58px;
  height: 100%;
  background-color: white;
  z-index: 15;
}
.settings {
  top: 48px !important;
}
.sidebar-title {
  padding: 2.7rem 3.3rem 1rem;
  font-size: 1rem;
  font-weight: 500;
}
</style>
