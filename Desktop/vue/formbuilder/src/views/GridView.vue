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
    :style="{
      width: getScreenSize.width,
      margin: '0 auto',
    }"
  >
    <template v-for="(item, index) in getSections">
      <div
        :key="index"
        @dragover="onMouseTouched({ i: item.i, indexSection: index })"
        @click="
          selectedSection = item.id;
          onSelectedSection({ index: index, id: item.id });
          onSelectedWidgetById(item);
        "
        @mousedown="
          currentSelectedSection = item.id;
          selectedSectionByI = item.i;
        "
        @mouseup="displayPlaceholder = false"
      >
        <SettingsWidget :show="item.i === getSelectedWidgetById.i" />
        <GridItem
          :class="{ editMode: true, resizeSection: true }"
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
          :style="[
            selectedSection !== null ? activeSection : '',
            {
              width: getScreenSize.width,
            },
            item.properties.style,
          ]"
          @resize="resizeEvent"
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
          <template
            v-if="
              item.id === selectedSection &&
                currentSelectedSection === selectedSection
            "
          >
            <GridItem
              v-for="(placeholder, placeholderIndex) in placeholders(item.h)"
              :key="placeholderIndex + 'placeholder'"
              :x="placeholder.x"
              :y="placeholder.y"
              :w="placeholder.w"
              :h="placeholder.h"
              :i="placeholder.i"
              :is-resizable="false"
              :class="{
                hidePlacerholder: !displayPlaceholder,
                placeholder: true,
              }"
            ></GridItem>
          </template>
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
            :margin="margin"
            :row-height="rowHeight"
            :responsive="getScreenSize.responsive"
            :cols="getScreenSize.cols"
            :section="item"
          ></SectionWidget>
          <v-btn
            class="btn-add-section"
            dark
            color="indigo"
            v-if="item.id === selectedSection"
            @click="addNewSection(item.selectedIndex)"
            >Add Section {{ item.h }}</v-btn
          >
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
        border: "0.5px solid black",
      },
      sectionLayout: {
        position: "relative",
        height: "100%",
      },
      selectedSection: 0,
      statusSection: false,
      margin: [0, 0],
      rowHeight: 30,
      displayPlaceholder: false,
      currentSelectedSection: "",
      selectedSectionByI: null,
      dialog: false,
    };
  },
  methods: {
    ...mapActions([
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
    ]),
    onDragElement(event) {
      this.statusSection = event;
    },
    onMoveElementY(event) {
      this.updateSectionLayout({
        sectionId: this.selectedSection,
        h: event.max,
        gridHeight: event.gridHeight,
        margin: event.margin,
      });
      console.log(event);
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
    containerHeight: function(h) {
      let containerHeight = null;
      if (!isNaN(h) && h !== undefined) {
        containerHeight =
          h * (this.rowHeight + this.margin[1]) + this.margin[1] + "px";
      }
      return containerHeight;
    },
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
      if (this.getScreenSize.width === "320px") {
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
    resizeGrid(event) {
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
    onMoveGrid(event) {
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
    onMouseUpGrid(event) {
      this.displayPlaceholder = event;
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
    ]),
  },
  created() {
    this.fetchResources();
    this.onSelectedSection({ index: 0, id: 0 });
  },
  updated() {
    this.onUpdateRefs(this.$refs["section"]);
    // this.placeholders();
    // document.querySelectorAll(".section").forEach((element) => {
    //   let h = element.offsetHeight + this.margin[0] + this.margin[1];
    //   // let transformHeight = (element.offsetHeight = this.margin[0]);
    //   // document.getElementById(element.id).style.transform =
    //   //   "translate3d(10px," + transformHeight + "px, 0px)";
    //   document.getElementById(element.id).style.height = h + "px";
    // });
  },
};
</script>
<style scoped>
.vue-grid-layout {
  /* background: #eee; */
}
/* .vue-grid-item.section:first-child {
  border-top: 0.5px solid black;
  border-left: 0.5px solid black;
  border-right: 0.5px solid black;
} */
.vue-grid-item.section {
  /* border-left: 0.5px solid black;
  border-right: 0.5px solid black; */
}
/* .vue-grid-item.section {
  position: relative;
  min-height: 10rem;
} */
#content {
  position: absolute;
  z-index: 0;
}
.btn-add-section {
  position: absolute;
  left: 50%;
  bottom: -1rem;
  margin-left: -4rem;
  z-index: 1;
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
}
</style>
