<template>
  <div class="widget">
    <SettingsWidget
      :show="item.i === getSelectedWidgetById.i"
      :item="item"
      :sectionId="sectionId"
    ></SettingsWidget>
    <nav>
      <a class="logo mr-6">
        Wimmly
      </a>
      <div class="spacer"></div>
      <template v-if="getScreenSize.screen === 'web'">
        <v-btn v-for="(item, index) in list" :key="index" text>
          {{ item.name }}
        </v-btn>
      </template>
      <template v-else>
        <v-btn icon small>
          <v-icon>mdi-menu</v-icon>
        </v-btn>
      </template>
    </nav>
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters } from "vuex";
export default {
  name: "MenuWidget",
  components: {
    SettingsWidget,
  },
  data() {
    return {
      list: [],
    };
  },
  props: {
    item: {},
    sectionId: Number,
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getPages", "getScreenSize"]),
  },
  mounted() {
    this.list = this.getPages;
  },
};
</script>

<style scoped>
.widget {
  width: 100%;
  height: 100%;
}
nav {
  position: absolute;
  display: flex;
  align-items: center;
  z-index: -1;
  width: 100%;
  height: 100%;
}
</style>
