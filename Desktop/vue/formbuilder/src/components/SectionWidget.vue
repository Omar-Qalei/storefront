<template>
  <div class="grid-vue">
    <GridLayout
      :layout="resources"
      :col-num="cols"
      :row-height="rowHeight"
      :is-draggable="statusSection"
      :is-resizable="statusSection"
      :is-mirrored="false"
      :vertical-compact="false"
      :responsive="responsive"
      :allow-overlap="false"
      :margin="margin"
      :use-css-transforms="statusSection"
      :autoSize="getResizeSectionStatus"
      :ref="'gridLayout'"
      id="layout"
      :prevent-collision="statusPreventCollision || !statusMoveElement"
      @layoutHeight="layoutHeight"
    >
      <template v-for="(item, index) in resources">
        <div
          :key="index"
          @mousedown="
            onMouseDown;
            onMoveElement(index);
          "
          @click="onSelectedWidgetById(item)"
          @mouseup="onMouseUp"
        >
          <GridItem
            v-if="item.type != 'form'"
            :class="{ editMode: !preview, dropped: item.i === 'drop' }"
            :x="item.x"
            :y="item.y"
            :w="item.w"
            :h="item.h"
            :i="item.i"
            :minH="2"
            :minW="1"
            :autoSize="true"
            :static="statusPreventCollision"
            ref="gridItem"
            @move="moveElementY(item)"
            @resize="resizeEvent"
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
            <ButtonWidget v-if="item.type == 'button'" :item="item" />
            <CarouselWidget v-if="item.type == 'carousel'" />
            <TextWidget v-if="item.type == 'text'" />
            <ImageWidget v-if="item.type == 'image'" />
            <MenuWidget v-if="item.type == 'menu'" />
            <VideoWidget v-if="item.type == 'video'" />
            <MapWidget v-if="item.type == 'map'" />
            <AudioWidget v-if="item.type == 'audio'" />
          </GridItem>

          <GridItem
            v-if="item.type == 'form'"
            :class="{ editMode: !preview, dropped: item.i === 'drop' }"
            :x="item.x"
            :y="item.y"
            :w="item.w"
            :h="item.h"
            :i="item.i"
            :minW="1"
            :autoSize="true"
            :is-resizable-vertical="false"
            :static="statusPreventCollision"
            ref="gridItem"
            @move="moveElementY(item)"
            @resize="resizeEvent"
          >
            <FormWidget :item="item" />
          </GridItem>
        </div>
      </template>
    </GridLayout>
  </div>
</template>

<script>
// @ is an alias to /src
import { GridLayout, GridItem } from "vue-grid-layout";
import { mapActions, mapGetters } from "vuex";
import ButtonWidget from "../components/button/ButtonWidget";
import CarouselWidget from "../components/CarouselWidget";
import TextWidget from "../components/TextWidget";
import ImageWidget from "../components/ImageWidget";
import FormWidget from "../components/form/FormWidget";
import MenuWidget from "../components/MenuWidget";
import VideoWidget from "../components/VideoWidget";
import MapWidget from "../components/MapWidget";
import AudioWidget from "../components/AudioWidget";

export default {
  name: "SectionWidget",
  components: {
    GridLayout,
    GridItem,
    ButtonWidget,
    CarouselWidget,
    TextWidget,
    ImageWidget,
    FormWidget,
    MenuWidget,
    VideoWidget,
    MapWidget,
    AudioWidget,
  },
  props: {
    resources: Array,
    statusSection: Boolean,
    statusPreventCollision: Boolean,
    minHLayout: Number,
    sectionId: Number,
    cols: Number,
    margin: Array,
    responsive: Boolean,
    rowHeight: Number,
  },
  data() {
    return {
      isDraggable: true,
      isResizable: true,
      preview: true,
      contenteditable: true,
      statusMoveElement: false,
    };
  },
  methods: {
    ...mapActions([
      "onSetLayout",
      "updateSectionLayout",
      "onResizeSection",
      "onUpdateSectionLayoutGridResized",
      "onSelectedWidgetById",
    ]),
    onMouseUp() {
      this.$emit("onDragElement", false);
      this.statusMoveElement = false;
      this.onResizeSection(false);
      this.$emit("onMouseUpGrid", false);
    },
    onMouseDown() {
      this.$emit("onDragElement", true);
      this.statusMoveElement = true;
    },
    onMoveElement() {
      this.$emit("onMoveGrid", true);
    },
    moveElementY(result) {
      let max = 0;
      this.resources.forEach((element) => {
        if (element.y > max) {
          max = element.y;
        }
      });
      let data = {
        gridHeight: result.h,
        max: max,
        margin: [],
      };
      this.onResizeSection(true);
      this.$emit("onMoveElementY", data);
      this.$emit("sectionH", document.getElementById("layout").style.height);
    },
    layoutHeight: function(layoutH) {
      const data = {
        sectionId: this.sectionId,
        h: layoutH !== 0 ? layoutH : this.minHLayout,
      };
      // console.log(data);
      // this.$emit(
      //   "sectionHeight",
      //   document.getElementById("layout").style.height
      // );
      this.updateSectionLayout(data);
      // this.$emit("layout-height", layoutH);
    },
    resizeEvent: function() {
      this.onResizeSection(true);
      const data = {
        sectionId: this.sectionId,
        h: this.minHLayout,
      };
      this.$emit("resizeGrid", true);
      this.onUpdateSectionLayoutGridResized(data);
    },
  },
  computed: {
    ...mapGetters(["getResources", "getResizeSectionStatus"]),
  },
  updated() {
    var data = {
      refGridLayout: this.$refs["gridLayout"],
      colNum: this.colNum,
    };
    this.onSetLayout(data);
  },
};
</script>
<style scoped>
.vue-grid-layout {
  /* background: #eee; */
  /* height: 100%; */
  /* border: 1px solid black; */
}
.vue-grid-item:not(.vue-grid-placeholder) {
  /* background: #ccc; */
  /* border: 1px solid black; */
}
.vue-grid-item .resizing {
  opacity: 0.9;
}
/* .vue-grid-item .static {
  background: #cce;
} */
.vue-grid-item .text {
  font-size: 24px;
  text-align: center;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  height: 100%;
  width: 100%;
}
.vue-grid-item .no-drag {
  height: 100%;
  width: 100%;
}
.vue-grid-item .minMax {
  font-size: 12px;
}
.vue-grid-item .add {
  cursor: pointer;
}
.vue-draggable-handle {
  position: absolute;
  width: 20px;
  height: 20px;
  top: 0;
  left: 0;
  background: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='10' height='10'><circle cx='5' cy='5' r='5' fill='#999999'/></svg>")
    no-repeat;
  background-position: bottom right;
  padding: 0 8px 8px 0;
  background-repeat: no-repeat;
  background-origin: content-box;
  box-sizing: border-box;
  cursor: pointer;
}
.gridster-row {
  position: absolute;
}
.dropped {
  display: none;
}
</style>
