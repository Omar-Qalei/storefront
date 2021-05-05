<template>
  <GridLayout
    :layout="getSections"
    :col-num="12"
    :row-height="30"
    :margin="[0, 0]"
    :is-draggable="false"
    :is-resizable="true"
    :is-mirrored="false"
    :vertical-compact="true"
    :autoSize="true"
    :use-css-transforms="true"
  >
    <template v-for="(item, index) in getSections">
      <div
        :key="index"
        @dragover="onMouseTouched({ i: item.i, indexSection: index })"
        @click="onSelectedSection(item.id)"
      >
        <GridItem
          :class="{ editMode: true }"
          :autoSize="true"
          :x="item.x"
          :y="item.y"
          :w="12"
          :h="item.h"
          :i="item.i"
          :minW="12"
          :minH="getCurrentSectionLayout"
          class="section"
          :id="item.i"
          :ref="'section'"
          :style="[selectedSection !== null ? activeSection : '']"
          @resize="resizeEvent"
        >
          <!-- statusSection ? sectionLayout : '',
            statusSection ? {'min-height': 10 * 30 + 'px', 'transform': 'translate3d(0px,' + -10 * 30 +'px, 0px)'} : '', -->
          <!-- index: {{ index }} id: {{item.id}} -->

          <!-- @sectionHeight="sectionHeight = $event" -->
          <SectionWidget
            :resources="item.resources"
            :statusSection="item.id === selectedSection"
            :sectionId="item.id"
            :statusPreventCollision="getPreventCollision"
            :minHLayout="item.h"
            @onDragElement="onDragElement($event)"
            @onMoveElementY="onMoveElementY($event)"
            :marginSection="marginSection"
          ></SectionWidget>
          <!-- {{statusSection}} -->
          <v-btn
            class="btn-add-section"
            dark
            color="indigo"
            v-if="item.id === selectedSection"
            @click="addNewSection(item.selectedIndex)"
            >Add Section {{ item.h }}</v-btn
          >
          <!-- <div
            v-if="!preview"
            @click="removeItem({ key: index })"
            style="position: absolute; bottom: 0px; left: 4px"
          >
            <i class="fa fa-trash" aria-hidden="true"></i>
          </div> -->

          <!-- <TextWidget
            v-if="item.type == 'title'"
            :preview="preview"
            :contenteditable="contenteditable"
            :item="item"
            :itemIndex="index"
          ></TextWidget>

          <TextAreaWidget
            v-if="item.type == 'content'"
            :preview="preview"
            :contenteditable="contenteditable"
            :item="item"
            :itemIndex="index"
          ></TextAreaWidget>

          <ImageWidget
            v-if="item.type == 'image'"
            :preview="preview"
            :contenteditable="contenteditable"
            :item="item"
            :itemIndex="index"
          ></ImageWidget>

          <ButtonWidget
            v-if="item.type == 'button'"
            :preview="preview"
            :contenteditable="contenteditable"
            :item="item"
            :itemIndex="index"
          ></ButtonWidget> -->

          <!-- <ButtonWidget
            v-if="item.type == 'button'"
            :refItem="refGridItem[index]"
          /> -->
          <!-- <SectionWidget
              v-if="item.type == 'section'"
              :key="item.i"
              :layouts="item.layouts"
            /> -->
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
import SectionWidget from "../components/SectionWidget";

export default {
  name: "GridView",
  components: {
    GridLayout,
    GridItem,
    SectionWidget,
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
      marginSection: [10, 10],
    };
  },
  methods: {
    ...mapActions([
      "onSetLayout",
      "fetchResources",
      "addNewSection",
      "onMouseTouched",
      "onRemoveDuplicated",
      "updateSectionLayout",
      "onSelectedSectionByIndex",
    ]),
    onSelectedSection(sectionId) {
      this.selectedSection = null;
      this.selectedSection = sectionId;
      this.onSelectedSectionByIndex(sectionId);
    },
    onDragElement(event) {
      this.statusSection = event;
    },
    onMoveElementY(event) {
      this.updateSectionLayout({
        id: this.selectedSection,
        h: event.max,
        gridHeight: event.gridHeight,
        margin: event.margin,
      });
    },
    resizeEvent: function(i, newH, newW, newHPx, newWPx) {
      console.log(
        "RESIZE i=" +
          i +
          ", H=" +
          newH +
          ", W=" +
          newW +
          ", H(px)=" +
          newHPx +
          ", W(px)=" +
          newWPx
      );
    },
  },
  computed: {
    ...mapGetters([
      "getSections",
      "getPreventCollision",
      "getCurrentSectionLayout",
    ]),
  },
  created() {
    this.fetchResources();
    this.onSelectedSectionByIndex(this.selectedSection);
  },
  updated() {
    this.onRemoveDuplicated(this.$refs["section"]);
    // console.log(this.$refs["section"][1].style)
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
.vue-grid-item.section:not(:last-child):not(:first-child) {
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
</style>
