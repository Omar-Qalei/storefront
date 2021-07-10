<template>
  <div class="grid-vue">
    <GridLayout
      :layout="resources"
      :col-num="cols"
      :row-height="rowHeight"
      :is-draggable="false"
      :is-resizable="false"
      :is-mirrored="false"
      :vertical-compact="false"
      :responsive="responsive"
      :allow-overlap="false"
      :margin="margin"
      :use-css-transforms="true"
      :autoSize="false"
      :ref="'gridLayout'"
      id="layout"
      :prevent-collision="false"
    >
      <template v-if="resources.length > 0">
        <template v-for="(item, index) in resources">
          <div :key="index">
            <GridItem
              v-if="item.type != 'form'"
              :class="{ dropped: item.i === 'drop' }"
              :x="item.x"
              :y="item.y"
              :w="item.w"
              :h="item.h"
              :i="item.i"
              :minH="2"
              :minW="1"
              :autoSize="false"
              :static="true"
              ref="gridItem"
            >
              <ButtonPreview v-if="item.type == 'button'" :item="item" />
              <CarouselPreview v-if="item.type == 'carousel'" :item="item" />
              <TextPreview v-if="item.type == 'text'" :item="item" />
              <ImagePreview v-if="item.type == 'image'" :item="item" />
              <MenuPreview v-if="item.type == 'menu'" :item="item" />
              <VideoPreview v-if="item.type == 'video'" :item="item" />
              <MapPreview v-if="item.type == 'map'" :item="item" />
              <AudioPreview v-if="item.type == 'audio'" :item="item" />
            </GridItem>

            <GridItem
              v-if="item.type == 'form'"
              :class="{ dropped: item.i === 'drop' }"
              :x="item.x"
              :y="item.y"
              :w="item.w"
              :h="item.h"
              :i="item.i"
              :minW="1"
              :autoSize="false"
              :static="true"
              ref="gridItem"
            >
              <FormPreview :item="item" />
            </GridItem>
          </div>
        </template>
      </template>
    </GridLayout>
  </div>
</template>

<script>
// @ is an alias to /src
import { GridLayout, GridItem } from "vue-grid-layout";
import { mapGetters } from "vuex";
import ButtonPreview from "../button/ButtonPreview";
import CarouselPreview from "../carousel/CarouselPreview";
import TextPreview from "../text/TextPreview";
import ImagePreview from "../image/ImagePreview";
import FormPreview from "../form/FormPreview";
import MenuPreview from "../menu/MenuPreview";
import VideoPreview from "../video/VideoPreview";
import MapPreview from "../map/MapPreview";
import AudioPreview from "../audio/AudioPreview";

export default {
  name: "SectionPreview",
  components: {
    GridLayout,
    GridItem,
    ButtonPreview,
    CarouselPreview,
    TextPreview,
    ImagePreview,
    FormPreview,
    MenuPreview,
    VideoPreview,
    MapPreview,
    AudioPreview,
  },
  props: {
    resources: Array,
    cols: Number,
    margin: Array,
    responsive: Boolean,
    rowHeight: Number,
  },
  data() {
    return {};
  },
  computed: {
    ...mapGetters([
      "getSections",
      "getResizeSectionStatus",
      "getScreenSize",
      "getWebResources",
      "getMobileResources",
    ]),
  },
};
</script>
<style scoped>
.dropped {
  display: none;
}
</style>
