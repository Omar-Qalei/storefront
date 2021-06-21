<template>
  <div>
    <LoadingPage v-if="getLoadingPage" />
    <v-flex class="form-builder page" v-else>
      <Navbar />
      <Sidebar />
      <Pages />
      <div class="d-flex h-100">
        <!-- :style="{
          maxWidth: getScreenSize.width,
          transition: 'width 18s ease-in-out;',
        }" -->
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
    ...mapGetters(["getSelectedPage", "getScreenSize", "getLoadingPage"]),
  },
  methods: {
    ...mapActions(["fetchSections", "fetchPages", "onLoadingPage"]),
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
        this.getSiteById();
      }
    },
    getSiteById: function() {
      this.fetchSections([]);
      if (localStorage.getItem(this.getScreenSize.screen)) {
        const data = JSON.parse(
          localStorage.getItem(this.getScreenSize.screen)
        );
        if (data !== null && this.getScreenSize.screen === "web") {
          this.fetchSections(data);
        }
      }
      SiteService.getSitePages(this.siteId)
        .then((result) => {
          const data = result.data.data;
          this.pageId = data[0].id;
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
            localStorage.setItem("web", data.web);
            localStorage.setItem("mobile", data.mobile);
            if (data.web) this.fetchSections(JSON.parse(data.web));
          } else {
            this.fetchSections([]);
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
    getScreenSize: function(type) {
      if (type.screen === "web") {
        if (JSON.parse(localStorage.getItem("web"))) {
          let resource = JSON.parse(localStorage.getItem("web"));
          this.fetchSections(resource);
        }
      }
      if (type.screen === "mobile") {
        if (JSON.parse(localStorage.getItem("mobile"))) {
          let resource = JSON.parse(localStorage.getItem("mobile"));
          this.fetchSections(resource);
        }
      }
    },
  },
  created() {
    this.getQueryStringParams();
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
