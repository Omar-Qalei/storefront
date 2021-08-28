<template>
  <!-- <div class="navbar"> -->
  <v-app-bar app color="white" dense clipped-right clipped-left dark>
    <v-btn
      color="primary"
      class="text-capitalize"
      text
      @click="$router.go(-1)"
      small
    >
      <v-icon>mdi-chevron-left</v-icon>
      Back to editor
    </v-btn>
    <div class="separator"></div>
    <a class="pages ml-2" @click="onDrawerPages">
      Pages: <b class="ml-1">{{ title }}</b>
    </a>
    <v-spacer></v-spacer>
    <h2 class="font-weight-regular">PREVIEW MODE</h2>
    <v-spacer></v-spacer>
    <div class="settings d-flex">
      <a
        class="link-icon"
        @click="
          fetchCols(4);
          onResizeSectionScreen({
            width: '379px',
            responsive: true,
            cols: 2,
            screen: 'mobile',
          });
        "
      >
        <span class="mdi mdi-cellphone-cog"></span>
      </a>
      <a
        class="link-icon"
        @click="
          fetchCols(24);
          onResizeSectionScreen({
            width: '100%',
            responsive: false,
            cols: 24,
            screen: 'web',
          });
        "
      >
        <span class="mdi mdi-monitor"></span>
      </a>
      <v-btn
        class="text-capitalize font-weight-light fs-14"
        color="primary"
        dark
        x-large
        @click="onBuildProduct"
      >
        Publish Website
      </v-btn>
    </div>
  </v-app-bar>
  <!-- </div> -->
</template>

<script>
import { mapActions, mapGetters } from "vuex";
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
      "fetchCols",
    ]),
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
      }
      if (this.$route.query.pageId) {
        this.pageId = +this.$route.query.pageId;
      }
    },
    onBuildProduct: function() {},
  },
  computed: {
    ...mapGetters(["getSelectedPage", "getPages", "getScreenSize", "getCols"]),
  },
  watch: {
    getSelectedPage: function(pageId) {
      this.pageId = pageId;
      if (this.getPages.length > 0)
        this.title = this.getPages.find((item) => item.id === pageId).name;
    },
    getPages: function(pages) {
      if (this.getPages.length > 0) {
        if (this.$route.query.pageId === undefined) {
          this.pageId = pages[0].id;
          this.title = this.getPages.find(
            (item) => item.id === pages[0].id
          ).name;
        } else {
          this.title = this.getPages.find(
            (item) => item.id === this.pageId
          ).name;
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
.v-app-bar {
  z-index: 15 !important;
}
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
h2 {
  font-size: 12px;
  color: black;
  letter-spacing: 0.22em;
}
</style>
