<template>
  <div class="widget">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <!-- {{ item.properties.style }} -->
    <v-carousel
      v-model="model"
      :hide-delimiters="getDefalutAllowDots()"
      :show-arrows="getDefalutAllowArrows()"
      :cycle="getDefalutAllowLoop()"
    >
      <template v-if="item.properties.style">
        <video v-show="item.properties.style.carousel.background === ''">
          <source :src="item.properties.backgroundVideo" type="video/mp4" />
        </video>
      </template>
      {{ carouselStyle() }}
      <v-carousel-item
        :style="carouselStyle()"
        v-for="(element, index) in getDefalutSlides()"
        :key="index"
      >
        <v-sheet class="pa-4" color="transparent" height="100%" tile>
          <v-row class="fill-height" align="center" justify="center">
            <v-col cols="12">
              <div :style="titleTextStyle()">{{ element.title }}</div>
              <div :style="bodyTextStyle()">
                {{ element.body }}
              </div>
              <div class="mt-4" :style="{ textAlign: buttonStyle().textAlign }">
                <v-btn
                  :style="[buttonStyle(), hover ? onHover() : '']"
                  @mouseover="hover = true"
                  @mouseleave="hover = false"
                >
                  {{ element.textButton }}
                </v-btn>
              </div>
            </v-col>
          </v-row>
        </v-sheet>
      </v-carousel-item>
    </v-carousel>
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters } from "vuex";
export default {
  name: "CarouselWidget",
  components: {
    SettingsWidget,
  },
  data() {
    return {
      model: 0,
      colors: ["primary", "secondary", "yellow darken-2", "red", "orange"],
      hover: false,
      carousel: {
        background: "#009695FF",
      },
    };
  },
  props: {
    item: {},
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    carouselStyle: function() {
      if (this.item.properties.style) {
        return this.item.properties.style.carousel
          ? this.item.properties.style.carousel
          : this.carousel;
      } else {
        return this.carousel;
      }
    },
    titleTextStyle: function() {
      if (this.item.properties.style) {
        if (this.item.properties.style.elements) {
          return this.item.properties.style.elements.title
            ? this.item.properties.style.elements.title
            : "";
        } else {
          return "";
        }
      } else {
        return "";
      }
    },
    bodyTextStyle: function() {
      if (this.item.properties.style) {
        if (this.item.properties.style.elements) {
          return this.item.properties.style.elements.body
            ? this.item.properties.style.elements.body
            : "";
        } else {
          return "";
        }
      } else {
        return "";
      }
    },
    buttonStyle: function() {
      if (this.item.properties.style) {
        if (this.item.properties.style.elements) {
          return this.item.properties.style.elements.button
            ? this.item.properties.style.elements.button
            : "";
        } else {
          return "";
        }
      } else {
        return "";
      }
    },
    onHover: function() {
      if (this.item.properties.elementHover) {
        if (this.item.properties.elementHover !== undefined) {
          return this.item.properties.elementHover;
        }
      } else {
        return "";
      }
    },
    getDefalutSlides() {
      if (this.item.properties.fields.length)
        return this.item.properties.fields;
      return [
        {
          icon: "mdi-play-box-outline",
          title: "Slide",
          textButton: "Click Now",
          body: "Click now",
          type: "carousel",
        },
        {
          icon: "mdi-play-box-outline",
          title: "Slide",
          textButton: "Click Now",
          body: "Click now",
          type: "carousel",
        },
      ];
    },
    getDefalutAllowArrows() {
      if (!this.item.properties.allowArrow)
        return this.item.properties.allowArrow;
      return true;
    },
    getDefalutAllowDots() {
      if (this.item.properties.allowDots) return this.item.properties.allowDots;
      return false;
    },
    getDefalutAllowLoop() {
      if (this.item.properties.allowLoop) return this.item.properties.allowLoop;
      return false;
    },
  },
};
</script>

<style scoped>
video {
  width: 100%;
  height: 100%;
}
.v-carousel {
  position: absolute !important;
  display: block !important;
  z-index: -1 !important;
  width: 100% !important;
  height: 100% !important;
}
.widget {
  position: absolute;
  width: 100%;
  height: 100%;
}
::v-deep.v-btn {
  text-transform: inherit;
}
.v-btn ::v-deep.v-btn__content {
  align-items: inherit;
  height: 100%;
}
</style>
