<template>
  <div class="widget">
    <v-carousel
      v-model="model"
      :hide-delimiters="getDefalutAllowDots()"
      :show-arrows="getDefalutAllowArrows()"
      :cycle="getDefalutAllowLoop()"
    >
      <template v-if="item.properties.style">
        <video v-show="item.properties.backgroundVideo">
          <source :src="item.properties.backgroundVideo" type="video/mp4" />
        </video>
      </template>
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
                  @click="goTo(item.properties)"
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
export default {
  name: "CarouselWidget",
  data() {
    return {
      model: 0,
      selectedButtonLinkTo: null,
      fields: [
        {
          icon: "mdi-play-box-outline",
          title: "Slide one Title",
          textButton: "Learn more",
          body: "Write your text here and add as many slides as you want...",
          type: "carousel",
        },
        {
          icon: "mdi-play-box-outline",
          title: "Slide Two Title",
          textButton: "Learn more",
          body: "Write your text here and add as many slides as you want...",
          type: "carousel",
        },
      ],
      colors: ["primary", "secondary", "yellow darken-2", "red", "orange"],
      hover: false,
      carousel: {
        background: "#009695FF",
      },
      title: {
        textAlign: "center",
        alignSelf: "center",
        fontWeight: "",
        fontStyle: "",
        textDecoration: "",
        color: "#FFFFFFFF",
        textTransform: "none",
        fontSize: "56px",
      },
      body: {
        textAlign: "center",
        alignSelf: "center",
        fontWeight: "",
        fontStyle: "",
        textDecoration: "",
        color: "#FFFFFFFF",
        textTransform: "none",
        fontSize: "18px",
      },
      button: {
        textAlign: "center",
        alignItems: "center",
        borderRadius: "20px",
        color: "#000000de",
        backgroundColor: "#f5f5f5",
      },
    };
  },
  props: {
    item: {},
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
            : this.title;
        } else {
          return this.title;
        }
      } else {
        return this.title;
      }
    },
    bodyTextStyle: function() {
      if (this.item.properties.style) {
        if (this.item.properties.style.elements) {
          return this.item.properties.style.elements.body
            ? this.item.properties.style.elements.body
            : this.body;
        } else {
          return this.body;
        }
      } else {
        return this.body;
      }
    },
    buttonStyle: function() {
      if (this.item.properties.style) {
        if (this.item.properties.style.elements) {
          return this.item.properties.style.elements.button
            ? this.item.properties.style.elements.button
            : this.button;
        } else {
          return this.button;
        }
      } else {
        return this.button;
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
    getDefalutSlides: function() {
      if (this.item.properties.fields.length)
        return this.item.properties.fields;
      return this.fields;
    },
    getDefalutAllowArrows: function() {
      if (!this.item.properties.allowArrow)
        return this.item.properties.allowArrow;
      return true;
    },
    getDefalutAllowDots: function() {
      if (this.item.properties.allowDots) return this.item.properties.allowDots;
      return false;
    },
    getDefalutAllowLoop: function() {
      if (!this.item.properties.allowLoop)
        return this.item.properties.allowLoop;
      return true;
    },
    goTo: function(properties) {
      let siteId, pageId, url, newTab, phone, email;
      switch (this.selectedButtonLinkTo) {
        case 0:
          siteId = properties.page.site_id;
          pageId = properties.page.id;
          if (+this.$route.query.pageId !== pageId)
            this.$router.replace({
              path: "preview",
              query: { siteId: siteId, pageId: pageId },
            });
          break;
        case 1:
          url = properties.url;
          newTab = properties.newTab;
          if (newTab) {
            window.open(url, "_blank");
          } else {
            window.open(url, "_self");
          }
          break;
        case 2:
          phone = properties.phone;
          if (phone) {
            window.open("tel:" + phone);
          }
          break;
        case 3:
          email = properties.email;
          if (email) {
            window.location.href = "mailto:" + email;
          }
          break;
      }
    },
  },
  created() {
    if (this.item.properties.selectedButtonLinkTo !== null) {
      if (this.item.properties.selectedButtonLinkTo !== undefined)
        this.selectedButtonLinkTo = this.item.properties.selectedButtonLinkTo;
    }
  },
};
</script>

<style scoped>
video {
  width: 100%;
  height: 100%;
  object-fit: fill;
}
.v-carousel {
  position: absolute !important;
  display: block !important;
  z-index: 1 !important;
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
