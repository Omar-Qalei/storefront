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
    :allow-resize-grid="getIsResizeable"
    :responsive="getScreenSize.responsive"
    :use-css-transforms="true"
    :col-num="getScreenSize.cols"
    style="transition: width 1s ease 0s;"
    :style="{
      width: getScreenSize.width,
    }"
  >
    <template v-for="(item, index) in getSections">
      <div
        :key="index"
        @mouseleave="hoverElement = null"
        @mouseover="onMouseOverElement(item)"
        @dragover="onMouseTouched({ i: item.i, indexSection: index })"
        @mousedown="
          selectedSection = item.id;
          onSelectedSection({ index: index, id: item.id });
          currentSelectedSection = item.id;
          selectedSectionByI = item.i;
          selectedElement = item.id;
          selectedSection = item.id;
          onSelectedWidget(item);
        "
      >
        <GridItem
          :class="{
            editMode: true,
            resizeSection: true,
            holdSection:
              selectedSection !== item.id && item.resources.length === 0,
          }"
          :autoSize="item.id === selectedSection && getIsAutoResize"
          :x="item.x"
          :y="item.y"
          :w="getScreenSize.cols"
          :h="item.h"
          :i="item.i"
          :is-resizable="item.id === selectedSection"
          :minW="getScreenSize.cols"
          :id="item.i"
          :ref="'section'"
          style="transition: width 1s ease 0s;"
          :style="[
            selectedSection === item.id ? activeSection : '',
            selectedElement === item.id ? showElement : '',
            hoverElement === item.id ? activeSection : '',
            getDefaultContent(item),
            {
              width: getScreenSize.width,
            },
            {
              height: containerHeight(placeholders(item.h)),
            },
          ]"
          @resize="resizeEvent"
          @resized="resizedEvent"
        >
          <!-- calcHeightSection(item, index), -->
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
          <template
            v-if="
              item.id === selectedSection &&
                currentSelectedSection === selectedSection
            "
          >
            <v-col
              class="position-absolute py-0 px-auto"
              :style="getDefaultDesign(item)"
            >
              <GridLayout
                :layout="getSections"
                :row-height="rowHeight"
                :margin="margin"
                :is-draggable="false"
                :is-resizable="false"
                :is-mirrored="false"
                :vertical-compact="false"
                :autoSize="false"
                :allow-overlap="false"
                :allow-resize-grid="getIsResizeable"
                :responsive="getScreenSize.responsive"
                :use-css-transforms="false"
                :col-num="getScreenSize.cols"
                style="transition: width 1s ease 0s;"
              >
                <GridItem
                  v-for="(placeholder, placeholderIndex) in placeholders(
                    item.h
                  )"
                  :key="placeholderIndex + 'placeholder'"
                  :x="placeholder.x"
                  :y="placeholder.y"
                  :w="placeholder.w"
                  :h="placeholder.h"
                  :i="placeholder.i"
                  :is-resizable="false"
                  :autoSize="true"
                  :class="{
                    hidePlacerholder: !displayPlaceholder,
                    placeholder: true,
                  }"
                ></GridItem>
              </GridLayout>
            </v-col>
          </template>
          <template v-if="item.resources.length === 0">
            <v-row class="h-100" align="center" justify="center">
              <v-col>
                <p class="ma-0 text-center">
                  This is a blank section, start adding to it.
                </p>
              </v-col>
            </v-row>
          </template>
          <label
            v-show="hoverElement === item.id && selectedElement !== item.id"
            class="hint"
            >Section</label
          >
          <!-- getElementById: {{ getSelectedWidgetById.id }} selectedIndex:{{
            getSelectedWidgetById.selectedIndex
          }}
          id: <b>{{ item.id }}</b> index: {{ index }} selectedIndex:
          {{ item.selectedIndex }} -->
          <!-- 
          {{ item.i }}//// id: <b>{{ item.id }}</b> index:
          {{ index }} selectedIndex: {{ item.selectedIndex }} -->
          <SettingsWidget
            :item="item"
            :show="item.i === getSelectedWidgetById.i"
            :sectionId="item.id"
          />

          <!-- :style="getDefaultDesign(item)" -->
          <SectionWidget
            :resources="item.resources"
            :statusSection="item.id === selectedSection"
            :sectionId="item.id"
            :statusPreventCollision="getPreventCollision"
            :minHLayout="item.h"
            @onDragElement="onDragElement($event)"
            @onMoveElementY="onMoveElementY($event)"
            @onMouseUpGrid="onMouseUpGrid($event)"
            @onMoveGrid="onMoveGrid($event)"
            @resizeGrid="resizeGrid($event)"
            @onMovedWidget="onMovedWidget()"
            @onResizedWidget="onResizedWidget()"
            :margin="margin"
            :row-height="rowHeight"
            :responsive="getScreenSize.responsive"
            :cols="getScreenSize.cols"
            :section="item"
            :style="getDefaultDesign(item)"
            :siteId="siteId"
            :pageId="pageId"
          ></SectionWidget>
          <template v-if="getScreenSize.screen === 'web'">
            <v-btn
              class="btn-add-section-web"
              dark
              color="#357df9"
              v-if="item.id === selectedSection"
              @click="
                addNewSection(item.selectedIndex);
                onFetchData();
              "
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
              v-if="item.id === selectedSection"
              @click="
                addNewSection(item.selectedIndex);
                onFetchData();
              "
              ><v-icon class="icon-add-section">mdi-plus</v-icon></v-btn
            >
          </template>
        </GridItem>
      </div>
    </template>
  </GridLayout>

  <!-- </div> -->
