<template>
  <v-container class="menu-content" fluid>
    <!-- <v-row class="pt-4">
      <v-col cols="8">
        <h2 class="body-1 font-weight-medium mb-2">
          Menu Text
        </h2>
        <v-text-field
          outlined
          v-model="getSelectedWidgetById.properties.name"
          hide-details
        ></v-text-field>
      </v-col>
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          Link to
        </h2>
        <v-chip-group
          active-class="primary--text"
          mandatory
          v-model="selectedLinkTo"
        >
          <v-chip v-for="tag in tags" :key="tag.id">
            {{ tag.title }}
          </v-chip>
        </v-chip-group>
      </v-col>
      <v-col cols="12">
        <h2 class="body-1 font-weight-medium mb-2">
          {{ tags[selectedLinkTo].title }}
        </h2>
        <v-select
          v-if="selectedLinkTo === 0"
          :items="getPages"
          item-text="name"
          return-object
          v-model="getSelectedWidgetById.properties.page"
          outlined
        ></v-select>
        <template v-if="selectedLinkTo === 1">
          <v-text-field
            placeholder="https://www.example.com"
            v-model="getSelectedWidgetById.properties.url"
            outlined
            hide-details
          ></v-text-field>
          <v-switch
            label="Open a new tab"
            v-model="getSelectedWidgetById.properties.newTab"
          ></v-switch>
        </template>
        <v-text-field
          v-if="selectedLinkTo === 2"
          placeholder="Ex. 079-501-218"
          v-model="getSelectedWidgetById.properties.phone"
          outlined
          hide-details
        ></v-text-field>
        <v-text-field
          v-if="selectedLinkTo === 3"
          placeholder="example@example.com"
          v-model="getSelectedWidgetById.properties.email"
          outlined
          hide-details
        ></v-text-field>
      </v-col>
    </v-row> -->
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
              v-for="(item, index) in list"
              :key="index"
            >
              <h2 class="body-2 font-weight-medium">
                <v-btn x-small icon color="primary">
                  <v-icon color="primary">mdi mdi-drag</v-icon>
                </v-btn>
                {{ item.name }}
              </h2>
              <v-spacer></v-spacer>
              <v-btn x-small icon color="primary" @click="onDisplayPage(index)">
                <v-icon color="primary">mdi mdi-eye-outline</v-icon>
              </v-btn>
            </v-card-actions>
          </draggable>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import draggable from "vuedraggable";
export default {
  name: "MenuContent",
  components: {
    draggable,
  },
  data() {
    return {
      list: [],
      image: null,
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getPages"]),
  },
  methods: {
    ...mapActions(["onShowChooseFilesDialog", "onTypeChooseFileDialog"]),
    onDisplayPage: function() {},
  },
  created() {
    this.onTypeChooseFileDialog("image");
  },
  mounted() {
    this.list = this.getPages;
    console.log(this.list);
  },
  updated() {
    this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
  },
};
</script>

<style scoped>
img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.backgroundSection {
  height: 150px;
  border-radius: 4px;
  border: 1px solid black;
}
.labelFile {
  display: flex;
  height: 100%;
  width: 100%;
  align-items: center;
  justify-content: center;
}
</style>
