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
    :style="{
      width: getScreenSize.width,
      margin: '0 auto',
    }"
  >
    <template v-for="(item, index) in getSections">
      <GridItem
        :key="index"
        :autoSize="false"
        :x="item.x"
        :y="item.y"
        :w="getScreenSize.cols"
        :h="item.h"
        :i="item.i"
        :is-resizable="false"
        :minW="getScreenSize.cols"
        :id="item.i"
        :ref="'section'"
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
        <template v-if="item.resources.length === 0">
          <v-row class="h-100" align="center" justify="center">
            <v-col>
              <p class="ma-0 text-center">
                This is a blank section, start adding to it.
              </p>
            </v-col>
          </v-row>
        </template>
        <!-- <template v-else> -->
        <GridLayout
          :layout="item.resources"
          :col-num="getScreenSize.cols"
          :row-height="rowHeight"
          :is-draggable="false"
          :is-resizable="false"
          :is-mirrored="false"
          :vertical-compact="false"
          :responsive="getScreenSize.responsive"
          :allow-overlap="false"
          :margin="margin"
          :use-css-transforms="true"
          :autoSize="false"
          id="layout"
          :prevent-collision="false"
        >
          <template v-for="(item, index) in item.resources">
            <GridItem
              :key="index"
              v-if="item.type != 'form'"
              :class="{ editMode: !preview }"
              :x="item.x"
              :y="item.y"
              :w="item.w"
              :h="item.h"
              :i="item.i"
              :minH="2"
              :minW="1"
              :autoSize="true"
              :static="true"
            >
              <label
                v-show="hoverElement === item.i && selectedElement !== item.i"
                class="hint text-capitalize"
                >{{ item.type }}</label
              >
              <ButtonWidget v-if="item.type == 'button'" :item="item" />
              <CarouselWidget v-if="item.type == 'carousel'" :item="item" />
              <TextWidget v-if="item.type == 'text'" :item="item" />
              <ImageWidget v-if="item.type == 'image'" :item="item" />
              <MenuWidget v-if="item.type == 'menu'" :item="item" />
              <VideoWidget v-if="item.type == 'video'" :item="item" />
              <MapWidget v-if="item.type == 'map'" :item="item" />
              <AudioWidget v-if="item.type == 'audio'" :item="item" />
            </GridItem>
            <GridItem
              :key="index"
              v-if="item.type == 'form'"
              :class="{ editMode: !preview }"
              :x="item.x"
              :y="item.y"
              :w="item.w"
              :h="item.h"
              :i="item.i"
              :minW="1"
              :autoSize="true"
              :is-resizable-vertical="false"
              :static="true"
            >
              <label
                v-show="hoverElement === item.i"
                class="hint text-capitalize"
                >{{ item.type }}</label
              >
              <FormWidget :item="item" />
            </GridItem>
          </template>
        </GridLayout>
        <!-- </template> -->
      </GridItem>
    </template>
  </GridLayout>

  <!-- </div> -->
</template>

<script>
// @ is an alias to /src
import { GridLayout, GridItem } from "vue-grid-layout";
// mapActions,
import { mapGetters } from "vuex";
import ButtonWidget from "../components/button/ButtonWidget";
import CarouselWidget from "../components/carousel/CarouselWidget";
import TextWidget from "../components/text/TextWidget";
import ImageWidget from "../components/image/ImageWidget";
import FormWidget from "../components/form/FormWidget";
import MenuWidget from "../components/menu/MenuWidget";
import VideoWidget from "../components/video/VideoWidget";
import MapWidget from "../components/map/MapWidget";
import AudioWidget from "../components/audio/AudioWidget";

export default {
  name: "PreviewPages",
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
  data() {
    return {
      isDraggable: true,
      isResizable: true,
      preview: true,
      contenteditable: true,
      selectedSection: 0,
      statusSection: false,
      margin: [0, 0],
      rowHeight: 30,
    };
  },
  methods: {
    // ...mapActions(["fetchResources"]),
  },
  computed: {
    ...mapGetters(["getSections", "getScreenSize"]),
  },
  created() {},
};
</script>
<style scoped>
#myVideo {
  position: fixed;
  width: 100%;
  height: 100%;
}
</style>
