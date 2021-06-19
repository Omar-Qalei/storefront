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
          <v-list-item link @click="addPage">
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
                <v-btn x-small icon color="primary">
                  <v-icon color="primary">mdi mdi-drag</v-icon>
                </v-btn>
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
    };
  },
  methods: {
    ...mapActions(["onDrawerPages", "onSelectedPage", "fetchPages"]),
    onAddElement: function() {
      this.addElement = !this.addElement;
    },
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
      }
    },
    addPage: function() {
      const data = {
        name: "Home" + this.getPages.length,
        path: "/home/" + this.getPages.length,
      };
      SiteService.addPage(this.siteId, data)
        .then(() => {
          // const data = result.data.data;
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
    getSitePageResources: function() {
      SiteService.getSitePageResources(this.siteId, this.pageId)
        .then((result) => {
          const data = result.data.data;
          if (data && data.web && this.getScreenSize.screen === "web")
            this.fetchSections(JSON.parse(data.web));

          if (data && data.mobile && this.getScreenSize.screen === "mobile")
            this.fetchSections(JSON.parse(data.mobile));
        })
        .catch((err) => {
          console.log(err);
        });
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
