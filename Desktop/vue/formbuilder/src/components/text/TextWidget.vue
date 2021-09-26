<template>
  <div class="widget">
    <template v-if="editor && !displayEditor">
      <TextSetting
        :show="item.i === getSelectedWidgetById.i"
        :item="item"
        :sectionId="sectionId"
        @displayEditor="onDisplayEditor($event)"
      />
    </template>
    <template v-else>
      <TextSettingEditor
        v-if="item.i === getSelectedWidgetById.i"
        :editor="editor"
      />
    </template>
    <template v-if="editor">
      <editor-content :id="item.i" :editor="editor" />
    </template>
  </div>
</template>

<script>
import TextSettingEditor from "./TextSettingEditor";
import TextSetting from "./TextSetting";
import { mapGetters, mapActions } from "vuex";
import { SiteService } from "../../services/site/site";
import { Editor, EditorContent } from "@tiptap/vue-2";
import StarterKit from "@tiptap/starter-kit";
import TextStyle from "@tiptap/extension-text-style";
import FontFamily from "@tiptap/extension-font-family";
import { Color } from "@tiptap/extension-color";
import Underline from "@tiptap/extension-underline";
import Link from "@tiptap/extension-link";
import AddClass from "./extensions/extension-add-class";
import TextAlign from "./extensions/extension-text-align";

const EXTRA_EXTENSIONS = [AddClass, TextAlign];

