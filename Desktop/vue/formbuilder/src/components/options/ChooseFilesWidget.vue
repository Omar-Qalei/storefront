<template>
  <v-dialog
    v-model="dialog"
    fullscreen
    hide-overlay
    transition="dialog-bottom-transition"
    scrollable
  >
    <v-card tile>
      <v-toolbar flat dark color="primary">
        <v-btn icon dark @click="dialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
        <v-toolbar-title>Choose Files</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-toolbar-items>
          <v-btn dark text @click="onSave">
            Save
          </v-btn>
        </v-toolbar-items>
        <!-- <v-menu bottom right offset-y>
          <template v-slot:activator="{ on, attrs }">
            <v-btn dark icon v-bind="attrs" v-on="on">
              <v-icon>mdi-dots-vertical</v-icon>
            </v-btn>
          </template>
          <v-list>
            <v-list-item v-for="(item, i) in items" :key="i" @click="() => {}">
              <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu> -->
      </v-toolbar>
      <v-tabs>
        <v-tab>Website Files</v-tab>
        <v-tab-item>
          <v-card-text>
            <v-row>
              <v-file-input
                counter
                multiple
                show-size
                truncate-length="15"
                label="Upload File"
              ></v-file-input>
            </v-row>
            <v-row>
              <v-col v-for="n in 9" :key="n" class="d-flex child-flex" cols="2">
                <v-img
                  @click="
                    selectedFile = {
                      id: n,
                      file: `https://picsum.photos/500/300?image=${n * 5 + 10}`,
                    }
                  "
                  :src="`https://picsum.photos/500/300?image=${n * 5 + 10}`"
                  :lazy-src="`https://picsum.photos/10/6?image=${n * 5 + 10}`"
                  aspect-ratio="1"
                  class="grey lighten-2"
                  :class="{ selectedBox: selectedFile.id === n }"
                >
                  <template v-slot:placeholder>
                    <v-row
                      class="fill-height ma-0"
                      align="center"
                      justify="center"
                    >
                      <v-progress-circular
                        indeterminate
                        color="grey lighten-5"
                      ></v-progress-circular>
                    </v-row>
                  </template>
                </v-img>
              </v-col>
            </v-row>
          </v-card-text>
        </v-tab-item>
        <v-tab>Free Files</v-tab>
        <v-tab-item>
          <v-card-text>
            <v-row>
              <v-col v-for="n in 9" :key="n" class="d-flex child-flex" cols="2">
                <v-img
                  @click="
                    selectedFile = `https://picsum.photos/500/300?image=${n *
                      5 +
                      10}`
                  "
                  :src="`https://picsum.photos/500/300?image=${n * 5 + 10}`"
                  :lazy-src="`https://picsum.photos/10/6?image=${n * 5 + 10}`"
                  aspect-ratio="1"
                  class="grey lighten-2"
                >
                  <template v-slot:placeholder>
                    <v-row
                      class="fill-height ma-0"
                      align="center"
                      justify="center"
                    >
                      <v-progress-circular
                        indeterminate
                        color="grey lighten-5"
                      ></v-progress-circular>
                    </v-row>
                  </template>
                </v-img>
              </v-col>
            </v-row>
          </v-card-text>
        </v-tab-item>
      </v-tabs>

      <div style="flex: 1 1 auto;"></div>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
export default {
  name: "ChooseFilesWidget",
  data() {
    return {
      notifications: false,
      sound: true,
      widgets: false,
      dialog: false,
      selectedType: null,
      selectedFile: {
        id: null,
        file: null,
      },
      items: [
        {
          title: "Click Me",
        },
        {
          title: "Click Me",
        },
        {
          title: "Click Me",
        },
        {
          title: "Click Me 2",
        },
      ],
      select: [
        { text: "State 1" },
        { text: "State 2" },
        { text: "State 3" },
        { text: "State 4" },
        { text: "State 5" },
        { text: "State 6" },
        { text: "State 7" },
      ],
    };
  },
  computed: {
    ...mapGetters(["getShowChooseFilesDialog", "getTypeChooseFileDialog"]),
  },
  watch: {
    getShowChooseFilesDialog: function(value) {
      this.dialog = value;
    },
    dialog: function(value) {
      this.onShowChooseFilesDialog(value);
    },
    getTypeChooseFileDialog: function(value) {
      this.selectedType = value;
    },
  },
  methods: {
    ...mapActions(["onShowChooseFilesDialog"]),
    onSave: function() {
      var element;
      switch (this.selectedType) {
        case "backgroundImage":
          element = `url('${this.selectedFile.file}')`;
          this.$emit("onSelectedImage", element);
          break;

        case "backgroundVideo":
          element = "https://www.w3schools.com/howto/rain.mp4";
          this.$emit("onSelectedVideo", element);
          break;
      }
      this.dialog = false;
    },
  },
};
</script>

<style scoped>
::v-deep.v-dialog__content {
  z-index: 999 !important;
}
.selectedBox {
  border: 4px solid #357df9;
}
</style>
