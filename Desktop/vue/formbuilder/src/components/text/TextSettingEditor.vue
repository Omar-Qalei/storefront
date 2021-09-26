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
          <!-- {{ selectedFontSize.title }} -->
          {{ statusIsActiveClassList().title }}
          <span class="ml-15">
            <span class="text-grey">{{
              statusIsActiveClassList().valueSize
            }}</span>
            <v-icon>mdi-menu-down</v-icon></span
          >
        </v-btn>
      </template>

      <v-list>
        <v-list-item
          class="pl-1"
          v-for="(item, i) in fontSizes"
          :key="i"
          link
          @click="
            editor
              .chain()
              .focus()
              .setAddClass(item.value)
              .run()
          "
          :style="
            statusIsActiveClass(item.value)
              ? { color: '#6200ea', backgroundColor: '#ede1fd' }
              : ''
          "
        >
          <v-list-item-icon class="mr-2">
            <v-icon
              :color="statusIsActiveClass(item.value) ? 'primary' : ''"
              v-show="statusIsActiveClass(item.value)"
              >mdi-check</v-icon
            >
          </v-list-item-icon>
          <v-list-item-title>
            <div class="d-flex align-center">
              <span :style="{ fontSize: item.size }">{{ item.title }}</span>
              <v-spacer></v-spacer>
              {{ item.valueSize }}
            </div>
          </v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
    <!-- Font Size -->

    <!-- Font Family -->
    <v-menu offset-y>
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="black" icon v-bind="attrs" v-on="on" class="mr-4">
          <v-icon
            :class="{
              'is-active': statusIsActiveFontFamilyList(),
            }"
            >mdi-fountain-pen</v-icon
          >
        </v-btn>
      </template>
      <v-list>
        <v-list-item
          class="pl-1"
          v-for="(item, i) in fontFamilies"
          :key="i"
          link
          @click="
            editor
              .chain()
              .focus()
              .setFontFamily(item.value)
              .run()
          "
          :style="
            statusIsActiveFontFamily(item.value)
              ? { color: '#6200ea', backgroundColor: '#ede1fd' }
              : ''
          "
        >
          <v-list-item-icon class="mr-2">
            <v-icon
              :color="statusIsActiveFontFamily(item.value) ? 'primary' : ''"
              v-show="statusIsActiveFontFamily(item.value)"
              >mdi-check</v-icon
            >
          </v-list-item-icon>
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
    <!-- Font Family -->

    <!-- Color -->
    <span class="mr-4">
      <ColorPickerTextEditorWidget
        @colorElement="
          textColor = $event;
          canChangeColor
            ? editor
                .chain()
                .focus()
                .setColor($event)
                .run()
            : null;
        "
        @canEdit="canChangeColor = $event"
        :type="elementStatus"
        :color="textColor"
      />
    </span>
    <!-- Color -->

    <!-- Font Type -->
    <v-btn
      class="ma-0 mr-4"
      icon
      color="black"
      @click="
        editor
          .chain()
          .focus()
          .toggleBold()
          .run()
      "
    >
      <v-icon :class="{ 'is-active': editor.isActive('bold') }"
        >mdi-format-bold</v-icon
      >
    </v-btn>
    <v-btn
      icon
      color="black"
      class="ma-0 mr-4"
      @click="
        editor
          .chain()
          .focus()
          .toggleItalic()
          .run()
      "
    >
      <v-icon :class="{ 'is-active': editor.isActive('italic') }"
        >mdi-format-italic</v-icon
      >
    </v-btn>
    <v-btn
      @click="
        editor
          .chain()
          .focus()
          .toggleUnderline()
          .run()
      "
      icon
      color="black"
      class="ma-0 mr-4"
    >
      <v-icon :class="{ 'is-active': editor.isActive('underline') }"
        >mdi-format-underline</v-icon
      >
    </v-btn>
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
          <v-icon
            :class="{
              'is-active': statusIsActiveTextAlignList(),
            }"
            >mdi-format-align-left</v-icon
          >
        </v-btn>
      </template>
      <v-card>
        <!-- Text Align Left -->
        <v-btn
          @click="
            editor
              .chain()
              .focus()
              .setTextAlign('left')
              .run()
          "
          icon
          color="black"
          class="ma-0 mr-4"
        >
          <v-icon
            :class="{ 'is-active': editor.isActive({ textAlign: 'left' }) }"
            >mdi-format-align-left</v-icon
          >
        </v-btn>

        <!-- Text Align Center -->
        <v-btn
          @click="
            editor
              .chain()
              .focus()
              .setTextAlign('center')
              .run()
          "
          icon
          color="black"
          class="ma-0 mr-4"
        >
          <v-icon
            :class="{ 'is-active': editor.isActive({ textAlign: 'center' }) }"
            >mdi-format-align-center</v-icon
          >
        </v-btn>

        <!-- Text Align Right -->
        <v-btn
          @click="
            editor
              .chain()
              .focus()
              .setTextAlign('right')
              .run()
          "
          icon
          color="black"
          class="ma-0 mr-4"
        >
          <v-icon
            :class="{ 'is-active': editor.isActive({ textAlign: 'right' }) }"
            >mdi-format-align-right</v-icon
          >
        </v-btn>
      </v-card>
    </v-menu>
    <!-- Alignment -->

    <!-- Links -->
    <v-menu
      v-model="linkStatus"
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

      <v-row class="pa-4 bg-white text-left">
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
            v-model="selectedPage"
            outlined
          ></v-select>
          <template v-if="selectedLinkTo === 1">
            <v-text-field
              placeholder="https://www.example.com"
              v-model="selectedUrl"
              outlined
              hide-details
            ></v-text-field>
            <v-switch label="Open a new tab" v-model="statusNewTab"></v-switch>
          </template>
          <v-text-field
            v-if="selectedLinkTo === 2"
            placeholder="Ex. 079-501-218"
            v-model="selectedPhone"
            outlined
            hide-details
          ></v-text-field>
          <v-text-field
            v-if="selectedLinkTo === 3"
            placeholder="example@example.com"
            v-model="selectedEmail"
            outlined
            hide-details
          ></v-text-field>
        </v-col>
        <v-col cols="12">
          <v-row justify="end"><v-btn @click="setLink" text>save</v-btn></v-row>
        </v-col>
      </v-row>
    </v-menu>
    <!-- Links -->

    <!-- History -->
    <!-- Undo -->
    <v-btn
      @click="
        editor
          .chain()
          .focus()
          .undo()
          .run()
      "
      icon
      color="black"
      class="ma-0 mr-4"
    >
      <v-icon>mdi-undo</v-icon>
    </v-btn>
    <!-- Undo -->

    <!-- Redo -->
    <v-btn
      @click="
        editor
          .chain()
          .focus()
          .redo()
          .run()
      "
      icon
      color="black"
      class="ma-0 mr-4"
    >
      <v-icon>mdi-redo</v-icon>
    </v-btn>
    <!-- Redo -->
    <!-- History -->
  </v-sheet>
