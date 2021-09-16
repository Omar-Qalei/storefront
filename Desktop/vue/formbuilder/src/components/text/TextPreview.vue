<template>
  <!-- @mouseover="hover = true" @mouseleave="hover = false" -->
  <div class="widget">
    <div v-html="item.properties.text"></div>
    <!-- <template v-if="selectedLinkTo === null">
      <label
        :id="item.i"
        :style="[item.properties.style ? item.properties.style : style]"
        >{{ item.properties.text }}</label
      >
    </template>
    <template v-if="selectedLinkTo === 0">
      <label
        @click="goTo(item.properties)"
        :id="item.i"
        :style="[
          item.properties.style ? item.properties.style : style,

          { cursor: 'pointer' },
        ]"
        >{{ item.properties.text }}</label
      >
    </template>
    <template v-if="selectedLinkTo && selectedLinkTo === 1">
      <label
        @click="goToUrl(item.properties)"
        :id="item.i"
        :style="[
          item.properties.style ? item.properties.style : style,

          { cursor: 'pointer' },
        ]"
        >{{ item.properties.text }}</label
      >
    </template>
    <template v-if="selectedLinkTo && selectedLinkTo === 2">
      <label
        @click="onCall(item.properties)"
        :id="item.i"
        :style="[
          item.properties.style ? item.properties.style : style,

          { cursor: 'pointer' },
        ]"
        >{{ item.properties.text }}</label
      >
    </template>
    <template v-if="selectedLinkTo && selectedLinkTo === 3">
      <label
        @click="onEmail(item.properties)"
        :id="item.i"
        :style="[
          item.properties.style ? item.properties.style : style,

          { cursor: 'pointer' },
        ]"
        >{{ item.properties.text }}</label
      >
    </template> -->
  </div>
</template>

<script>
export default {
  name: "TextPreview",
  data() {
    return {
      hover: false,
      selectedLinkTo: null,
      style: {},
    };
  },
  props: {
    item: {},
    sectionId: Number,
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
        fontSize: "56px",
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
.widget,
.d-flex {
  width: 100%;
  height: 100%;
}
.d-flex {
  display: flex;
}
label {
  display: block;
  width: 100%;
  height: 100%;
  white-space: pre-wrap;
}
</style>
