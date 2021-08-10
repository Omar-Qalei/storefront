<template>
  <v-sheet class="settings rounded-pill" elevation="1">
    <!-- Font Size -->
    <v-menu
      bottom
      origin="center center"
      transition="scale-transition"
      :nudge-width="75"
      rounded="lg"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn class="text-capitalize mr-4" text v-bind="attrs" v-on="on">
          {{ fontSizes[selectedFontSize].title }}
          <span class="ml-15"
            ><span class="text-grey">{{
              fontSizes[selectedFontSize].value
            }}</span
            ><v-icon>mdi-menu-down</v-icon></span
          >
        </v-btn>
      </template>

      <v-list>
        <v-list-item-group v-model="selectedFontSize" color="primary">
          <v-list-item
            class="pl-1"
            v-for="(item, i) in fontSizes"
            :key="i"
            link
          >
            <v-list-item-icon class="mr-2">
              <v-icon v-show="selectedFontSize === item.id">mdi-check</v-icon>
            </v-list-item-icon>
            <v-list-item-title>
              <div class="d-flex align-center">
                <span :style="{ fontSize: item.size }">{{ item.title }}</span>
                <v-spacer></v-spacer>
                {{ item.value }}
              </div>
            </v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-menu>
    <!-- Font Size -->

    <!-- Font Family -->
    <v-menu offset-y>
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="black" icon v-bind="attrs" v-on="on" class="mr-4">
          <v-icon>mdi-fountain-pen</v-icon>
        </v-btn>
      </template>
      <v-list>
        <v-list-item-group v-model="selectedFontFamily" color="primary">
          <v-list-item
            class="pl-1"
            v-for="(item, i) in fontFamilies"
            :key="i"
            link
          >
            <v-list-item-icon class="mr-2">
              <v-icon v-show="selectedFontFamily === item.id">mdi-check</v-icon>
            </v-list-item-icon>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-menu>
    <!-- Font Family -->
    <!-- Color -->
    <span class="mr-4">
      <ColorPickerWidget
        @colorElement="textColor = $event"
        :type="elementStatus"
        :color="textColor"
      />
    </span>
    <!-- Color -->

    <!-- Font Type -->
    <v-btn-toggle
      class="d-content ma-0"
      v-model="selectedTextType"
      tile
      dense
      color="deep-purple accent-3"
      group
      multiple
    >
      <v-btn
        icon
        v-for="text in textTypes"
        :key="text.id"
        :value="text.id"
        color="black"
        class="ma-0 mr-4"
      >
        <v-icon>{{ text.icon }}</v-icon>
      </v-btn>
    </v-btn-toggle>

    <!-- Font Type -->
    <v-menu bottom origin="center center" transition="scale-transition">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="black"
          icon
          class="text-capitalize mr-4"
          v-bind="attrs"
          v-on="on"
        >
          <v-icon>mdi-format-letter-case-lower</v-icon>
        </v-btn>
      </template>
      <v-list>
        <v-list-item-group v-model="selectedLetterCase" color="primary">
          <v-list-item v-for="(item, i) in letterCases" :key="i">
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-menu>

    <!-- Alignment -->
    <v-menu offset-y>
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="black" icon v-bind="attrs" v-on="on" class="mr-4">
          <v-icon>mdi-format-align-left</v-icon>
        </v-btn>
      </template>

      <v-btn-toggle return-object v-model="selectedTextHorizontal">
        <v-btn v-for="text in textHorizontal" :key="text.id" :value="text.id">
          <v-icon>{{ text.icon }}</v-icon>
        </v-btn>
      </v-btn-toggle>
    </v-menu>
    <!-- Alignment -->

    <!-- Links -->
    <v-menu
      offset-y
      :nudge-width="200"
      :close-on-content-click="false"
      :style="{ minHeight: '400px' }"
      attach
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="black" icon v-bind="attrs" v-on="on" class="mr-4">
          <v-icon>mdi-link-variant</v-icon>
        </v-btn>
      </template>

      <v-row class="pa-4 bg-white">
        <v-col cols="12">
          <h2 class="headline font-weight-medium mb-2">
            Link Settings
          </h2>
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
      </v-row>
    </v-menu>
    <!-- Links -->
  </v-sheet>
</template>

