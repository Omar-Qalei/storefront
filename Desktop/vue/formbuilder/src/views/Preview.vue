<template>
  <div>
    <LoadingPage v-if="getLoadingPage" />
    <v-flex class="preview page" v-else>
      <Navbar />
      <Pages />
      <div class="d-flex h-100">
        <v-main>
          <v-col cols="12" class="center pa-0">
            <PreviewPages @pagePath="goToPath($event)"></PreviewPages>

            <!-- SnackBar -->
            <v-snackbar v-model="snackbar">
              {{ text }}

              <template v-slot:action="{ attrs }">
                <v-btn
                  color="pink"
                  text
                  v-bind="attrs"
                  @click="snackbar = false"
                >
                  Close
                </v-btn>
              </template>
            </v-snackbar>
            <!-- SnackBar -->
          </v-col>
        </v-main>
      </div>
    </v-flex>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import Navbar from "../layouts/preview/Navbar";
import Pages from "../layouts/preview/Pages";
import { SiteService } from "../services/site/site";
import LoadingPage from "../layouts/LoadingPage";
import PreviewPages from "./PreviewPages.vue";

export default {
  name: "FormBuilder",
  components: { Navbar, Pages, LoadingPage, PreviewPages },
  data() {
    return {
      siteId: null,
      pageId: null,
      text: null,
      dialog: true,
      snackbar: false,
      pages: [],
    };
  },
  computed: {
    ...mapGetters([
      "getSelectedPage",
      "getScreenSize",
      "getLoadingPage",
      "getWebResources",
      "getMobileResources",
      "getSections",
      "getShowSnackbar",
    ]),
  },
  methods: {
    ...mapActions([
      "fetchSections",
      "fetchWebResources",
      "fetchMobileResources",
      "fetchPages",
      "fetchSiteId",
      "fetchPageId",
      "onLoadingPage",
      "onResizeSectionScreen",
    ]),
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
        this.onLoadingPage(true);
        this.getSiteById();
        this.fetchSiteId(this.siteId);
      }
      if (this.$route.query.pageId) {
        this.pageId = +this.$route.query.pageId;
        this.getSitePageResources();
        this.fetchPageId(this.pageId);
      }
    },
    getSiteById: function() {
      SiteService.getSitePages(this.siteId)
        .then((result) => {
          const data = result.data.data;
          this.pages = data;
          if (this.pageId === null) this.pageId = data[0].id;
          this.fetchPageId(this.pageId);
          this.fetchPages(data);
          this.getSitePageResources();
        })
        .catch((error) => {
          console.log(error);
        });
    },
    getSitePageResources: function() {
      SiteService.getSitePageResources(this.siteId, this.pageId)
        .then((result) => {
          const data = result.data.data;
          if (data) {
            this.fetchWebResources(JSON.parse(data.web));
            this.fetchMobileResources(JSON.parse(data.mobile));
            JSON.parse(data.web)
              ? this.fetchSections(JSON.parse(data.web))
              : this.fetchSections([]);
          } else {
            this.fetchSections([]);
            this.fetchWebResources(data);
            this.fetchMobileResources(data);
          }
        })
        .catch((err) => {
          console.log(err);
        })
        .finally(() => this.onLoadingPage(false));
    },
    goToPath: function(pagePath) {
      const data = this.pages.find(
        (element) => element.path.toLowerCase() === pagePath.toLowerCase()
      );
      const siteId = data.site_id;
      const pageId = data.id;
      if (+this.$route.query.pageId !== pageId)
        this.$router.replace({
          path: "preview",
          query: { siteId: siteId, pageId: pageId },
        });
    },
  },
  watch: {
    getSelectedPage: function(pageId) {
      this.pageId = pageId;
      this.onLoadingPage(true);
      this.getSitePageResources();
    },
    $route: function() {
      this.pageId = null;
      this.getQueryStringParams();
    },
    getShowSnackbar: function(value) {
      this.snackbar = true;
      this.text = value;
    },
  },
  created() {
    this.getQueryStringParams();
    this.onResizeSectionScreen({
      width: "100%",
      responsive: false,
      cols: 24,
      screen: "web",
    });
  },
  destroyed() {
    this.fetchSections([]);
    this.fetchWebResources(null);
    this.fetchMobileResources(null);
  },
};
</script>
<style scoped>
.page {
  margin: 0;
  padding: 0;
}
.center {
  text-align: -webkit-center;
}
</style>
