<template>
  <div class="widget">
    <template v-if="selectedLinkTo === null">
      <img
        :src="getDefaultImage(item)"
        :alt="item.properties.alt"
        :style="item.properties.style ? item.properties.style : style"
      />
    </template>
    <template v-if="selectedLinkTo === 0">
      <img
        @click="goTo(item.properties)"
        :src="getDefaultImage(item)"
        :alt="item.properties.alt"
        :style="[
          item.properties.style ? item.properties.style : style,
          { cursor: 'pointer' },
        ]"
      />
    </template>
    <template v-if="selectedLinkTo && selectedLinkTo === 1">
      <img
        @click="goToUrl(item.properties)"
        :src="getDefaultImage(item)"
        :alt="item.properties.alt"
        :style="[
          item.properties.style ? item.properties.style : style,
          { cursor: 'pointer' },
        ]"
      />
    </template>
    <template v-if="selectedLinkTo && selectedLinkTo === 2">
      <img
        @click="onCall(item.properties)"
        :src="getDefaultImage(item)"
        :alt="item.properties.alt"
        :style="[
          item.properties.style ? item.properties.style : style,
          { cursor: 'pointer' },
        ]"
      />
    </template>
    <template v-if="selectedLinkTo && selectedLinkTo === 3">
      <img
        @click="onEmail(item.properties)"
        :src="getDefaultImage(item)"
        :alt="item.properties.alt"
        :style="[
          item.properties.style ? item.properties.style : style,
          { cursor: 'pointer' },
        ]"
      />
    </template>
  </div>
</template>

<script>
export default {
  name: "ImagePreview",
  data() {
    return {
      selectedLinkTo: null,
      style: {
        objectFit: "cover",
      },
    };
  },
  props: {
    item: {},
    sectionId: Number,
  },
  methods: {
    getDefaultImage(item) {
      if (item.properties.image) return item.properties.image;
      return "https://zrassets.s3.eu-north-1.amazonaws.com/bed-and-breakfast/images/amenities.jpg";
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
    if (this.item.properties.selectedLinkTo !== null) {
      if (this.item.properties.selectedLinkTo !== undefined)
        this.selectedLinkTo = this.item.properties.selectedLinkTo;
    }
  },
};
</script>

<style scoped>
.label {
  border: none;
  outline: none;
}
.widget,
img {
  width: 100%;
  height: 100%;
  object-fit: inherit;
}
</style>