<script>
import ColorPickerWidget from "../ColorPickerWidget";
import { mapGetters } from "vuex";
export default {
  name: "TextSettingEditor",
  components: {
    ColorPickerWidget,
  },
  data() {
    return {
      textColor: "#000000de",
      elementStatus: "element",
      fontSizes: [
        { id: 0, title: "Heading 1", value: "60px", size: "32px" },
        { id: 1, title: "Heading 2", value: "56px", size: "30px" },
        { id: 2, title: "Heading 3", value: "48px", size: "26px" },
        { id: 3, title: "Heading 4", value: "40px", size: "22px" },
        { id: 4, title: "Heading 5", value: "32px", size: "18px" },
        { id: 5, title: "Heading 6", value: "24px", size: "14px" },
        { id: 6, title: "Paragraph 1", value: "18px", size: "18px" },
        { id: 7, title: "Paragraph 2", value: "16px", size: "16px" },
        { id: 8, title: "Paragraph 3", value: "14px", size: "14px" },
      ],
      textTypes: [
        { id: 0, title: "bold", icon: "mdi-format-bold" },
        { id: 1, title: "italic", icon: "mdi-format-italic" },
        { id: 2, title: "underline", icon: "mdi-format-underline" },
      ],
      selectedTextType: [],
      selectedFontSize: 2,
      selectedLetterCase: 0,
      textHorizontal: [
        { id: 0, title: "left", icon: "mdi-format-align-left" },
        { id: 1, title: "center", icon: "mdi-format-align-center" },
        { id: 2, title: "right", icon: "mdi-format-align-right" },
      ],
      selectedTextHorizontal: 1,
      letterCases: [
        { id: 0, title: "Auto", value: "none", icon: "mdi-text" },
        {
          id: 1,
          title: "Uppercase",
          value: "uppercase",
          icon: "mdi-format-letter-case-upper",
        },
        {
          id: 2,
          title: "Lowercase",
          value: "lowercase",
          icon: "mdi-format-letter-case-lower",
        },
        {
          id: 3,
          title: "Title case",
          value: "capitalize",
          icon: "mdi-format-title",
        },
      ],
      fontFamilies: [
        { id: 0, title: "Roboto-Light", value: "'Roboto-Light'" },
        { id: 1, title: "Roboto-Regular", value: "'Roboto-Regular'" },
        { id: 2, title: "Roboto-Medium", value: "'Roboto-Medium'" },
        {
          id: 3,
          title: "Material Design Icons",
          value: "'Material Design Icons'",
        },
        { id: 4, title: "Auto", value: "auto" },
        { id: 5, title: "Cursive", value: "cursive" },
        { id: 6, title: "Emoji", value: "emoji" },
        { id: 7, title: "Fangsong", value: "fangsong" },
        { id: 8, title: "Fantasy", value: "fantasy" },
        { id: 9, title: "Math", value: "math" },
        { id: 10, title: "Monospace", value: "monospace" },
        { id: 11, title: "Sans-serif", value: "sans-serif" },
        { id: 12, title: "Serif", value: "serif" },
        { id: 13, title: "System-ui", value: "system-ui" },
        { id: 14, title: "Ui-monospace", value: "ui-monospace" },
        { id: 15, title: "Ui-rounded", value: "ui-rounded" },
        { id: 16, title: "Ui-sans-serif", value: "ui-sans-serif" },
        { id: 17, title: "Webkit-body", value: "-webkit-body" },
        { id: 18, title: "Webkit-pictograph", value: "-webkit-pictograph" },
      ],
      selectedFontFamily: 0,
      // Link to
      selectedLinkTo: 0,
      selectedPage: null,
      selectedUrl: null,
      statusNewTab: false,
      tags: [
        { id: 0, title: "Page" },
        { id: 1, title: "URL" },
        { id: 2, title: "Phone" },
        { id: 3, title: "Email" },
      ],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getPages"]),
    fontWeight: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element === this.textTypes[0].id
      );
      if (index > -1) {
        return this.textTypes[0].title;
      } else {
        return "";
      }
    },
    fontStyle: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element === this.textTypes[1].id
      );
      if (index > -1) {
        return this.textTypes[1].title;
      } else {
        return "";
      }
    },
    textDecoration: function() {
      const index = this.selectedTextType.findIndex(
        (element) => element === this.textTypes[2].id
      );
      if (index > -1) {
        return this.textTypes[2].title;
      } else {
        return "";
      }
    },
  },
  updated() {
    const styles = {
      textAlign: this.textHorizontal[this.selectedTextHorizontal].title,
      fontWeight: this.fontWeight,
      fontStyle: this.fontStyle,
      textDecoration: this.textDecoration,
      color: this.textColor,
      textTransform: this.letterCases[this.selectedLetterCase].value,
      fontSize: this.fontSizes[this.selectedFontSize].value,
      fontFamily: this.fontFamilies[this.selectedFontFamily].value,
    };
    this.$emit("styles", styles);
  },
};
</script>

<style scoped>
.settings {
  position: absolute;
  min-width: 700px;
  max-width: 700px;
  top: -40px;
}
.text-grey {
  color: grey;
}
.d-content {
  display: contents;
}
.bg-white {
  background: white !important;
}
::v-deep.v-menu__content {
  overflow: hidden !important;
}
</style>
