<template>
  <!-- <div class="navbar"> -->
  <v-app-bar app color="white" dense clipped-right clipped-left dark>
    <a class="logo mr-6">
      Wimmly
    </a>
    <div class="separator"></div>
    <a class="pages ml-2" @click="onDrawerPages">
      Pages: <b class="ml-1">{{ title }}</b>
    </a>
    <div class="spacer"></div>
    <div class="settings d-flex">
      <v-chip class="ma-2" color="deep-purple accent-4" outlined>
        <v-icon left>
          mdi-check-decagram
        </v-icon>
        Auto Save
      </v-chip>
      <a
        class="link-icon"
        @click="
          onResizeSectionScreen({
            width: '320px',
            cols: 1,
            responsive: true,
            screen: 'mobile',
          });
          onRearrangementResources();
          getSitePageResources();
        "
      >
        <span class="mdi mdi-cellphone-cog"></span>
      </a>
      <a
        class="link-icon"
        @click="
          getSitePageResources();
          onResizeSectionScreen({
            width: '100%',
            cols: 12,
            responsive: false,
            screen: 'web',
          });
        "
      >
        <span class="mdi mdi-monitor"></span>
      </a>
      <v-btn icon small color="primary" @click.stop="onDrawer">
        <v-icon>mdi-menu</v-icon>
      </v-btn>
      <v-btn
        class="text-capitalize font-weight-light fs-14"
        color="primary"
        text
        to="/preview"
        ><v-icon class="mr-2">mdi-eye</v-icon>Preview</v-btn
      >
      <v-btn
        class="text-capitalize font-weight-light fs-14"
        color="primary"
        dark
        x-large
      >
        Publish Website
      </v-btn>
    </div>
  </v-app-bar>
  <!-- </div> -->
</template>

<script>
import { mapActions, mapGetters } from "vuex";
// import { SiteService } from "../../services/site/site";

export default {
  name: "Navbar",
  data: function() {
    return {
      title: null,
      siteId: null,
      pageId: null,
    };
  },
  methods: {
    ...mapActions([
      "onDrawer",
      "onDrawerPages",
      "onResizeSectionScreen",
      "onRearrangementResources",
      "onSortSectionsLayout",
      "fetchSections",
    ]),
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
      }
    },
    getSitePageResources: function() {
      // console.log(this.screen);
      // if (this.screen === "web") {
      //   if (localStorage.getItem("web")) {
      //     let resource = JSON.parse(localStorage.getItem("web"));
      //     this.fetchSections(resource);
      //   }
      // }
      // if (this.screen === "mobile") {
      //   if (localStorage.getItem("mobile")) {
      //     let resource = JSON.parse(localStorage.getItem("mobile"));
      //     this.fetchSections(resource);
      //   }
      // }
      // if (
      //   resource &&
      //   resource.mobile &&
      //   this.getScreenSize.screen === "mobile"
      // ) {
      //   this.fetchSections(JSON.parse(resource.mobile));
      // }
      // SiteService.getSitePageResources(this.siteId, this.pageId)
      //   .then((result) => {
      //     const data = JSON.stringify(result.data.data);
      //     localStorage.setItem("resources", data);
      //     this.onSortSectionsLayout();
      //   })
      //   .catch((err) => {
      //     console.log(err);
      //   });
    },
  },
  computed: {
    ...mapGetters(["getSelectedPage", "getPages", "getScreenSize"]),
  },
  watch: {
    getSelectedPage: function(pageId) {
      this.pageId = pageId;

      if (this.getPages.length > 0)
        this.title = this.getPages.find((item) => item.id === pageId).name;
    },
    getPages: function(pages) {
      if (this.getPages.length > 0) {
        this.pageId = pages[0].id;
        this.title = this.getPages.find((item) => item.id === pages[0].id).name;
      }
    },
  },
  created() {
    this.getQueryStringParams();
  },
};
</script>

<style scoped>
.v-app-bar ::v-deep.v-toolbar__content {
  padding-right: 0;
}
nav {
  -webkit-box-shadow: 0 10px 20px 0 rgb(0 0 0 / 5%);
  box-shadow: 0 10px 20px 0 rgb(0 0 0 / 5%);
  align-items: center;
  height: 58px;
  padding-left: 25px;
  position: fixed;
  top: 0;
  width: 100%;
  background: white;
  z-index: 15;
}
.logo {
  font-weight: 700;
}
.link-icon {
  height: 36px;
  width: 36px;
  min-width: 28px;
  min-height: 28px;
  font-size: 15px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.settings {
  align-items: center;
}
.separator {
  width: 1px;
  height: 16px;
  margin: 0 6px;
  background-color: rgba(0, 0, 0, 0.12);
}
.pages {
  font-size: 13px;
}
::v-deep.v-btn.fs-14 {
  font-size: 14px;
}
</style>
