<template>
  <v-slide-y-reverse-transition hide-on-leave>
    <div class="widget-settings" v-show="show">
      <!-- Setting Button + Dialog -->
      <v-btn
        class="mr-2"
        color="white"
        fab
        x-small
        light
        @click="$modal.show('settings')"
      >
        <v-icon>mdi-cog-outline</v-icon>
      </v-btn>
      <!-- Setting Button + Dialog -->
      <v-btn
        class="mr-2"
        color="white"
        fab
        x-small
        light
        @click="
          onDuplicateResource({ item: item, id: sectionId });
          onFetchData();
        "
      >
        <v-icon>mdi-content-duplicate</v-icon>
      </v-btn>
      <v-btn
        color="white"
        fab
        x-small
        @click="
          onRemoveResource({
            i: item.i,
            type: item.type,
            id: sectionId,
            gridKey: item.gridKey,
            selectedIndex: item.selectedIndex,
          });
          onFetchData();
          onSelectedWidgetById({});
        "
      >
        <v-icon>mdi-delete-outline</v-icon>
      </v-btn>
    </div>
  </v-slide-y-reverse-transition>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "SettingsWidget",
  props: {
    show: Boolean,
    sectionId: Number,
    item: {},
  },
  data() {
    return {
      dialog: false,
      // height: Number,
      // width: Number,
    };
  },
  methods: {
    ...mapActions([
      "onRemoveResource",
      "onDuplicateResource",
      "fetchSections",
      "onSelectedWidgetById",
    ]),
    onFetchData: function() {
      let resource;
      if (this.getScreenSize.screen === "web") {
        resource = this.getWebResources;
        this.fetchSections(resource);
      }
      if (this.getScreenSize.screen === "mobile") {
        resource = this.getMobileResources;
        this.fetchSections(resource);
      }
    },
  },
  computed: {
    ...mapGetters(["getScreenSize", "getWebResources", "getMobileResources"]),
  },
};
</script>

<style scoped>
.widget-settings {
  position: absolute;
  top: -40px;
  min-width: 112px;
}
</style>
