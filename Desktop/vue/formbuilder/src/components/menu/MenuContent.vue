<template>
  <v-container class="menu-content" fluid>
    <v-expansion-panels>
      <v-expansion-panel>
        <v-expansion-panel-header>Logo</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row class="pt-4">
            <v-col cols="12">
              <v-col
                cols="12"
                class="backgroundSection"
                @click="
                  onShowChooseFilesDialog(true);
                  onTypeChooseFileDialog('image');
                "
              >
                <img v-if="image" :src="image" />
                <label class="labelFile" v-else>
                  <h2 class="body-1 font-weight-medium">
                    Add Image
                  </h2>
                </label>
              </v-col>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
    <v-row class="my-2">
      <v-col cols="12">
        <v-card>
          <draggable v-model="list" class="w-100">
            <v-card-actions
              class="py-2"
              v-for="(item, index) in getList"
              :key="index"
            >
              <h2 class="body-2 font-weight-medium">
                <v-btn x-small icon color="primary">
                  <v-icon color="primary">mdi mdi-drag</v-icon>
                </v-btn>
                {{ item.name }}
              </h2>
              <v-spacer></v-spacer>
              <!-- {{ item.id }} {{ item.status }} -->
              <v-btn
                v-if="item.status"
                x-small
                icon
                color="primary"
                @click="onDisplayPage(item)"
              >
                <v-icon color="primary">mdi mdi-eye-outline</v-icon>
              </v-btn>
              <v-btn
                v-if="!item.status"
                x-small
                icon
                color="primary"
                @click="onDisplayPage(item)"
              >
                <v-icon color="primary">mdi mdi-eye-off-outline</v-icon>
              </v-btn>
            </v-card-actions>
          </draggable>
        </v-card>
      </v-col>
    </v-row>
    <!-- Choose Files -->
    <ChooseFilesWidget
      @onSelectedImage="onSelectedImage($event)"
      :type="'image'"
    />
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import draggable from "vuedraggable";
import ChooseFilesWidget from "../options/ChooseFilesWidget";

export default {
  name: "MenuContent",
  components: {
    draggable,
    ChooseFilesWidget,
  },
  data() {
    return {
      list: [
        { id: "lol", status: true },
        { id: "lol2", status: true },
        { id: "lol3", status: true },
        { id: "lol4", status: true },
      ],
      image: null,
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getPages"]),
    getList: function() {
      return this.list;
    },
  },
  methods: {
    ...mapActions(["onShowChooseFilesDialog", "onTypeChooseFileDialog"]),
    onSelectedImage: function(event) {
      this.image = event;
    },
    onDisplayPage: function(event) {
      this.list.forEach((element) => {
        if (element.id === event.id) element.status = !element.status;
      });
      this.getSelectedWidgetById.properties.fields = this.list;
    },
  },
  created() {
    this.onTypeChooseFileDialog("image");
    if (this.getSelectedWidgetById.properties.image)
      this.image = this.getSelectedWidgetById.properties.image;

    if (this.getSelectedWidgetById.properties.fields.length === 0)
      this.getSelectedWidgetById.properties.fields = this.getPages;

    if (this.getSelectedWidgetById.properties.fields.length > 0) {
      const pages = this.getPages.map((element) => element.id).sort();
      this.getPages.forEach((element) => (element.status = true));
      this.list = this.getPages;
      const fields = this.getSelectedWidgetById.properties.fields
        .map((element) => element.id)
        .sort();
      const thiz = this;
      pages.forEach(function(element) {
        if (fields.indexOf(element) === -1) {
          const object = thiz.getPages.find((obj) => obj.id === element);
          thiz.getSelectedWidgetById.properties.fields.push(object);
        }
      });
      this.list = this.getSelectedWidgetById.properties.fields;
    }
  },
  updated() {
    this.getSelectedWidgetById.properties.image = this.image;
    this.getSelectedWidgetById.properties.fields = this.list;
  },
};
</script>

<style scoped>
img {
  width: 100px;
  height: 100px;
  object-fit: cover;
}
.backgroundSection {
  height: 150px;
  border-radius: 4px;
  border: 1px solid black;
  display: flex;
  justify-content: center;
  align-items: center;
}
.labelFile {
  display: flex;
  height: 100%;
  width: 100%;
  align-items: center;
  justify-content: center;
}
</style>
