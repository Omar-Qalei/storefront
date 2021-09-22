<template>
  <!-- @mouseover="hover = true" @mouseleave="hover = false" -->
  <div class="widget" contenteditable="false">
    <!-- <SettingsWidget
      :show="item.i === getSelectedWidgetById.i"
      :item="item"
      :sectionId="sectionId"
    ></SettingsWidget> -->
    <!-- onHover(item.properties.elementHover), -->
    <!-- {{ item.i }} -->
    <template v-if="editor && !displayEditor">
      <TextSetting
        :show="item.i === getSelectedWidgetById.i"
        :item="item"
        :sectionId="sectionId"
        @displayEditor="onDisplayEditor($event)"
      />
    </template>
    <!-- @styles="onSelectedStyles($event)" -->
    <template v-else>
      <TextSettingEditor
        v-if="item.i === getSelectedWidgetById.i"
        :editor="editor"
        @onChangeFontSize="onChangeFontSize($event)"
        @onChangeFontFamily="onChangeFontFamily($event)"
        @onChangeFontColor="onChangeFontColor($event)"
        @onChangeFontBold="onChangeFontBold($event)"
        @onChangeFontStyle="onChangeFontStyle($event)"
        @onChangeFontUnderline="onChangeFontUnderline($event)"
        @onChangeFontTransform="onChangeFontTransform($event)"
        @onChangeTextAlignment="onChangeTextAlignment($event)"
      />
    </template>
    <!-- 
      :style="[item.properties.style ? item.properties.style : style]"
     -->
    <!-- Test -->
    <div>
      <!-- <menu-bar class="editor__header" :editor="editor" /> -->
      <editor-content :id="item.i" :editor="editor" />
    </div>
    <!-- Test -->
    <!-- <div
      class="d-flex textarea unselectable"
      contenteditable="true"
      :id="item.i"
      @input="onInput"
      @keydown="onTextHeight()"
      @keyup="
        onCheckGridHeight();
        onCheckUpdateSectionLayoutResized({
          sectionId: sectionId,
        });
      "
      :style="{ textAlign: styles.textAlign }"
      unselectable="on"
      @mouseleave="status = true"
      @mouseover="status = false"
    > -->
    <!-- 
      @input="onInput"
      @keydown="onTextHeight;"
      @keyup="
        onCheckUpdateSectionLayoutResized({
          sectionId: sectionId,
        })
      "
     -->
    <!-- <p>{{ item.properties.text }}</p> -->
    <!-- <span v-for="text in this.greetText">
      <span> {{ text }} </span>
    </span> -->
    <!-- </div> -->

    <!-- <div
      class="d-flex"
    > -->
    <!-- <textarea
      :style="[item.properties.style ? item.properties.style : style]"
      class="label"
      v-model="item.properties.text"
      contenteditable="true"
      :id="item.i"
      @keydown="onTextHeight;"
      @keyup="
        onCheckUpdateSectionLayoutResized({
          sectionId: sectionId,
        })
      "
    ></textarea> -->
    <!-- <v-textarea
        :style="[item.properties.style ? item.properties.style : style]"
        color="grey"
        flat
        auto-grow
        solo
        hide-details
        rows="1"
        v-model="item.properties.text"
        contenteditable="true"
        :id="item.i"
        @keydown="onTextHeight;"
        @keyup="
          onCheckUpdateSectionLayoutResized({
            sectionId: sectionId,
          })
        "
      ></v-textarea> -->
  </div>
</template>