</template>

<script>
import ColorPickerTextEditorWidget from "../ColorPickerTextEditorWidget.vue";
import { mapGetters } from "vuex";
export default {
  name: "TextSettingEditor",
  props: {
    editor: {
      type: Object,
      required: true,
    },
  },
  components: {
    ColorPickerTextEditorWidget,
  },
  data() {
    return {
      canChangeColor: false,
      linkStatus: false,
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
      selectedFontSize: {
        title: "Heading 3",
        valueSize: "48px",
      },
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
      selectedPhone: null,
      selectedEmail: null,
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
    onChangeFontColor: function() {
      if (this.canChangeColor) {
        this.editor
          .chain()
          .focus()
          .setColor(this.textColor)
          .run();
      }
    },
    statusIsActiveFontFamily: function(value) {
      return this.editor.isActive("textStyle", { fontFamily: value });
    },
    statusIsActiveFontFamilyList: function() {
      for (let index = 0; index < this.fontFamilies.length; index++) {
        const status = this.editor.isActive("textStyle", {
          fontFamily: this.fontFamilies[index].value,
        });
        if (status) return true;
      }
      return false;
    },
    statusIsActiveClass: function(value) {
      if (value) return this.editor.isActive("textStyle", { addClass: value });
    },
    statusIsActiveClassList: function() {
      for (let index = 0; index < this.fontSizes.length; index++) {
        const status = this.editor.isActive("textStyle", {
          addClass: this.fontSizes[index].value,
        });
        if (status)
          return {
            title: this.fontSizes[index].title,
            valueSize: this.fontSizes[index].valueSize,
          };
      }
      return {
        title: "Heading 3",
        valueSize: "48px",
      };
    },
    statusIsActiveTextAlignList: function() {
      for (let index = 0; index < this.textHorizontal.length; index++) {
        const status = this.editor.isActive("textStyle", {
          textAlign: this.textHorizontal[index].title,
        });
        if (status) return true;
      }
      return false;
    },
    setLink() {
      const previousUrl = this.editor.getAttributes("link").href;
      console.log("previousUrl", previousUrl);
      switch (this.selectedLinkTo) {
        case 0:
          this.editor
            .chain()
            .focus()
            .extendMarkRange("link")
            .setLink({
              href: `?siteId=${this.selectedPage.site_id}&pageId=${this.selectedPage.id}`,
              target: "_self",
            })
            .run();
          break;
        case 1:
          this.editor
            .chain()
            .focus()
            .extendMarkRange("link")
            .setLink({
              href: this.selectedUrl,
              target: this.statusNewTab ? "_blank" : "_self",
            })
            .run();
          break;
        case 2:
          this.editor
            .chain()
            .focus()
            .extendMarkRange("link")
            .setLink({
              href: `tel:${this.selectedPhone}`,
              target: "_self",
            })
            .run();
          break;
        case 3:
          this.editor
            .chain()
            .focus()
            .extendMarkRange("link")
            .setLink({
              href: `mailTo:${this.selectedEmail}`,
              target: "_self",
            })
            .run();
          break;
      }
      this.linkStatus = false;
      // update link
    },
    getLink() {
      // if (Object.keys(this.editor.getAttributes("link")).length > 0) {
      //   const str = this.editor.getAttributes("link").href;
      //   if (str.includes("pageId=")) {
      //     this.selectedLinkTo = 0;
      //     if (str.split("pageId=")) {
      //       const href = +str.split("pageId=")[1];
      //       console.log(href);
      //     }
      //   }
      //   if (str.includes("//www.")) {
      //     this.selectedLinkTo = 1;
      //     this.selectedUrl = str;
      //     this.statusNewTab =
      //       this.editor.getAttributes("link").target === "_blank"
      //         ? true
      //         : false;
      //   }
      //   if (str.includes("tel:")) {
      //     const href = href.split("tel:")[1];
      //     this.selectedLinkTo = 2;
      //     this.selectedPhone = href;
      //   }
      //   if (str.includes("mailTo:")) {
      //     const href = href.split("mailTo:")[1];
      //     this.selectedLinkTo = 3;
      //     this.selectedEmail = href;
      //   }
      // }
    },
  },
  watch: {
    statusIsActiveFontFamily: function(value) {
      return this.editor.isActive("textStyle", { fontFamily: value });
    },
    statusIsActiveClass: function(value) {
      return this.editor.isActive("textStyle", { addClass: value });
    },
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
    this.textColor = this.editor.getAttributes("textStyle").color;
    // if (!this.linkStatus) this.getLink();
    this.getSelectedWidgetById.properties.style = {
      json: this.editor.getJSON(),
      html: this.editor.getHTML(),
    };
  },
  created() {
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
  min-width: 800px;
  max-width: 800px;
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
.is-active {
  color: blue !important;
}
</style>
