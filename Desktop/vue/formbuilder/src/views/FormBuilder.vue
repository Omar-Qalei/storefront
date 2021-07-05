<template>
  <div>
    <LoadingPage v-if="getLoadingPage" />
    <v-flex class="form-builder page" v-else>
      <Navbar />
      <Sidebar />
      <Pages />
      <div class="d-flex h-100">
        <v-main>
          <v-col cols="12" class="center">
            <v-card
              style="transition: width 2s ease 0s;"
              :style="{
                width: getScreenSize.width,
              }"
            >
              <GridView></GridView>
            </v-card>
          </v-col>
          <SettingsDialog from="modal" />
        </v-main>
      </div>
    </v-flex>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import GridView from "./GridView";
import SettingsDialog from "../components/settings/SettingsDialog";
import Navbar from "../layouts/form-builder/Navbar";
import Sidebar from "../layouts/form-builder/Sidebar";
import Pages from "../layouts/form-builder/Pages";
import { SiteService } from "../services/site/site";
import LoadingPage from "../layouts/LoadingPage";

export default {
  name: "FormBuilder",
  components: { GridView, SettingsDialog, Navbar, Sidebar, Pages, LoadingPage },
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
      "fetchCols",
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
    this.fetchCols(24);
    this.getQueryStringParams();
  },
  destroyed() {
    console.log("destoryed FormBuilder");
    this.onSelectedWidgetById({});
    this.fetchSections([]);
    this.fetchWebResources(null);
    this.fetchMobileResources(null);
  },
};
</script>
<style scoped>
.page {
  padding: 0 45px 45px;
}
.center {
  text-align: -webkit-center;
}
</style>
