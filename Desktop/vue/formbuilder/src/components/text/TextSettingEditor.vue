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
              fontSizes[selectedFontSize].valueSize
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
            @click="onChangeFontSize(item.value)"
          >
            <v-list-item-icon class="mr-2">
              <v-icon v-show="selectedFontSize === item.id">mdi-check</v-icon>
            </v-list-item-icon>
            <v-list-item-title>
              <div class="d-flex align-center">
                <span :style="{ fontSize: item.size }">{{ item.title }}</span>
                <v-spacer></v-spacer>
                {{ item.valueSize }}
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
            @click="onChangeFontFamily()"
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
        @colorElement="
          textColor = $event;
          onChangeFontColor();
        "
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
        @click="onChangeFont(text.click)"
      >
        <v-icon>{{ text.icon }}</v-icon>
      </v-btn>
    </v-btn-toggle>

    <!-- Font Letter Type -->
    <!-- <v-menu bottom origin="center center" transition="scale-transition">
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
          <v-list-item
            v-for="(item, i) in letterCases"
            :key="i"
            @click="onChangeFontTransform()"
          >
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-menu> -->

    <!-- Alignment -->
    <v-menu offset-y>
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="black" icon v-bind="attrs" v-on="on" class="mr-4">
          <v-icon>mdi-format-align-left</v-icon>
        </v-btn>
      </template>

      <v-btn-toggle return-object v-model="selectedTextHorizontal">
        <v-btn
          v-for="text in textHorizontal"
          :key="text.id"
          :value="text.id"
          @click="onChangeTextAlignment(text.title)"
        >
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
      :close-on-click="false"
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
        <v-col cols="12">
          <v-row justify="end"
            ><v-btn @click="onChangeLink()" text>save</v-btn></v-row
          >
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
        {
          id: 0,
          title: "Heading 1",
          value: "h1",
          labelSize: "32px",
          valueSize: "80px",
        },
        {
          id: 1,
          title: "Heading 2",
          value: "h2",
          labelSize: "30px",
          valueSize: "64px",
        },
        {
          id: 2,
          title: "Heading 3",
          value: "h3",
          labelSize: "26px",
          valueSize: "48px",
        },
        {
          id: 3,
          title: "Heading 4",
          value: "h4",
          labelSize: "22px",
          valueSize: "40px",
        },
        {
          id: 4,
          title: "Heading 5",
          value: "h5",
          labelSize: "18px",
          valueSize: "32px",
        },
        {
          id: 5,
          title: "Heading 6",
          value: "h6",
          labelSize: "14px",
          valueSize: "32px",
        },
        {
          id: 6,
          title: "Paragraph 1",
          value: "p1",
          labelSize: "18px",
          valueSize: "24px",
        },
        {
          id: 7,
          title: "Paragraph 2",
          value: "p2",
          labelSize: "16px",
          valueSize: "16px",
        },
        {
          id: 8,
          title: "Paragraph 3",
          value: "p3",
          labelSize: "14px",
          valueSize: "14px",
        },
      ],
      textTypes: [
        {
          id: 0,
          title: "bold",
          icon: "mdi-format-bold",
          click: "bold",
        },
        {
          id: 1,
          title: "italic",
          icon: "mdi-format-italic",
          click: "italic",
        },
        {
          id: 2,
          title: "underline",
          icon: "mdi-format-underline",
          click: "underline",
        },
      ],
      selectedTextType: [],
      selectedFontSize: 2,
      selectedLetterCase: 0,
      textHorizontal: [
        { id: 0, title: "left", icon: "mdi-format-align-left" },
        { id: 1, title: "center", icon: "mdi-format-align-center" },
        { id: 2, title: "right", icon: "mdi-format-align-right" },
      ],
      selectedTextHorizontal: 0,
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
    ...mapGetters(["getSelectedWidgetById", "getPages", "getScreenSize"]),
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
  methods: {
    onChangeFontSize: function(value) {
      // if (this.getScreenSize.screen === "web") {
      //   // this.fontSizeScreen.web = value;
      //   // if (this.fontSizeScreen.mobile === null)
      //   //   this.fontSizeScreen.mobile = value;
      // }

      // if (this.getScreenSize.screen === "mobile") {
      //   this.fontSizeScreen.mobile = value;
      // }

      const styles = {
        textAlign: this.textHorizontal[this.selectedTextHorizontal].title,
        fontWeight: this.fontWeight,
        fontStyle: this.fontStyle,
        textDecoration: this.textDecoration,
        color: this.textColor,
        textTransform: this.letterCases[this.selectedLetterCase].value,
        fontSize: value,
        fontFamily: this.fontFamilies[this.selectedFontFamily].value,
      };
      this.$emit("onChangeFontSize", styles);
    },
    onChangeFontFamily: function() {
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
      this.$emit("onChangeFontFamily", styles);
    },
    onChangeFontColor: function() {
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
      this.$emit("onChangeFontColor", styles);
    },
    onChangeFont: function(action) {
      let styles;
      console.log("hello");
      switch (action) {
        case "bold":
          styles = {
            textAlign: this.textHorizontal[this.selectedTextHorizontal].title,
            fontWeight: this.fontWeight,
            fontStyle: this.fontStyle,
            textDecoration: this.textDecoration,
            color: this.textColor,
            textTransform: this.letterCases[this.selectedLetterCase].value,
            fontSize: this.fontSizes[this.selectedFontSize].value,
            fontFamily: this.fontFamilies[this.selectedFontFamily].value,
          };
          this.$emit("onChangeFontBold", styles);
          break;

        case "italic":
          styles = {
            textAlign: this.textHorizontal[this.selectedTextHorizontal].title,
            fontWeight: this.fontWeight,
            fontStyle: this.fontStyle,
            textDecoration: this.textDecoration,
            color: this.textColor,
            textTransform: this.letterCases[this.selectedLetterCase].value,
            fontSize: this.fontSizes[this.selectedFontSize].value,
            fontFamily: this.fontFamilies[this.selectedFontFamily].value,
          };
          this.$emit("onChangeFontStyle", styles);
          break;

        case "underline":
          styles = {
            textAlign: this.textHorizontal[this.selectedTextHorizontal].title,
            fontWeight: this.fontWeight,
            fontStyle: this.fontStyle,
            textDecoration: this.textDecoration,
            color: this.textColor,
            textTransform: this.letterCases[this.selectedLetterCase].value,
            fontSize: this.fontSizes[this.selectedFontSize].value,
            fontFamily: this.fontFamilies[this.selectedFontFamily].value,
          };
          this.$emit("onChangeFontUnderline", styles);
          break;
      }
    },
    onChangeFontTransform: function() {
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
      this.$emit("onChangeFontTransform", styles);
    },
    onChangeTextAlignment: function(value) {
      const styles = {
        textAlign: value,
        fontWeight: this.fontWeight,
        fontStyle: this.fontStyle,
        textDecoration: this.textDecoration,
        color: this.textColor,
        textTransform: this.letterCases[this.selectedLetterCase].value,
        fontSize: this.fontSizes[this.selectedFontSize].value,
        fontFamily: this.fontFamilies[this.selectedFontFamily].value,
      };
      this.$emit("onChangeTextAlignment", styles);
    },
    onChangeLink: function() {
      var fontElements = window.getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          switch (this.selectedLinkTo) {
            case 0:
              document.execCommand(
                "createLink",
                false,
                this.getSelectedWidgetById.properties.page
              );
              break;
            case 1:
              document.execCommand(
                "createLink",
                false,
                this.getSelectedWidgetById.properties.url
              );
              break;
            case 2:
              document.execCommand(
                "createLink",
                false,
                "tel:" + this.getSelectedWidgetById.properties.phone
              );
              break;
            case 3:
              document.execCommand(
                "createLink",
                false,
                "mailto:" + this.getSelectedWidgetById.properties.email
              );
              break;
          }
        }
    },
  },
  watch: {
    selectedLinkTo: function(value) {
      this.getSelectedWidgetById.properties.selectedLinkTo = value;
    },
    getScreenSize: function(event) {
      if (event.screen === "web") {
        this.fontSizes = [
          {
            id: 0,
            title: "Heading 1",
            value: "h1",
            labelSize: "32px",
            valueSize: "80px",
          },
          {
            id: 1,
            title: "Heading 2",
            value: "h2",
            labelSize: "30px",
            valueSize: "64px",
          },
          {
            id: 2,
            title: "Heading 3",
            value: "h3",
            labelSize: "26px",
            valueSize: "48px",
          },
          {
            id: 3,
            title: "Heading 4",
            value: "h4",
            labelSize: "22px",
            valueSize: "40px",
          },
          {
            id: 4,
            title: "Heading 5",
            value: "h5",
            labelSize: "18px",
            valueSize: "32px",
          },
          {
            id: 5,
            title: "Heading 6",
            value: "h6",
            labelSize: "14px",
            valueSize: "32px",
          },
          {
            id: 6,
            title: "Paragraph 1",
            value: "p1",
            labelSize: "18px",
            valueSize: "24px",
          },
          {
            id: 7,
            title: "Paragraph 2",
            value: "p2",
            labelSize: "16px",
            valueSize: "16px",
          },
          {
            id: 8,
            title: "Paragraph 3",
            value: "p3",
            labelSize: "14px",
            valueSize: "14px",
          },
        ];
      } else {
        this.fontSizes = [
          {
            id: 0,
            title: "Heading 1",
            value: "h1",
            labelSize: "32px",
            valueSize: "44px",
          },
          {
            id: 1,
            title: "Heading 2",
            value: "h2",
            labelSize: "30px",
            valueSize: "36px",
          },
          {
            id: 2,
            title: "Heading 3",
            value: "h3",
            labelSize: "26px",
            valueSize: "32px",
          },
          {
            id: 3,
            title: "Heading 4",
            value: "h4",
            labelSize: "22px",
            valueSize: "28px",
          },
          {
            id: 4,
            title: "Heading 5",
            value: "h5",
            labelSize: "18px",
            valueSize: "24px",
          },
          {
            id: 5,
            title: "Heading 6",
            value: "h6",
            labelSize: "14px",
            valueSize: "20px",
          },
          {
            id: 6,
            title: "Paragraph 1",
            value: "p1",
            labelSize: "18px",
            valueSize: "18px",
          },
          {
            id: 7,
            title: "Paragraph 2",
            value: "p2",
            labelSize: "16px",
            valueSize: "16px",
          },
          {
            id: 8,
            title: "Paragraph 3",
            value: "p3",
            labelSize: "14px",
            valueSize: "14px",
          },
        ];
      }
    },
  },
  updated() {
    // if (this.i < 2) {
    //   const p = document.querySelector("#p");
    //   let range = new Range();
    //   range.setStart(p.firstChild, 1);
    //   range.setEnd(p.firstChild, 4);
    //   // alert(range); // ample: italic and bol
    //   // use this range for selection (explained later)
    //   document.getSelection().removeAllRanges();
    //   window.getSelection().addRange(range);
    //   var inputRange = p.createTextRange();
    //   inputRange.moveStart("character", 1);
    //   inputRange.collapse();
    //   inputRange.moveEnd("character", 1);
    //   inputRange.select();
    //   this.i++;
    // }
    // var elemToSelect = document.querySelector("b");
    // if (window.getSelection) {
    //   // all browsers, except IE before version 9
    //   var selection = window.getSelection();
    //   var rangeToSelect = document.createRange();
    //   rangeToSelect.selectNodeContents(elemToSelect);
    //   selection.removeAllRanges();
    //   selection.addRange(rangeToSelect);
    // } else {
    //   if (document.body.createTextRange) {
    //     // Internet Explorer
    //     var rangeToSelect2 = document.body.createTextRange();
    //     rangeToSelect2.moveToElementText(elemToSelect);
    //     rangeToSelect2.select();
    //   }
    // }
    // document.onselectionchange = function() {
    //   let selection = document.getSelection();
    //   if (selection.type === "Range") {
    //     console.log(selection);
    //     let { anchorNode, anchorOffset, focusNode, focusOffset } = selection;
    //     // anchorNode and focusNode are text nodes usually
    //     console.log(
    //       `${anchorNode?.data}, offset ${anchorOffset}`,
    //       `${focusNode?.data}, offset ${focusOffset}`
    //     );
    //     document.createTextR
    //     // rangeToSelect2.select();
    //   }
    // };
    // if (selection.rangeCount > 0) {
    //   selection.removeAllRanges();
    // }
    // const p = window.getSelection();
    // console.log(p);
    // let range = new Range();
    // range.setStart(p, 2);
    // range.setEnd(p, 4);
    // document.getSelection().addRange(range);
  },
  created() {
    // if (this.getScreenSize.screen === "web") {
    //   this.fontSizes = [
    //     { id: 0, title: "Heading 1", value: "80px", size: "32px" },
    //     { id: 1, title: "Heading 2", value: "64px", size: "30px" },
    //     { id: 2, title: "Heading 3", value: "48px", size: "26px" },
    //     { id: 3, title: "Heading 4", value: "40px", size: "22px" },
    //     { id: 4, title: "Heading 5", value: "32px", size: "18px" },
    //     { id: 5, title: "Heading 6", value: "24px", size: "14px" },
    //     { id: 6, title: "Paragraph 1", value: "18px", size: "18px" },
    //     { id: 7, title: "Paragraph 2", value: "16px", size: "16px" },
    //     { id: 8, title: "Paragraph 3", value: "14px", size: "14px" },
    //   ];
    // } else {
    //   this.fontSizes = [
    //     { id: 0, title: "Heading 1", value: "44px", size: "32px" },
    //     { id: 1, title: "Heading 2", value: "36px", size: "30px" },
    //     { id: 2, title: "Heading 3", value: "32px", size: "26px" },
    //     { id: 3, title: "Heading 4", value: "28px", size: "22px" },
    //     { id: 4, title: "Heading 5", value: "24px", size: "18px" },
    //     { id: 5, title: "Heading 6", value: "20px", size: "14px" },
    //     { id: 6, title: "Paragraph 1", value: "18px", size: "18px" },
    //     { id: 7, title: "Paragraph 2", value: "16px", size: "16px" },
    //     { id: 8, title: "Paragraph 3", value: "14px", size: "14px" },
    //   ];
    // }
    if (this.getScreenSize.screen === "web") {
      this.fontSizes = [
        {
          id: 0,
          title: "Heading 1",
          value: "h1",
          labelSize: "32px",
          valueSize: "80px",
        },
        {
          id: 1,
          title: "Heading 2",
          value: "h2",
          labelSize: "30px",
          valueSize: "64px",
        },
        {
          id: 2,
          title: "Heading 3",
          value: "h3",
          labelSize: "26px",
          valueSize: "48px",
        },
        {
          id: 3,
          title: "Heading 4",
          value: "h4",
          labelSize: "22px",
          valueSize: "40px",
        },
        {
          id: 4,
          title: "Heading 5",
          value: "h5",
          labelSize: "18px",
          valueSize: "32px",
        },
        {
          id: 5,
          title: "Heading 6",
          value: "h6",
          labelSize: "14px",
          valueSize: "32px",
        },
        {
          id: 6,
          title: "Paragraph 1",
          value: "p1",
          labelSize: "18px",
          valueSize: "24px",
        },
        {
          id: 7,
          title: "Paragraph 2",
          value: "p2",
          labelSize: "16px",
          valueSize: "16px",
        },
        {
          id: 8,
          title: "Paragraph 3",
          value: "p3",
          labelSize: "14px",
          valueSize: "14px",
        },
      ];
    } else {
      this.fontSizes = [
        {
          id: 0,
          title: "Heading 1",
          value: "h1",
          labelSize: "32px",
          valueSize: "44px",
        },
        {
          id: 1,
          title: "Heading 2",
          value: "h2",
          labelSize: "30px",
          valueSize: "36px",
        },
        {
          id: 2,
          title: "Heading 3",
          value: "h3",
          labelSize: "26px",
          valueSize: "32px",
        },
        {
          id: 3,
          title: "Heading 4",
          value: "h4",
          labelSize: "22px",
          valueSize: "28px",
        },
        {
          id: 4,
          title: "Heading 5",
          value: "h5",
          labelSize: "18px",
          valueSize: "24px",
        },
        {
          id: 5,
          title: "Heading 6",
          value: "h6",
          labelSize: "14px",
          valueSize: "20px",
        },
        {
          id: 6,
          title: "Paragraph 1",
          value: "p1",
          labelSize: "18px",
          valueSize: "18px",
        },
        {
          id: 7,
          title: "Paragraph 2",
          value: "p2",
          labelSize: "16px",
          valueSize: "16px",
        },
        {
          id: 8,
          title: "Paragraph 3",
          value: "p3",
          labelSize: "14px",
          valueSize: "14px",
        },
      ];
    }
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
