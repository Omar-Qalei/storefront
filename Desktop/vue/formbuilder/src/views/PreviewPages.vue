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
    style="transition: width 2s ease 0s;"
    :style="{
      width: getScreenSize.width,
    }"
  >
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
        style="transition: width 2s ease 0s;"
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
              <source :src="item.properties.backgroundVideo" type="video/mp4" />
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
    };
  },
  methods: {
    ...mapActions([
      "fetchSections",
      "fetchResources",
      "fetchWebResources",
      "fetchMobileResources",
      "onRearrangementResources",
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
    ]),
  },
  created() {
    this.getQueryStringParams();
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
</style>