export default {
  name: "TextWidget",
  components: {
    // SettingsWidget,
    TextSettingEditor,
    TextSetting,
    EditorContent,
  },
  data() {
    return {
      editor: null,
      status: false,
      hover: false,
      range: null,
      details: {},
      contentAlign: null,
      rtl: false,
      disabledTitle: null,
      selection: null,
      margin: [0, 0],
      rowHeight: 24,
      displayEditor: false,
    };
  },
  props: {
    item: {},
    sectionId: Number,
    preventMove: Boolean,
    siteId: Number,
    pageId: Number,
  },
  computed: {
    ...mapGetters([
      "getSelectedWidgetById",
      "getScreenSize",
      "getWebResources",
      "getMobileResources",
    ]),
  },
  watch: {
    getSelectedWidgetById: function(widget) {
      if (widget.type !== "text") this.displayEditor = false;
    },
    preventMove: function(value) {
      this.displayEditor = value;
    },
  },
  methods: {
    ...mapActions([
      "onSortSectionsLayout",
      "onTextHeight",
      "onCheckGridHeight",
      "onCheckUpdateSectionLayoutResized",
      "onHistoryPages",
    ]),
    calcContainerHeightByRow: function() {
      if (document.getElementById(this.item.i)) {
        let h = document.getElementById(this.item.i).getBoundingClientRect()
          .height;
        let height = Math.round((h - this.margin[1]) / this.rowHeight);
        if (height % 2 !== 0) {
          height += 1;
        }
        if (this.getSelectedWidgetById.h < height)
          this.getSelectedWidgetById.h = height;
      }
    },
    onDisplayEditor: function(event) {
      this.displayEditor = event;
      this.$emit("onPreventMove", event);
    },
  },
  created() {
    if (
      this.item.i === this.getSelectedWidgetById.i &&
      this.item.type === "text"
    ) {
      this.calcContainerHeightByRow();
      this.onCheckUpdateSectionLayoutResized({
        sectionId: this.sectionId,
      });
    }
  },
  mounted() {
    this.editor = new Editor({
      extensions: [
        StarterKit,
        TextStyle,
        FontFamily,
        Color,
        Underline,
        Link,
        ...EXTRA_EXTENSIONS,
      ],
      content: {
        type: "doc",
        content: [
          {
            type: "paragraph",
            content: [
              {
                type: "text",
                marks: [
                  {
                    type: "textStyle",
                    attrs: {
                      fontFamily: null,
                      color: null,
                      addClass: "h3",
                    },
                  },
                ],
                text: "Write your text here...",
              },
            ],
          },
        ],
      },
    });
    if (this.item.properties.style === null) {
      this.item.properties.style = {
        html: this.editor.getHTML(),
        json: this.editor.getJSON(),
      };
      console.log(this.editor.getHTML());
    }
    if (this.item.properties.style !== null) {
      this.editor.commands.setContent(this.item.properties.style.json);
    }
    const thiz = this;
    window.addEventListener("click", () => {
      if (
        thiz.item.i === thiz.getSelectedWidgetById.i &&
        thiz.item.type === "text"
      ) {
        thiz.calcContainerHeightByRow();
        thiz.onCheckUpdateSectionLayoutResized({
          sectionId: thiz.sectionId,
        });
      }
      if (thiz.item.i !== thiz.getSelectedWidgetById.i && thiz.status) {
        const webResources = JSON.stringify(thiz.getWebResources);
        const mobileResources = JSON.stringify(thiz.getMobileResources);
        thiz.onHistoryPages({
          saved: false,
          web: JSON.parse(webResources),
          mobile: JSON.parse(mobileResources),
        });
        SiteService.addSitePageResourceWeb(
          thiz.siteId,
          thiz.pageId,
          JSON.stringify(thiz.getWebResources)
        )
          .then((result) => {
            console.log("Web posted", result);
          })
          .catch((error) => {
            console.log(error);
          });
        SiteService.addSitePageResourceMobile(
          thiz.siteId,
          thiz.pageId,
          JSON.stringify(thiz.getMobileResources)
        )
          .then((result) => {
            console.log("Mobile posted", result);
          })
          .catch((error) => {
            console.log(error);
          });
      }
      if (thiz.item.i === thiz.getSelectedWidgetById.i) thiz.status = true;
      else thiz.status = false;
    });
    window.addEventListener("mouseup", () => {
      if (
        thiz.item.i === thiz.getSelectedWidgetById.i &&
        thiz.item.type === "text"
      ) {
        thiz.calcContainerHeightByRow();
        thiz.onCheckUpdateSectionLayoutResized({
          sectionId: thiz.sectionId,
        });
      }
    });
    window.addEventListener("keyup", (event) => {
      if (event.code !== "Backspace" || event.code !== "Delete")
        if (
          thiz.item.i === thiz.getSelectedWidgetById.i &&
          thiz.item.type === "text"
        ) {
          thiz.calcContainerHeightByRow();
          thiz.onCheckUpdateSectionLayoutResized({
            sectionId: thiz.sectionId,
          });
        }
    });
    window.addEventListener("keydown", (event) => {
      if (event.code !== "Backspace" || event.code !== "Delete")
        if (
          thiz.item.i === thiz.getSelectedWidgetById.i &&
          thiz.item.type === "text"
        ) {
          thiz.calcContainerHeightByRow();
          thiz.onCheckUpdateSectionLayoutResized({
            sectionId: thiz.sectionId,
          });
        }
    });
    // else thiz.status = false;
  },
  updated() {
    if (
      this.item.i === this.getSelectedWidgetById.i &&
      this.item.type === "text"
    ) {
      this.calcContainerHeightByRow();
      this.onCheckUpdateSectionLayoutResized({
        sectionId: this.sectionId,
      });
    }
  },
  beforeUnmount() {
    this.editor.destroy();
  },
  destroyed() {
    console.log("destroyed");
    window.removeEventListener("click", () => {});
    window.removeEventListener("mouseup", () => {});
  },
};
</script>

<style scoped>
.label {
  border: none;
  outline: none;
  width: 100%;
  background: transparent !important;
}
.widget,
.d-flex {
  /* position: absolute; */
  width: 100%;
  height: 100%;
  /* contain: content;
  content-visibility: auto; */
}
.d-flex {
  display: flex;
}
</style>
