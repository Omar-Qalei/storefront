<template>
  <!-- <div class="navbar"> -->
  <v-app-bar app color="white" dense clipped-right clipped-left dark>
    <a class="logo mr-6">
      Wimmly
    </a>
    <div class="separator"></div>
    <a class="pages ml-2" @click="onDrawerPages">
      Pages: <b class="ml-1">{{ title }}</b>
    </a>
    <div class="spacer"></div>
    <div class="settings d-flex">
      <a
        class="link-icon"
        @click="onResizeSectionScreen({ width: '320px', cols: 1 })"
      >
        <span class="mdi mdi-cellphone-cog"></span>
      </a>
      <a
        class="link-icon"
        @click="onResizeSectionScreen({ width: '100%', cols: 12 })"
      >
        <span class="mdi mdi-monitor"></span>
      </a>
      <v-btn icon small color="primary" @click.stop="onDrawer">
        <v-icon>mdi-menu</v-icon>
      </v-btn>
    </div>
  </v-app-bar>
  <!-- </div> -->
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "Navbar",
  data: function() {
    return {
      title: null,
    };
  },
  methods: {
    ...mapActions(["onDrawer", "onDrawerPages", "onResizeSectionScreen"]),
  },
  computed: {
    ...mapGetters(["getSelectedPage", "getPages"]),
  },
  watch: {
    getSelectedPage(value) {
      this.title = this.getPages.find((item) => item.id === value).title;
    },
    getPages(value) {
      console.log(value);
    },
  },
  mounted() {
    this.title = this.getPages.find((item) => item.id === 1).title;
  },
};
</script>

<style scoped>
nav {
  -webkit-box-shadow: 0 10px 20px 0 rgb(0 0 0 / 5%);
  box-shadow: 0 10px 20px 0 rgb(0 0 0 / 5%);
  align-items: center;
  height: 58px;
  padding-left: 25px;
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1;
  background: white;
}
.logo {
  font-weight: 700;
}
.link-icon {
  height: 36px;
  width: 36px;
  min-width: 28px;
  min-height: 28px;
  font-size: 15px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.settings {
  margin-right: 30px;
  align-items: center;
}
.separator {
  width: 1px;
  height: 16px;
  margin: 0 6px;
  background-color: rgba(0, 0, 0, 0.12);
}
.pages {
  font-size: 13px;
}
</style>
