<template>
  <v-flex class="form-builder page">
    <Navbar />
    <Sidebar />
    <Pages />
    <div class="d-flex h-100">
      <v-main>
        <GridView></GridView>
        <SettingsDialog from="modal" />
      </v-main>
    </div>
  </v-flex>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import GridView from "./GridView";
import SettingsDialog from "../components/settings/SettingsDialog";
import Navbar from "../layouts/form-builder/Navbar";
import Sidebar from "../layouts/form-builder/Sidebar";
import Pages from "../layouts/form-builder/Pages";
import { SiteService } from "../services/site/site";

export default {
  name: "FormBuilder",
  components: { GridView, SettingsDialog, Navbar, Sidebar, Pages },
  data() {
    return {
      dialog: true,
      siteId: null,
      pageId: null,
    };
  },
  computed: {
    ...mapGetters(["getSelectedPage", "getScreenSize"]),
  },
  methods: {
    ...mapActions(["fetchSections", "fetchPages"]),
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
        this.getSiteById();
      }
    },
    getSiteById: function() {
      this.fetchSections([]);
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
          console.log(data);
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
  watch: {
    getSelectedPage: function(pageId) {
      this.pageId = pageId;
      this.getSitePageResources();
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
</style>
