<template>
  <v-container class="button-content" fluid>
    <v-row class="pt-4">
      <v-col cols="8">
        <h2 class="body-1 font-weight-medium mb-2">
          Form Name
        </h2>
        <v-text-field
          outlined
          v-model="getSelectedWidgetById.properties.name"
          hide-details
        ></v-text-field>
        <v-checkbox
          hide-details
          v-model="hideFormName"
          label="Hide Form Name"
        ></v-checkbox>
      </v-col>
      <v-col cols="8">
        <h2 class="body-1 font-weight-medium mb-2">
          Submit Button Name
        </h2>
        <v-text-field
          outlined
          placeholder="Ex. Submit"
          v-model="getSelectedWidgetById.properties.submitBtnName"
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
        <v-textarea
          v-if="selectedLinkTo === 2"
          outlined
          name="input-7-4"
          v-model="getSelectedWidgetById.properties.showMessage"
          placeholder="Thank you!"
        ></v-textarea>
      </v-col>
      <v-col cols="8">
        <h2 class="body-1 font-weight-medium mb-2">
          <v-icon color="primary">mdi-plus-circle-outline</v-icon>
          Add new form field
        </h2>
        <v-select
          v-model="selectedField"
          :items="fields"
          label="Select Field"
          outlined
          hide-details
          return-object
          @input="onAddField"
        >
          <template v-slot:item="{ item }">
            <v-list dense>
              <v-list-item>
                <v-list-item-icon>
                  <v-icon v-text="item.icon"></v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title v-text="item.text"></v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list>
          </template>
        </v-select>
      </v-col>
      <v-col cols="12">
        <v-expansion-panels>
          <draggable v-model="fieldsList" class="w-100">
            <v-expansion-panel
              v-for="(item, index) in fieldsList"
              :key="index"
              dense
            >
              <v-expansion-panel-header>
                <h2 class="body-2 font-weight-medium">
                  <v-btn x-small color="transparent" dark fab text>
                    <v-icon color="primary">mdi mdi-drag</v-icon>
                  </v-btn>
                  {{ item.text }}
                </h2>
              </v-expansion-panel-header>
              <v-expansion-panel-content>
                <v-row>
                  <v-col cols="12">
                    <h2 class="body-2 font-weight-medium">
                      Field Label
                    </h2>
                    <v-text-field
                      outlined
                      :placeholder="item.text"
                      hide-details
                      @input="handleInputLabel($event, index)"
                      @mousedown="inputIndex = index"
                      :key="index"
                      :value="item.label"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <h2 class="body-2 font-weight-medium">
                      Placeholder Text
                    </h2>
                    <v-text-field
                      outlined
                      @input="handleInputPlaceholder($event, index)"
                      @mousedown="inputIndex = index"
                      :placeholder="'Enter your ' + item.type"
                      hide-details
                      :key="index"
                      :value="item.placerholder"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-switch
                      @change="handleInputIsRequired($event, index)"
                      @mousedown="inputIndex = index"
                      label="Field is required"
                      hide-details
                      v-model="item.isRequired"
                    ></v-switch>
                  </v-col>
                  <v-col cols="12">
                    <v-btn text color="error" @click="onRemoveField(index)">
                      Remove
                    </v-btn>
                  </v-col>
                </v-row>
              </v-expansion-panel-content>
            </v-expansion-panel>
          </draggable>
        </v-expansion-panels>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import draggable from "vuedraggable";
export default {
  name: "FormContent",
  components: {
    draggable,
  },
  data() {
    return {
      text: null,
      selectedLinkTo: 0,
      selectedPage: null,
      selectedUrl: null,
      hideFormName: true,
      statusNewTab: false,
      inputIndex: null,
      height: 0,
      tags: [
        { id: 0, title: "Page" },
        { id: 1, title: "URL" },
        { id: 2, title: "Show Message" },
      ],
      selectedField: {},
      fields: [
        {
          icon: "mdi-account",
          text: "Name",
          label: "",
          placerholder: "",
          isRequired: false,
          type: "name",
        },
        {
          icon: "mdi-email",
          text: "Email",
          label: "",
          placerholder: "",
          isRequired: false,
          type: "email",
        },
        {
          icon: "mdi-phone",
          text: "Phone",
          label: "",
          placerholder: "",
          isRequired: false,
          type: "phone",
        },
        {
          icon: "mdi-format-text",
          text: "Text Field",
          label: "",
          placerholder: "",
          isRequired: false,
          type: "textField",
        },
        {
          icon: "mdi-text-box",
          text: "Text Box",
          label: "",
          placerholder: "",
          isRequired: false,
          type: "textBox",
        },
      ],
      fieldsList: [],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getPages"]),
  },
  methods: {
    ...mapActions([
      "onSortSectionsLayout",
      "onAddFormField",
      "onRemoveFormField",
    ]),
    handleInputLabel: function(result, index) {
      if (this.fieldsList[index].id === this.inputIndex) {
        this.fieldsList[this.inputIndex].label = result;
      }
    },
    handleInputPlaceholder: function(result, index) {
      if (this.fieldsList[index].id === this.inputIndex) {
        this.fieldsList[this.inputIndex].placerholder = result;
      }
    },
    handleInputIsRequired: function(result, index) {
      if (this.fieldsList[index].id === this.inputIndex) {
        this.fieldsList[this.inputIndex].isRequired = result;
      }
    },
    onAddField: function() {
      const data = {
        id: this.fieldsList.length,
        ...this.selectedField,
      };
      this.fieldsList.push(data);
      this.selectedField = {};
      this.getSelectedWidgetById.properties.fields = this.fieldsList;
      this.height += 2;
      if (this.fieldsList.length === 1) {
        this.getSelectedWidgetById.h = 4;
      }
      if (this.height + 4 >= this.getSelectedWidgetById.h) {
        this.getSelectedWidgetById.h += 2;
      }
      this.onSortSectionsLayout();
    },
    onRemoveField: function(index) {
      this.fieldsList.splice(index, 1);
      this.height -= 2;
      if (this.fieldsList.length === 0) {
        this.getSelectedWidgetById.h = 12;
      }
      if (this.fieldsList.length === 1) {
        this.getSelectedWidgetById.h = 4;
      }
      if (
        this.height - 4 <= this.getSelectedWidgetById.h &&
        this.fieldsList.length > 1
      ) {
        this.getSelectedWidgetById.h -= 2;
      }
    },
  },
  created() {
    this.getSelectedWidgetById.properties.hideFormName = this.hideFormName;
    if (this.getSelectedWidgetById.properties.selectedLinkTo)
      this.selectedLinkTo = this.getSelectedWidgetById.properties.selectedLinkTo;
    if (this.getSelectedWidgetById.properties.hideFormName)
      this.hideFormName = this.getSelectedWidgetById.properties.hideFormName;
    if (this.getSelectedWidgetById.properties.fields)
      this.fieldsList = this.getSelectedWidgetById.properties.fields;
  },
  updated() {
    this.getSelectedWidgetById.properties.selectedLinkTo = this.selectedLinkTo;
    this.getSelectedWidgetById.properties.hideFormName = this.hideFormName;
    this.getSelectedWidgetById.properties.fields = this.fieldsList;
  },
};
</script>

<style scoped></style>
