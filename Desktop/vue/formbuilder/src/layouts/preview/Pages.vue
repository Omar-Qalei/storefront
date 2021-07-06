<template>
  <div>
    <div class="d-flex">
      <v-navigation-drawer
        height="100%"
        v-model="drawer"
        left
        app
        clipped
        temporary
        fixed
        class="settings"
      >
        <v-list>
          <!-- <draggable v-model="getPages" class="w-100"> -->
          <template v-if="getPages !== undefined">
            <v-list-item
              v-for="(page, index) in getPages"
              :key="index"
              link
              @click="onDo(page)"
            >
              <v-list-item-icon>
                <v-icon>mdi mdi-page-layout-body</v-icon>
              </v-list-item-icon>
              <v-list-item-title>
                <v-flex class="mr-auto">
                  {{ page.name }}
                </v-flex>
              </v-list-item-title>
            </v-list-item>
          </template>
        </v-list>
      </v-navigation-drawer>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import { SiteService } from "../../services/site/site";

export default {
  name: "Pages",
  data() {
    return {
      drawer: false,
      mini: true,
      selectedPage: null,
      siteId: null,
      pageId: null,
    };
  },
  methods: {
    ...mapActions([
      "onDrawerPages",
      "onSelectedPage",
      "fetchPages",
      "fetchPageId",
      "onLoadingPage",
    ]),
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
        this.getSiteById();
      }
      if (this.$route.query.pageId) {
        this.pageId = +this.$route.query.pageId;
      }
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
    onDo: function(page) {
      if (this.pageId !== page.id) {
        this.selectedPage = page.id;
        this.onDrawerPages();
      }
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
      this.fetchPageId(value);
      this.$router.replace({
        path: "preview",
        query: { siteId: this.siteId, pageId: value },
      });
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
