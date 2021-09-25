<template>
  <div class="widget" contenteditable="false">
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
    <div>
      <!-- <menu-bar class="editor__header" :editor="editor" /> -->
      <editor-content :id="item.i" :editor="editor" />
    </div>
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
import AddClass from "./extensions/extension-add-class";
import { Color } from "@tiptap/extension-color";
import Underline from "@tiptap/extension-underline";
import Link from "@tiptap/extension-link";
// import styles from "../../mixins/styles";

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
      containers: "p, span",
      style: {
        textAlign: "",
        fontWeight: "",
        fontStyle: "",
        textDecoration: "",
        color: "black",
        textTransform: "",
        // fontSize: "56px",
      },
      displayEditor: false,
      styles: {
        textAlign: "",
        fontWeight: "",
        fontStyle: "",
        textDecoration: "",
        color: "black",
        textTransform: "",
        fontSize: "",
      },
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
    // getScreenSize: function(event) {
    //   if(event.screen) {

    //   }
    // }
  },
  methods: {
    ...mapActions([
      "onSortSectionsLayout",
      "onTextHeight",
      "onCheckGridHeight",
      "onCheckUpdateSectionLayoutResized",
      "onHistoryPages",
    ]),
  },
  created() {
    if (this.item.properties.style === null) {
      this.style = {
        // fontSize: "48px",
      };
    }
  },
  mounted() {
    this.editor = new Editor({
      extensions: [
        StarterKit,
        TextStyle,
        FontFamily,
        Color,
        AddClass,
        Underline,
        Link,
      ],
      // content: `
      //   Write your text here
      // `,
      content: `
        
      `,
    });

    // console.log(this.item.properties.text);
    if (this.item.properties.text === "Write your text here") {
      this.editor.commands.setContent(
        `<h2 style="font-size:64px" >Hi there,</h2><p><span class="h6">this is a </span><em><span class="h6">basic</span></em><span class="h6"> example of </span><strong><span class="h6">tiptap</span></strong><span class="h6">. Sure, there are all kind of basic text styles you’d probably expect from a t</span><span class="h1">ext editor. But wait unti</span><span class="h6">l you see the lists:</span></p><ul><li><p>… or two list items.</p></li></ul><p>Isn’t that great? And all of that is editable. But wait, there’s more. Let’s try a code block:</p><pre><code class="language-css">body {\n  display: none;\n}</code></pre><p>I know, I know, this is impressive. It’s only the tip of the iceberg though. Give it a try and click a little That’s a bullet list with one …</p><ul><li><p>bit around. Don’t forget to check the other examples too.</p></li></ul><blockquote><p>Wow, that’s amazing. Good work, boy! 👏 <br>— Mom</p></blockquote>'`
      );
      // this.editor.value.commands.setContent(
      //   `<h2>Hi there,</h2><p><span class="h6">this is a </span><em><span class="h6">basic</span></em><span class="h6"> example of </span><strong><span class="h6">tiptap</span></strong><span class="h6">. Sure, there are all kind of basic text styles you’d probably expect from a t</span><span class="h1">ext editor. But wait unti</span><span class="h6">l you see the lists:</span></p><ul><li><p>… or two list items.</p></li></ul><p>Isn’t that great? And all of that is editable. But wait, there’s more. Let’s try a code block:</p><pre><code class="language-css">body {\n  display: none;\n}</code></pre><p>I know, I know, this is impressive. It’s only the tip of the iceberg though. Give it a try and click a little That’s a bullet list with one …</p><ul><li><p>bit around. Don’t forget to check the other examples too.</p></li></ul><blockquote><p>Wow, that’s amazing. Good work, boy! 👏 <br>— Mom</p></blockquote>'`
      // );
      // document.getElementById(
      //   this.item.i
      // ).innerHTML = `<h3>Write your text here</h3>`;
      // this.editor.commands.setContent({
      //   type: "doc",
      //   content: [
      //     {
      //       type: "paragraph",
      //       content: [
      //         {
      //           type: "text",
      //           text: "Example Text",
      //         },
      //       ],
      //     },
      //   ],
      // });
      // this.editor.commands.setContent("<p class='h3'>Write your text here</p>");
    } else {
      // this.editor.setContent(this.item.properties.text);
      // document.getElementById(
      //   this.item.i
      // ).innerHTML = this.item.properties.text;
    }
    const thiz = this;
    window.addEventListener("click", () => {
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
    });
    // document
    //   .getElementById(this.item.i)
    //   .addEventListener("compositionupdate", () => {
    //     console.log("checked");
    //   });
  },
  beforeUnmount() {
    this.editor.destroy();
  },
  updated() {
    console.log(this.editor.getJSON(), this.editor.getHTML());
    this.onTextHeight();
  },
  destroyed() {
    console.log("destroyed");
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
}
.d-flex {
  display: flex;
}
h3 {
  font-size: 48px;
}
textarea {
  color: inherit;
  text-decoration: inherit;
  text-transform: inherit;
  text-align: inherit;
  font-size: inherit;
  resize: none;
  overflow: hidden;
  background-color: inherit;
  height: 100%;
  min-height: 100%;
}
.textarea {
  /* color: inherit;
  text-decoration: inherit;
  text-transform: inherit;
  text-align: inherit;
  font-size: inherit;
  resize: none;
  box-shadow: none;
  outline: none;
  overflow: hidden;
  background-color: inherit; */
  /* height: 100%;
  min-height: 100%; */
  box-sizing: border-box;
  width: 100%;
  height: 100%;
  max-height: 100%;
  flex-flow: column;
  outline: none;
  box-shadow: none;
  /* -webkit-font-variant-ligatures: none;
  font-variant-ligatures: none; */
}
.v-application a {
  text-decoration: none !important;
}
::v-deep .v-application a {
  color: inherit !important;
}
</style>
