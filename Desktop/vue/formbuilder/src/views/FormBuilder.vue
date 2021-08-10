<template>
  <div>
    <LoadingPage v-if="getLoadingPage" />
    <v-flex class="form-builder page" v-else>
      <Navbar />
      <Sidebar />
      <Pages />
      <div class="d-flex h-100">
        <v-main>
          <v-col v-if="getWebResources.length > 0" cols="12" class="center">
            <GridView></GridView>
          </v-col>
          <v-col v-if="getWebResources.length === 0" cols="12" class="center">
            <v-col
              class="empty-page"
              style="transition: width 0.5s ease 0s;"
              :style="{
                width: getScreenSize.width,
              }"
            >
              <h4>This page is empty</h4>
              <p>
                Click "Add section" below or use the "Add element" menu on the
                left to start building this page
              </p>
              <template v-if="getScreenSize.screen === 'web'">
                <v-btn
                  class="btn-add-section-web"
                  dark
                  color="#357df9"
                  @click="addNewSection(0)"
                  ><v-icon class="icon-add-section mr-2">mdi-plus</v-icon> Add
                  Section</v-btn
                >
              </template>
              <template v-if="getScreenSize.screen === 'mobile'">
                <v-btn
                  class="btn-add-section-mobile"
                  fab
                  dark
                  small
                  color="#357df9"
                  @click="addNewSection(0)"
                  ><v-icon class="icon-add-section">mdi-plus</v-icon></v-btn
                >
              </template>
            </v-col>
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
      "onResizeSectionScreen",
      "addNewSection",
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
    onResizeHandler: function(event) {
      let width = event.target.outerWidth - event.target.innerWidth;
      width = event.target.outerWidth - width;
      if (width <= 920) {
        console.log(width);
        this.onResizeSectionScreen({
          width: "379px",
          responsive: false,
          cols: 1,
          screen: "mobile",
        });
      } else {
        this.onResizeSectionScreen({
          width: "100%",
          responsive: false,
          cols: 24,
          screen: "web",
        });
      }
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
    // if (window.innerWidth <= 920) {
    //   this.onResizeSectionScreen({
    //     width: "100%",
    //     responsive: false,
    //     cols: 1,
    //     screen: "mobile",
    //   });
    // } else {
    //   this.onResizeSectionScreen({
    //     width: "100%",
    //     responsive: false,
    //     cols: 24,
    //     screen: "web",
    //   });
    // }
    window.addEventListener("resize", this.onResizeHandler);
  },
  destroyed() {
    console.log("destoryed FormBuilder");
    this.onSelectedWidgetById({});
    this.fetchSections([]);
    this.fetchWebResources(null);
    this.fetchMobileResources(null);
    window.removeEventListener("resize", this.onResizeHandler);
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
.btn-add-section-web {
  position: absolute;
  left: 50%;
  bottom: -1rem;
  margin-left: -4rem;
  z-index: 1;
  border-radius: 20px;
  font-size: 10px !important;
}
.btn-add-section-mobile {
  position: absolute;
  left: 50%;
  bottom: -1rem;
  margin-left: -4rem;
  z-index: 1;
  border-radius: 20px;
  font-size: 10px !important;
  transform: translateX(100%);
}
.empty-page {
  position: relative;
  margin-top: 200px;
  text-align: center;
}
</style>
