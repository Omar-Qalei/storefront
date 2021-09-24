<template>
  <div class="widget">
    <template v-if="selectedLinkTo === 0">
      <v-btn
        @mouseover="hover = true"
        @mouseleave="hover = false"
        @click="goTo(item.properties)"
        text
        :style="[
          item.properties.style ? item.properties.style : style,
          onHover(item.properties.elementHover),
        ]"
        :id="item.i + 'button'"
      >
        {{ item.properties.name }}
      </v-btn>
    </template>

    <template v-if="selectedLinkTo && selectedLinkTo === 1">
      <v-btn
        :style="[
          item.properties.style ? item.properties.style : style,
          onHover(item.properties.elementHover),
        ]"
        :id="item.i + 'button'"
        @click="goToUrl(item.properties)"
      >
        {{ item.properties.name }}
      </v-btn>
    </template>

    <template v-if="selectedLinkTo && selectedLinkTo === 2">
      <v-btn
        :style="[
          item.properties.style ? item.properties.style : style,
          onHover(item.properties.elementHover),
        ]"
        :id="item.i + 'button'"
        @click="onCall(item.properties)"
      >
        {{ item.properties.name }}
      </v-btn>
    </template>

    <template v-if="selectedLinkTo && selectedLinkTo === 3">
      <v-btn
        :style="[
          item.properties.style ? item.properties.style : style,
          onHover(item.properties.elementHover),
        ]"
        :id="item.i + 'button'"
        @click="onEmail(item.properties)"
      >
        {{ item.properties.name }}
      </v-btn>
    </template>
  </div>
</template>

<script>
export default {
  name: "ButtonWidget",
  data() {
    return {
      hover: false,
      selectedLinkTo: 0,
      style: {},
    };
  },
  props: {
    item: {},
  },
  methods: {
    onHover: function(elementHover) {
      if (this.hover) {
        if (elementHover !== undefined) {
          return elementHover;
        }
      } else {
        return "";
      }
    },
    goTo: function(properties) {
      if (properties.page) {
        const siteId = properties.page.site_id;
        const pageId = properties.page.id;
        if (+this.$route.query.pageId !== pageId)
          this.$router.replace({
            path: "preview",
            query: { siteId: siteId, pageId: pageId },
          });
      }
    },
    goToUrl: function(properties) {
      if (properties.url) {
        let url = properties.url;
        let newTab = properties.newTab;
        if (newTab) {
          window.open(url, "_blank");
        } else {
          window.open(url, "_self");
        }
      }
    },
    onCall: function(properties) {
      let phone = properties.phone;
      if (phone) {
        window.open("tel:" + phone);
      }
    },
    onEmail: function(properties) {
      let email = properties.email;
      if (email) {
        window.location.href = "mailto:" + email;
      }
    },
  },
  created() {
    if (this.item.properties.style === null) {
      this.style = {
        justifyContent: "center",
        alignItems: "center",
        borderRadius: "30px",
        color: "#FFFFFFFF",
        backgroundColor: "#4E00BBFF",
      };
    }
    if (this.item.properties.selectedLinkTo !== null) {
      if (this.item.properties.selectedLinkTo !== undefined)
        this.selectedLinkTo = this.item.properties.selectedLinkTo;
    }
  },
};
</script>

<style scoped>
.v-btn {
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
.widget ::v-deep.v-btn {
  text-transform: inherit;
}
.widget .v-btn ::v-deep.v-btn__content {
  align-items: inherit;
  height: 100%;
}
</style>
