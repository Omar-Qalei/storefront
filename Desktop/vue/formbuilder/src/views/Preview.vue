<template>
  <div>
    <LoadingPage v-if="getLoadingPage" />
    <v-flex class="preview page" v-else>
      <Navbar />
      <Pages />
      <div class="d-flex h-100">
        <v-main>
          <v-col cols="12" class="center pa-0">
            <PreviewPages></PreviewPages>
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
      dialog: true,
      siteId: null,
      pageId: null,
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
      "onSelectedWidgetById",
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

            this.onSelectedWidgetById(this.getSections[0]);
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
  },
  watch: {
    getSelectedPage: function(pageId) {
      this.pageId = pageId;
      this.onLoadingPage(true);
      this.getSitePageResources();
    },
    $route: function() {
      this.onSelectedWidgetById({});
      this.pageId = null;
      this.getQueryStringParams();
    },
  },
  created() {
    this.getQueryStringParams();
  },
  destroyed() {
    this.onSelectedWidgetById({});
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
