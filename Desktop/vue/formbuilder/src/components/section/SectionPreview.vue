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
              <CarouselWidget v-if="item.type == 'carousel'" :item="item" />
              <TextWidget v-if="item.type == 'text'" :item="item" />
              <ImageWidget v-if="item.type == 'image'" :item="item" />
              <MenuWidget v-if="item.type == 'menu'" :item="item" />
              <VideoWidget v-if="item.type == 'video'" :item="item" />
              <MapWidget v-if="item.type == 'map'" :item="item" />
              <AudioWidget v-if="item.type == 'audio'" :item="item" />
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
              <FormWidget :item="item" />
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
import CarouselWidget from "../carousel/CarouselWidget";
import TextWidget from "../text/TextWidget";
import ImageWidget from "../image/ImageWidget";
import FormWidget from "../form/FormWidget";
import MenuWidget from "../menu/MenuWidget";
import VideoWidget from "../video/VideoWidget";
import MapWidget from "../map/MapWidget";
import AudioWidget from "../audio/AudioWidget";

export default {
  name: "SectionPreview",
  components: {
    GridLayout,
    GridItem,
    ButtonPreview,
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
