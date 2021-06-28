<template>
  <modal
    name="settings"
    classes="settings-model"
    width="500"
    height="auto"
    @before-open="beforeOpen"
    @opened="opened"
    @before-close="beforeClose"
    @closed="closed"
    :draggable="true"
  >
    <SettingsDialogContent />
  </modal>
</template>

<script>
import { mapGetters } from "vuex";
import SettingsDialogContent from "./SettingsDialogContent";
import { SiteService } from "../../services/site/site";
export default {
  name: "SettingsDialog",
  components: { SettingsDialogContent },
  data() {
    return {
      siteId: null,
      pageId: null,
    };
  },
  methods: {
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
      }
      if (this.$route.query.pageId) {
        this.pageId = +this.$route.query.pageId;
      }
    },
    beforeOpen() {
      // console.log("before-open", event);
      // event.ref.draggable = true;
    },
    beforeClose() {
      console.log(this.siteId, this.pageId);
      SiteService.addSitePageResourceWeb(
        this.siteId,
        this.pageId,
        JSON.stringify(this.getWebResources)
      )
        .then((result) => {
          console.log("Mobile Settings posted", result);
        })
        .catch((error) => {
          console.log(error);
        });
      SiteService.addSitePageResourceMobile(
        this.siteId,
        this.pageId,
        JSON.stringify(this.getMobileResources)
      )
        .then((result) => {
          console.log("Mobile Settings posted", result);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    opened() {
      // e.ref should not be undefined here
      // console.log("opened", event);
      // event.ref.draggable = true;
    },
    closed() {
      // console.log("closed", event);
      // event.defaultPrevented;
    },
  },
  computed: {
    ...mapGetters(["getPages", "getWebResources", "getMobileResources"]),
  },
  watch: {
    getPages: function(pages) {
      if (pages.length > 0) {
        this.pageId = pages[0].id;
      }
    },
  },
  created() {
    this.getQueryStringParams();
  },
};
</script>

<style>
.settings-model {
  overflow: auto;
}
</style>
