<template>
  <GridLayout
    :layout="getSections"
    :row-height="rowHeight"
    :margin="margin"
    :is-draggable="false"
    :is-resizable="true"
    :is-mirrored="false"
    :vertical-compact="true"
    :autoSize="true"
    :allow-overlap="true"
    :allow-resize-grid="false"
    :responsive="getScreenSize.responsive"
    :use-css-transforms="true"
    :col-num="getScreenSize.cols"
    style="transition: width 1s ease 0s;"
    :style="{
      width: getScreenSize.width,
    }"
  >
    <div @click-outside="onShowMenu()">
      <template v-for="(item, index) in getSections">
        <GridItem
          :key="index"
          :autoSize="true"
          :x="item.x"
          :y="item.y"
          :w="getScreenSize.cols"
          :h="item.h"
          :i="item.i"
          :is-resizable="false"
          :minW="getScreenSize.cols"
          :id="item.i"
          :ref="'section'"
          style="transition: width 1s ease 0s;"
          :style="[
            {
              width: getScreenSize.width,
            },
            item.properties.style,
          ]"
        >
          <template v-if="item.properties.backgroundVideo">
            <div class="position-relative">
              <video autoplay muted loop id="myVideo">
                <source
                  :src="item.properties.backgroundVideo"
                  type="video/mp4"
                />
              </video>
            </div>
          </template>
          <SectionPreview
            :resources="item.resources"
            :margin="margin"
            :row-height="rowHeight"
            :responsive="getScreenSize.responsive"
            :cols="getScreenSize.cols"
          ></SectionPreview>
        </GridItem>
      </template>
    </div>
    <!-- Navbar -->
    <template v-if="getScreenSize.screen === 'mobile'">
      <!-- <nav
        v-show="drawer"
        :class="{ absolute: !fixedPostionStyle(), fixed: fixedPostionStyle() }"
        :style="[menuStyle(), { width: getScreenSize.width }]"
      >
        <v-list :style="[textStyle(), menuStyle()]" dense>
          <v-list-item
            v-for="item in list"
            :key="item.title"
            @click="goTo(item.path)"
            link
          >
            <v-list-item-content>
              <v-list-item-title>{{ item.name }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </nav> -->
      <v-navigation-drawer
        :style="[textStyle(), menuStyle()]"
        v-model="drawer"
        fixed
        temporary
        hide-overlay
      >
        <v-list :style="[textStyle(), menuStyle()]">
          <v-list-item
            v-for="item in list"
            :key="item.title"
            @click="goTo(item.path)"
            link
          >
            <v-list-item-content>
              <v-list-item-title>{{ item.name }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-navigation-drawer>
    </template>
    <!-- Navbar -->
  </GridLayout>
</template>

<script>
// @ is an alias to /src
import { GridLayout, GridItem } from "vue-grid-layout";
import { mapActions, mapGetters } from "vuex";
import SectionPreview from "../components/section/SectionPreview";
export default {
  name: "PreviewPage",
  components: {
    GridLayout,
    GridItem,
    SectionPreview,
  },
  data() {
    return {
      margin: [0, 0],
      rowHeight: 30,
      siteId: null,
      pageId: null,
      drawer: false,
      fixedPosition: false,
      list: [],
      styles: [],
    };
  },
  computed: {
    ...mapGetters([
      "getSections",
      "getPreventCollision",
      "getScreenSize",
      "getIsResizeable",
      "getIsAutoResize",
      "getSelectedWidgetById",
      "getAllowSorting",
      "getSelectedPage",
      "getPages",
      "getWebResources",
      "getMobileResources",
      "getLoadingPage",
      "getShowMenu",
      "getDataMenu",
    ]),
  },
  watch: {
    getSelectedPage: function(pageId) {
      this.pageId = pageId;
    },
    getPages: function(pages) {
      if (pages.length > 0) {
        this.pageId = pages[0].id;
      }
    },
    getScreenSize: function(type) {
      let resource;
      if (this.drawer === true) this.onShowMenu();
      if (type.screen === "web") {
        resource = this.getWebResources;
        this.fetchSections(resource);
      }
      if (type.screen === "mobile") {
        resource = this.getMobileResources;
        this.fetchSections(resource);
        this.onRearrangementResources();
      }
    },
    getShowMenu: function(value) {
      console.log(value);
      this.drawer = value;
    },
    getDataMenu: function(value) {
      this.list = value.fields;
      this.styles = value.styles;
      this.menuStyle();
      // this.textStyle();
    },
  },
  methods: {
    ...mapActions([
      "fetchSections",
      "fetchResources",
      "fetchWebResources",
      "fetchMobileResources",
      "onRearrangementResources",
      "onShowMenu",
    ]),
    getQueryStringParams: function() {
      if (this.$route.query.siteId) {
        this.siteId = +this.$route.query.siteId;
      }
      if (this.$route.query.pageId) {
        this.pageId = +this.$route.query.pageId;
      }
    },
    onFetchData: function() {
      let resource;
      if (this.getScreenSize.screen === "web") {
        resource = this.getWebResources;
        this.fetchSections(resource);
      }
      if (this.getScreenSize.screen === "mobile") {
        resource = this.getMobileResources;
        this.fetchSections(resource);
        // this.onRearrangementResources();
      }
    },
    menuStyle: function() {
      if (this.styles) {
        return this.styles.menu ? this.styles.menu : this.menu;
      } else {
        return this.menu;
      }
    },
    textStyle: function() {
      if (this.styles) {
        if (this.styles.elements) {
          this.textAlign = this.styles.elements.text.textAlign;
          return this.styles.elements.text
            ? this.styles.elements.text
            : this.text;
        } else {
          return this.text;
        }
      } else {
        return this.text;
      }
    },
    fixedPostionStyle: function() {
      if (this.menuStyle()) {
        return this.menuStyle().fixedPosition
          ? this.menuStyle().fixedPosition
          : this.fixedPosition;
      } else {
        return this.fixedPosition;
      }
    },
    onHover: function(elementHover) {
      if (this.hover) {
        if (elementHover !== undefined) {
          return elementHover;
        }
      } else {
        return "";
      }
    },
    goTo: function(path) {
      this.$emit("pagePath", path);
      this.onShowMenu();
    },
  },
  created() {
    this.getQueryStringParams();
  },
};
</script>
<style scoped>
#content {
  position: absolute;
  z-index: 0;
}
#myVideo {
  position: fixed;
  width: 100%;
  height: 100%;
  object-fit: fill;
}
.fixed {
  position: fixed;
}
.absolute {
  position: absolute;
}
nav {
  padding-top: 1rem;
}
::v-deep .v-navigation-drawer {
  box-shadow: none;
  left: unset;
  top: 48px !important;
}
</style>