</template>

<script>
// @ is an alias to /src
import { GridLayout, GridItem } from "vue-grid-layout";
import { mapActions, mapGetters } from "vuex";
import SectionWidget from "../components/section/SectionWidget";
import SettingsWidget from "../components/settings/SettingsWidget";
import { SiteService } from "../services/site/site";

export default {
  name: "GridView",
  components: {
    GridLayout,
    GridItem,
    SectionWidget,
    SettingsWidget,
  },
  data() {
    return {
      isDraggable: true,
      isResizable: true,
      preview: true,
      contenteditable: true,
      index: 0,
      activeSection: {
        border: "2px solid #357df9",
      },
      sectionLayout: {
        position: "relative",
        height: "100%",
      },
      selectedSection: 0,
      statusSection: false,
      margin: [0, 0],
      padding: [0, 0],
      rowHeight: 24,
      displayPlaceholder: false,
      currentSelectedSection: 0,
      selectedSectionByI: null,
      dialog: false,
      hoverElement: 0,
      siteId: null,
      pageId: null,
      selectedElement: null,
      showElement: {
        zIndex: "4",
      },
      test: [],
    };
  },
  methods: {
    ...mapActions([
      "fetchSections",
      "onSetLayout",
      "fetchResources",
      "addNewSection",
      "onMouseTouched",
      "onUpdateRefs",
      "updateSectionLayout",
      "onSelectedSection",
      "onResizeSection",
      "onUpdateSectionLayoutResized",
      "onSelectedWidgetById",
      "onCheckUpdateSectionLayoutResized",
      "fetchWebResources",
      "fetchMobileResources",
      "onRearrangementResources",
      "onHistoryPages",
    ]),
    onDragElement: function(event) {
      this.statusSection = event;
    },
    onMoveElementY: function(event) {
      this.updateSectionLayout({
        sectionId: this.selectedSection,
        h: event.max,
        gridHeight: event.gridHeight,
        margin: event.margin,
      });
    },
    // i, newH, newW, newHPx, newWPx
    resizeEvent: function(i, newH) {
      this.displayPlaceholder = true;
      this.onResizeSection(true);
      const data = {
        sectionId: this.selectedSection,
        h: newH,
      };
      this.onUpdateSectionLayoutResized(data);
      this.updateSectionLayout(data);
    },
    // containerHeight: function(h) {
    //   let containerHeight = null;
    //   if (!isNaN(h) && h !== undefined) {
    //     containerHeight =
    //       h * (this.rowHeight + this.margin[1]) + this.margin[1] + "px";
    //   }
    //   return containerHeight;
    // },
    placeholders: function(h) {
      const placeholderGrids = [];
      if (this.getScreenSize.width === "100%") {
        for (let row = 0; row < h - 1; row++) {
          for (let col = 0; col <= this.getScreenSize.cols - 1; col++) {
            if (row % 2 === 0) {
              placeholderGrids.push({
                x: col,
                y: row,
                w: 1,
                h: 2,
                i: "row" + row,
              });
            } else {
              row = row + 1;
              placeholderGrids.push({
                x: col,
                y: row,
                w: 1,
                h: 2,
                i: "row" + row,
              });
            }
          }
        }
      }
      if (this.getScreenSize.width === "379px") {
        for (let row = 0; row < h - 1; row++) {
          for (let col = 0; col <= this.getScreenSize.cols; col++) {
            if (row % 2 === 0) {
              placeholderGrids.push({
                x: col,
                y: row,
                w: 1,
                h: 2,
                i: "row" + row,
              });
            } else {
              row = row + 1;
              placeholderGrids.push({
                x: col,
                y: row,
                w: 1,
                h: 2,
                i: "row" + row,
              });
            }
          }
        }
      }
      return placeholderGrids;
    },
    resizeGrid: function(event) {
      this.displayPlaceholder = event;
      // if (this.selectedSectionByI) {
      //   let h =
      //     document.getElementById(this.selectedSectionByI).offsetHeight +
      //     this.margin[0] +
      //     this.margin[1];
      //   document.getElementById(this.selectedSectionByI).style.height =
      //     h + "px";
      // }
      // document.querySelectorAll(".section").forEach((element) => {
      //   let h = element.offsetHeight + this.margin[0] + this.margin[1];
      //   document.getElementById(element.id).style.height = h + "px";
      // });
    },
    resizedEvent: function() {
      // this.onHistoryPages(this.getWebResources);
      // this.onMobileHistoryPage(this.getMobileResources);
      // if (this.getSelectedWidgetById.type !== "section") {
      const webResources = JSON.stringify(this.getWebResources);
      const mobileResources = JSON.stringify(this.getMobileResources);
      this.onHistoryPages({
        saved: false,
        web: JSON.parse(webResources),
        mobile: JSON.parse(mobileResources),
      });
      SiteService.addSitePageResourceWeb(
        this.siteId,
        this.pageId,
        JSON.stringify(this.getWebResources)
      )
        .then((result) => {
          console.log("Web posted", result);
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
          console.log("Mobile posted", result);
        })
        .catch((error) => {
          console.log(error);
        });
      // }
    },
    onMoveGrid: function(event) {
      this.displayPlaceholder = event;
      // if (this.selectedSectionByI) {
      //   let h =
      //     document.getElementById(this.selectedSectionByI).offsetHeight +
      //     this.margin[0] +
      //     this.margin[1];
      //   document.getElementById(this.selectedSectionByI).style.height =
      //     h + "px";
      // }
    },
    onMouseUpGrid: function(event) {
      this.displayPlaceholder = event;
    },
    onMouseOverElement: function(event) {
      this.hoverElement = event.id;
    },
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
        this.onRearrangementResources();
      }
    },
    onMovedWidget: function() {
      if (this.$route.query.pageId && this.$route.query.pageId !== this.pageId)
        this.pageId = +this.$route.query.pageId;
      // if (this.getSelectedWidgetById.type !== "section") {
      // thiz.fetchWebResources(thiz.getWebResources);
      // thiz.fetchMobileResources(thiz.getMobileResources);

      const webResources = JSON.stringify(this.getWebResources);
      const mobileResources = JSON.stringify(this.getMobileResources);
      this.onHistoryPages({
        saved: false,
        web: JSON.parse(webResources),
        mobile: JSON.parse(mobileResources),
      });
      // this.onMobileHistoryPage(this.getMobileResources);
      SiteService.addSitePageResourceWeb(
        this.siteId,
        this.pageId,
        JSON.stringify(this.getWebResources)
      )
        .then((result) => {
          console.log("Web posted", result);
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
          console.log("Mobile posted", result);
        })
        .catch((error) => {
          console.log(error);
        });
      // }
    },
    onResizedWidget: function() {
      if (this.$route.query.pageId && this.$route.query.pageId !== this.pageId)
        this.pageId = +this.$route.query.pageId;
      // if (this.getSelectedWidgetById.type !== "section") {
      // this.onHistoryPages(this.getWebResources);
      // this.onMobileHistoryPage(this.getMobileResources);
      const webResources = JSON.stringify(this.getWebResources);
      const mobileResources = JSON.stringify(this.getMobileResources);
      this.onHistoryPages({
        saved: false,
        web: JSON.parse(webResources),
        mobile: JSON.parse(mobileResources),
      });
      SiteService.addSitePageResourceWeb(
        this.siteId,
        this.pageId,
        JSON.stringify(this.getWebResources)
      )
        .then((result) => {
          console.log("Web posted", result);
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
          console.log("Mobile posted", result);
        })
        .catch((error) => {
          console.log(error);
        });
      // }
    },
    onSelectedWidget: function(item) {
      this.onSelectedWidgetById(item);
    },
    getDefaultDesign: function(item) {
      if (item.properties.style)
        if (item.properties.style.design)
          if (item.properties.style.design[this.getScreenSize.screen]) {
            return item.properties.style.design[this.getScreenSize.screen];
          }
    },
    getDefaultContent: function(item) {
      if (item.properties.style)
        if (item.properties.style.content) return item.properties.style.content;
    },
    containerHeight: function(layout) {
      // console.log("bottom: " + bottom(this.layout))
      // console.log("rowHeight + margins: " + (this.rowHeight + this.margin[1]) + this.margin[1])
      const containerHeight =
        this.bottom(layout) * (this.rowHeight + this.margin[0]) +
        this.margin[1] +
        "px";
      // For calculate by number of rows rather than pixels
      return containerHeight;
    },
    bottom: function(layout) {
      let max = 0,
        bottomY;
      for (let i = 0, len = layout.length; i < len; i++) {
        bottomY = layout[i].y + layout[i].h;
        if (bottomY > max) max = bottomY;
      }
      return max;
    },
    calcContainerHeightByRow: function(h) {
      let height = Math.round((h - this.margin[1]) / this.rowHeight);
      if (height % 2 !== 0) {
        height += 1;
      }
      return height;
    },
    setWebStyles: function() {
      document.documentElement.style.setProperty("--h1", "80px");
      document.documentElement.style.setProperty("--h2", "64px");
      document.documentElement.style.setProperty("--h3", "48px");
      document.documentElement.style.setProperty("--h4", "40px");
      document.documentElement.style.setProperty("--h5", "32px");
      document.documentElement.style.setProperty("--h6", "24px");
      document.documentElement.style.setProperty("--p1", "18px");
      document.documentElement.style.setProperty("--p2", "16px");
      document.documentElement.style.setProperty("--p3", "14px");
    },
    setMobileStyles: function() {
      document.documentElement.style.setProperty("--h1", "44px");
      document.documentElement.style.setProperty("--h2", "36px");
      document.documentElement.style.setProperty("--h3", "32px");
      document.documentElement.style.setProperty("--h4", "28px");
      document.documentElement.style.setProperty("--h5", "24px");
      document.documentElement.style.setProperty("--h6", "20px");
      document.documentElement.style.setProperty("--p1", "18px");
      document.documentElement.style.setProperty("--p2", "16px");
      document.documentElement.style.setProperty("--p3", "14px");
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
      "getWebHistoryPage",
      "getMobileHistoryPage",
      "getUndoPage",
      "getRedoPage",
    ]),
  },
  created() {
    // this.onSelectedWidgetById({});
    this.getQueryStringParams();
    this.onSelectedSection({ index: 0, id: 0 });
    if (typeof this.getSelectedWidgetById === "object")
      this.selectedElement = this.getSelectedWidgetById.id;
    if (this.getScreenSize.screen === "web")
      this.fetchSections(this.getWebResources);
    if (this.getScreenSize.screen === "mobile")
      this.fetchSections(this.getMobileResources);
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
        this.setWebStyles();
        let cols = document.getElementsByClassName("h1");
        for (let i = 0; i < cols.length; i++) {
          cols[i].style.fontSize = "80px";
        }
        this.fetchSections(resource);
      }
      if (type.screen === "mobile") {
        resource = this.getMobileResources;
        this.fetchSections(resource);
        this.setMobileStyles();
        let cols = document.getElementsByClassName("h1");
        for (let i = 0; i < cols.length; i++) {
          cols[i].style.fontSize = "44px";
        }
        this.onRearrangementResources();
        this.onCheckUpdateSectionLayoutResized({
          sectionId: this.selectedSection,
        });
      }
    },
    // getUndoPage: function(value) {
    //   console.log("getUndoPage", value);
    //   let resource;
    //   if (this.getScreenSize.screen === "web") {
    //     resource = this.getWebHistoryPage[value];
    //     this.fetchSections(resource);
    //   }
    //   if (this.getScreenSize.screen === "mobile") {
    //     resource = this.getMobileHistoryPage[value];
    //     this.fetchSections(resource);
    //     this.onRearrangementResources();
    //   }
    // },
    // getRedoPage: function(value) {
    //   console.log("getRedoPage", value);
    //   let resource;
    //   if (this.getScreenSize.screen === "web") {
    //     resource = this.getWebHistoryPage[value];
    //     this.fetchSections(resource);
    //   }
    //   if (this.getScreenSize.screen === "mobile") {
    //     resource = this.getMobileHistoryPage[value];
    //     this.fetchSections(resource);
    //     this.onRearrangementResources();
    //   }
    // },
  },
  mounted() {
    const thiz = this;
    window.addEventListener("mouseup", function() {
      thiz.displayPlaceholder = false;
      thiz.onCheckUpdateSectionLayoutResized({
        sectionId: thiz.selectedSection,
      });
      if (thiz.getSelectedWidgetById.type === "section") {
        thiz.getWebResources.forEach((element) => {
          if (element.id === thiz.getSelectedWidgetById.id)
            element.properties = thiz.getSelectedWidgetById.properties;
        });
        thiz.getMobileResources.forEach((element) => {
          if (element.id === thiz.getSelectedWidgetById.id)
            element.properties = thiz.getSelectedWidgetById.properties;
        });
      }
      if (thiz.getSelectedWidgetById.type !== "section") {
        thiz.getWebResources.forEach((element) => {
          element.resources.forEach((obj) => {
            if (obj.gridKey === thiz.getSelectedWidgetById.gridKey)
              obj.properties = thiz.getSelectedWidgetById.properties;
          });
        });
        thiz.getMobileResources.forEach((element) => {
          element.resources.forEach((obj) => {
            if (obj.gridKey === thiz.getSelectedWidgetById.gridKey)
              obj.properties = thiz.getSelectedWidgetById.properties;
          });
        });
      }
      // thiz.fetchWebResources(thiz.getWebResources);
      // thiz.fetchMobileResources(thiz.getMobileResources);
    });
  },
  updated() {
    this.onUpdateRefs(this.$refs["section"]);
    // this.placeholders();
    // document.querySelectorAll(".resizeSection").forEach((element) => {
    //   let h =
    //     element.offsetHeight +

    //   // let transformHeight = (element.offsetHeight = this.margin[0]);
    //   // document.getElementById(element.id).style.transform =
    //   //   "translate3d(10px," + transformHeight + "px, 0px)";
    //   console.log(h + "px");
    //   // document.getElementById(element.id).style.height = h + "px";
    // });
  },
  destroyed() {
    // this.selectedSection
    console.log("destoryed Grid View");
    this.onSelectedWidgetById({});
    this.selectedSection = 0;
    this.onCheckUpdateSectionLayoutResized({
      sectionId: 0,
    });
  },
};
</script>
<style scoped>
#content {
  position: absolute;
  z-index: 0;
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
.icon-add-section {
  font-size: 16px !important;
}
.placeholder {
  border: 1px solid #ccc;
}
.hidePlacerholder {
  display: none;
}
#myVideo {
  position: fixed;
  width: 100%;
  height: 100%;
  object-fit: fill;
}
.hint {
  font-size: 14px;
  font-weight: 400;
  line-height: 1.43;
  text-transform: none;
  letter-spacing: 0;
  position: absolute;
  top: -9px;
  left: 15px;
  border-radius: 15px;
  z-index: 0;
  padding: 0 8px;
  color: #fff;
  background: #357df9;
}
.holdSection {
  border: 1px dashed #9da3a9;
}
.position-absolute {
  position: absolute;
}
.px-auto {
  padding-right: unset;
  padding-left: unset;
}
</style>