<script>
// import SettingsWidget from "../settings/SettingsWidget";
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
    onHover: function(elementHover) {
      if (this.hover) {
        if (elementHover !== undefined) {
          return elementHover;
        }
      } else {
        return "";
      }
    },
    calcHeight: function() {
      // let height = document.getElementById("text").scrollHeight;
      // document.getElementById("text").style.height = height + "px";
      // let h = height / 30;
      // let value = this.item.properties.name;
      // let numberOfLineBreaks = (value.match(/\n/g) || []).length;
      // let newHeight = 20 + numberOfLineBreaks * 20 + 12 + 2;
      // h = Math.ceil(h);
      // // console.log(newHeight / 30, h);
      // if (h % 2 !== 0) {
      //   h = h + 1;
      // }
      // console.log(h);
      // if (this.getSelectedWidgetById.h <= h) {
      //   this.getSelectedWidgetById.h = h;
      //   this.onSortSectionsLayout();
      // }
      // if (event === "enter") {
      //   this.item.h += 2;
      // }
      // if (numberOfLineBreaks > 0) {
      //   let newHeight = 20 + numberOfLineBreaks * 20 + 12 + 2;
      //   if (numberOfLineBreaks % 2 !== 0) {
      //     numberOfLineBreaks = numberOfLineBreaks + 1;
      //   }
      //   this.item.h = numberOfLineBreaks;
      // }
    },
    onInput: function(e) {
      this.item.properties.text = e.target.innerHTML;
      console.log(this.item.properties.text);
    },
    onKeyEnter: function() {
      document.execCommand("defaultParagraphSeparator", false, "p");
    },
    onKeyUp: function() {
      // if (e.key === "Backspace" || e.key === "Delete") {
      //   if (e.target.innerText.length === 0)
      //     document.execCommand("insertHTML", false, "<p> </p>");
      // }
      // console.log("onKeyUp", e.target.innerText.length);
      // if (e.target.innerText.length === 0)
      //   document.execCommand(
      //     "insertHTML",
      //     false,
      //     "<p>" + e.target.innerText + " </p>"
      //   );
    },
    onKeyDown: function() {
      // if (e.key === "Backspace" || e.key === "Delete") {
      //   if (e.target.innerText.length === 0)
      //     document.execCommand("insertHTML", false, "<p> </p>");
      // }
      // console.log("onKeyDown", e.target.innerText.length);
      // if (e.target.innerText.length === 0)
      //   document.execCommand(
      //     "insertHTML",
      //     false,
      //     "<p>" + e.target.innerText + " </p>"
      //   );
    },
    onDisplayEditor: function(event) {
      this.displayEditor = event;
      this.$emit("onPreventMove", event);
    },
    onSelectedStyles: function(event) {
      this.styles = event;
      this.onSelectedContent();
      console.log(event);
    },
    getSelection: async function() {
      if (window && window.getSelection) {
        return window.getSelection();
      } else if (document && document.getSelection) {
        return document.getSelection();
      } else if (document && document.selection) {
        return document.selection.createRange().text;
      }

      return undefined;
    },
    onChangeFontSize: function(style) {
      var fontElements = getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          document.execCommand("styleWithCSS", false, true);
          // document.execCommand("formatblock", false, "span");
          // fontElements = fontElements.anchorNode.parentNode;
          document.execCommand("fontSize", false, 7);
          var listId = window.getSelection().focusNode.parentNode;
          // fontElements.removeAttribute("size");
          listId.style.fontSize = "inherit";
          listId.className = style.fontSize;
        }
    },
    onChangeFontFamily: function(style) {
      var fontElements = getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          document.execCommand("styleWithCSS", false, true);
          document.execCommand("fontName", false, style.fontFamily);
        }
    },
    onChangeFontColor: function(style) {
      var fontElements = getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          fontElements = fontElements.anchorNode.parentNode;
          document.execCommand("styleWithCSS", false, true);
          document.execCommand("foreColor", false, style.color);
          // fontElements.removeAttribute("color");
          // fontElements.style.color = style.color;
        }
    },
    onChangeFontBold: function() {
      var fontElements = getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          if (this.styles.fontWeight === "" && fontElementsStatus) {
            document.execCommand("bold", false, true);
          }
          if (this.styles.fontWeight !== "" && fontElementsStatus) {
            document.execCommand("bold", false, false);
          }
        }
    },
    onChangeFontStyle: function() {
      var fontElements = getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          if (this.styles.fontStyle === "" && fontElementsStatus) {
            document.execCommand("italic", false, true);
          }
          if (this.styles.fontStyle !== "" && fontElementsStatus) {
            document.execCommand("italic", false, false);
          }
        }
    },
    onChangeFontUnderline: function() {
      var fontElements = getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          if (this.styles.textDecoration === "" && fontElementsStatus) {
            document.execCommand("underline", false, true);
          }
          if (this.styles.textDecoration !== "" && fontElementsStatus) {
            document.execCommand("underline", false, false);
          }
        }
    },
    onChangeFontTransform: function() {
      var fontElements = getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          if (this.styles.fontWeight === "" && fontElementsStatus) {
            document.execCommand("bold", false, true);
          }
          if (this.styles.fontWeight !== "" && fontElementsStatus) {
            document.execCommand("bold", false, false);
          }
        }
    },
    onChangeTextAlignment: function(style) {
      this.styles.textAlign = style.textAlign;
    },
    onSelectedContent: function() {
      // var fontElements = window.getSelection().anchorNode.parentNode;
      var fontElements = getSelection();
      var fontElementsStatus = fontElements.toString().length > 0;
      if (fontElementsStatus)
        if (fontElements && fontElements.anchorNode) {
          fontElements = fontElements.anchorNode.parentNode;
          document.execCommand("fontSize", false, 7);
          fontElements.removeAttribute("size");
          fontElements.style.fontSize = this.styles.fontSize;
        }

      if (this.styles.fontStyle === "" && fontElementsStatus) {
        document.execCommand("italic", false, true);
      }
      if (this.styles.fontStyle !== "" && fontElementsStatus) {
        document.execCommand("italic", false, false);
      }

      if (this.styles.textDecoration === "" && fontElementsStatus) {
        document.execCommand("underline", false, true);
      }
      if (this.styles.textDecoration !== "" && fontElementsStatus) {
        document.execCommand("underline", false, false);
      }

      // console.log(document.getSelection().);
      // document.getSelection().empty();
      // const p = document.querySelector("p");
      //     document.onselectionchange = function() {
      //   let selection = document.getSelection();
      //   let {anchorNode, anchorOffset, focusNode, focusOffset} = selection;
      //   // anchorNode and focusNode are text nodes usually
      //   console.log( `${anchorNode?.data}, offset ${anchorOffset}`, '///', `${focusNode?.data}, offset ${focusOffset}`)
      // };
      // let range = new Range();
      // range.setStart(p.firstChild, 2);
      // range.setEnd(p.querySelector("b").firstChild, 3);
      // console.log(range);
      // document.getSelection().removeAllRanges();
      // document.getSelection().addRange(range);
      // window.getSelection().addRange(range);
      // var sel = window.getSelection();
      // if (sel.rangeCount > 0) {
      //   var range = sel.getRangeAt(0);
      //   var newSpan = document.createElement("span");
      //   var selectedTextNode = document.createTextNode(range.toString());
      //   newSpan.appendChild(selectedTextNode);
      //   newSpan.style.background = "blue";
      //   range.deleteContents();
      //   range.insertNode(newSpan);
      //   range.selectNode(newSpan);
      //   sel.removeAllRanges();
      //   sel.addRange(range);
      // }
      // document.getSelection().empty();
      // var staticRanges =
      //   window.InputEvent &&
      //   typeof InputEvent.prototype.getTargetRanges === "function";
      // const editableElem = document.querySelector('[contenteditable="true"]');
      // editableElem.addEventListener("beforeinput", (e) => {
      //   const targetRanges = e.getTargetRanges();
      //   console.log(targetRanges);
      // });
      // const dataTransfer = new DataTransfer();
      // console.log("hello", dataTransfer);
      // dataTransfer.setData("text/css", "#295cf4");
      // document.querySelector('[contenteditable="true"]');
      // document.querySelector('[contenteditable="true"]').dispatchEvent(
      //   new ClipboardEvent("formatFontColor", {
      //     clipboardData: dataTransfer,
      //     // need these for the event to reach Draft paste handler
      //     bubbles: true,
      //     cancelable: true,
      //   })
      // );
      // const range = document.selection.createRange();
      // const text = range.extractContents();
      // var span = document.createElement("span");
      // span.appendChild(text);
      // console.log(range);
      // if (document.getSelection) {
      //   // all browsers, except IE before version 9
      //   // var sel = document.getSelection();
      //   // sel is a string in Firefox and Opera,
      //   // and a selectionRange object in Google Chrome, Safari and IE from version 9
      //   // the alert method displays the result of the toString method of the passed object
      //   const text = document.getSelection();
      //   var span = document.createElement("span");
      //   span.append(text);
      //   console.log(span);
      // } else {
      //   if (document.selection) {
      //     // Internet Explorer before version 9
      //     var textRange = document.selection.createRange();
      //     console.log(textRange.text);
      //   }
      // }
      // const replacementText = "Hello World";
      // if (window.getSelection) {
      //   // not IE case
      //   var selObj = window.getSelection();
      //   var selRange = selObj.getRangeAt(0);
      //   var newElement = document.createElement("b");
      //   var documentFragment = selRange.extractContents();
      //   newElement.appendChild(documentFragment);
      //   selRange.insertNode(newElement);
      //   selObj.removeAllRanges();
      // } else if (
      //   document.selection &&
      //   document.selection.createRange &&
      //   document.selection.type != "None"
      // ) {
      //   // IE case
      //   var range = document.selection.createRange();
      //   var selectedText = range.htmlText;
      //   var newText = "<b>" + selectedText + "</b>";
      //   document.selection.createRange().pasteHTML(newText);
      // }
      // clear DataTransfer Data
      // dataTransfer.clearData();
      // document.execCommand("styleWithCSS", false, true);
      // console.log(this.styles.fontSize);
      // let range = new Range();
      // range.setStart(document.querySelector("#" + this.item.i).firstChild, 2);
      // range.setEnd(document.querySelector("#" + this.item.i).firstChild, 4);
      // console.log(range);
      // if (window.getSelection().rangeCount > 0) {
      // var fontElements = window.getSelection().anchorNode.parentNode;
      // document.execCommand("fontSize", false, 7);
      // fontElements.removeAttribute("size");
      // fontElements.style.fontSize = this.styles.fontSize;
      // fontElements.style.color = this.styles.color;
      // fontElements.style.textAlign = this.styles.textAlign;
      // fontElements.style.fontWeight = this.styles.fontWeight;
      // fontElements.style.fontStyle = this.styles.fontStyle;
      // fontElements.style.textDecoration = this.styles.textDecoration;
      //   // console.log(
      //   //   window.getSelection().getRangeAt(0).endContainer.parentNode
      //   // );
      //   // document.getElementById('').designMode = "on";
      //   document.execCommand("styleWithCSS", false, true);
      // document.execCommand("bold", false, "900");
      //   // make selection italic
      // document.execCommand("italic", false, this.styles.fontStyle);
      //   // make selection underlined
      // document.execCommand("underline", false, this.styles.textDecoration);
      // document.getSelection().empty();
      // let h1 = document.createElement("h1");
      // this.execCommandStyle("underline", "blue");
      // this.updateSelection({ initial: () => h1 }, "font-size", "50px");
      //   // set selection's font size to 4
      //   // // surround selection's with <h3> tags
      //   // document.execCommand("heading", false, "H3");
      //   // // change selection to subscript
      //   // document.execCommand("subscript", false, "");
      //   // // change selection to superscript
      // document.execCommand("superscript", false, "");
      //   // change selection's font to Arial
      //   // document.execCommand("fontName", false, this.styles.fontFamily);
      // document.execCommand("foreColor", false, this.styles.color);
      //   // document.execCommand("createLink", true, "http://www.google.com");
      // }
    },
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
    // const x = window.getSelection();
    // if (x.toString().length) {
    //   console.log(x.getRangeAt(0).commonAncestorContainer.parentNode.nodeName);
    //   console.log(
    //     x.getRangeAt(0).commonAncestorContainer.parentNode.childNodes.forEach(element => {
    //       element.nodeType
    //     })
    //   );
    // }

    // this.calcHeight();
    // this.item = this.getSelectedWidgetById;
    // var text = "";

    // if (window.getSelection().rangeCount > 0) {
    //   const nodeName = window.getSelection().getRangeAt(0).endContainer
    //     .parentNode.nodeName;
    //   if (nodeName.toLowerCase().trim() === "div".toLowerCase().trim()) {
    //     const child = window.getSelection().getRangeAt(0).endContainer
    //       .parentNode.childNodes[0].nodeName;
    //     if (child === "#comment" || child === "#text") {
    //       console.log(
    //         window.getSelection().getRangeAt(0).endContainer.parentNode
    //       );
    //       const textContent = window.getSelection().getRangeAt(0).endContainer
    //         .parentNode.textContent;
    //       var span = document.createElement("span");
    //       span.innerHTML = textContent;
    //       span.style.color = this.styles.color;
    //       console.log(span, this.styles);
    //       window
    //         .getSelection()
    //         .getRangeAt(0)
    //         .endContainer.parentNode.childNodes[0].remove();
    //       window
    //         .getSelection()
    //         .getRangeAt(0)
    //         .endContainer.parentNode.append(span);
    //     }
    //     // var span = document.createElement("span");
    //     // var content = window.getSelection().getRangeAt(0).endContainer
    //     //   .parentNode.replaceChild();
    //     // span.style = this.styles;
    //     // span.appendChild(content);
    //     // console.log(span);
    //     // window
    //     //   .getSelection()
    //     //   .getRangeAt(0)
    //     //   .endContainer.parentNode.removeChild(span);
    //     // window
    //     //   .getSelection()
    //     //   .getRangeAt(0)
    //     //   .endContainer.parentNode.append(span);
    //   }
    //   // console.log(
    //   //   window.getSelection().getRangeAt(0).endContainer.parentNode.
    //   // );
    //   // window
    //   //   .getSelection()
    //   //   .getRangeAt(0).endContainer.parentNode.style.color = this.styles.color;
    //   // var text = window.getSelection();
    //   // For diagnostics
    //   // var start = text.anchorOffset;
    //   // var end = text.focusOffset - text.anchorOffset;
    //   // var range = window.getSelection().getRangeAt(0);
    //   // var selectionContents = range.extractContents();
    //   // var span = document.createElement("span");
    //   // span.appendChild(selectionContents);
    //   // // span.style = this.styles;
    //   // span.style.color = this.styles.color;
    //   // range.insertNode(span);
    // }
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
