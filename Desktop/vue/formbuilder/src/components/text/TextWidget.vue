<template>
  <!-- @mouseover="hover = true" @mouseleave="hover = false" -->
  <div class="widget" @mousedown="onSelectedContent()" contenteditable="false">
    <!-- <SettingsWidget
      :show="item.i === getSelectedWidgetById.i"
      :item="item"
      :sectionId="sectionId"
    ></SettingsWidget> -->
    <!-- onHover(item.properties.elementHover), -->
    <!-- {{ item.i }} -->
    <template v-if="!displayEditor">
      <TextSetting
        :show="item.i === getSelectedWidgetById.i"
        :item="item"
        :sectionId="sectionId"
        @displayEditor="onDisplayEditor($event)"
      />
    </template>
    <template v-else>
      <TextSettingEditor
        :v-if="item.i === getSelectedWidgetById.i"
        @styles="onSelectedStyles($event)"
      />
    </template>
    <!-- 
      :style="[item.properties.style ? item.properties.style : style]"
     -->
    <div
      class="d-flex textarea"
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
    >
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
    </div>

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
export default {
  name: "TextWidget",
  components: {
    // SettingsWidget,
    TextSettingEditor,
    TextSetting,
  },
  data() {
    return {
      hover: false,
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
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  methods: {
    ...mapActions([
      "onSortSectionsLayout",
      "onTextHeight",
      "onCheckGridHeight",
      "onCheckUpdateSectionLayoutResized",
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
    },
    // document.getSelection().empty();
    onSelectedContent: function() {
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
    // Test
    execCommandStyle: async function(action, containers) {
      const selection = await getSelection();
      if (!selection) {
        return;
      }
      const anchorNode = selection.anchorNode;

      if (!anchorNode) {
        return;
      }
      const containert =
        anchorNode.nodeType !== Node.TEXT_NODE &&
        anchorNode.nodeType !== Node.COMMENT_NODE
          ? anchorNode
          : anchorNode.parentElement;
      // TODO: next chapter
      console.log(action, containers, containert);
    },
    getSelection: async function() {
      if (window && window.getSelection) {
        return window.getSelection();
      } else if (document && document.getSelection) {
        return document.getSelection();
      } else if (document && document.selection) {
        return document.selection.createRange().text;
      }

      return null;
    },
    updateSelection: async function(container, action, containers) {
      container.style[action.style] = await this.getStyleValue(
        container,
        action,
        containers
      );

      await this.cleanChildren(action, container);
    },
    getStyleValue: async function(container, action, containers) {
      if (!container) {
        return action.value;
      }

      if (await action.initial(container)) {
        return "initial";
      }

      const style = await this.findStyleNode(
        container,
        action.style,
        containers
      );

      if (await action.initial(style)) {
        return "initial";
      }

      return action.value;
    },
    findStyleNode: async function(node, style, containers) {
      // Just in case
      if (
        node.nodeName.toUpperCase() === "HTML" ||
        node.nodeName.toUpperCase() === "BODY"
      ) {
        return null;
      }

      if (!node.parentNode) {
        return null;
      }

      // if (DeckdeckgoInlineEditorUtils.isContainer(containers, node)) {
      //   return null;
      // }

      const hasStyle =
        node.style[style] !== null &&
        node.style[style] !== undefined &&
        node.style[style] !== "";

      if (hasStyle) {
        return node;
      }

      return await this.findStyleNode(node.parentNode, style, containers);
    },
    cleanChildren: async function(action, span) {
      if (!span.hasChildNodes()) {
        return;
      }

      // Clean direct (> *) children with same style
      const children = Array.from(span.children).filter((element) => {
        return (
          element.style[action.style] !== undefined &&
          element.style[action.style] !== ""
        );
      });

      if (children && children.length > 0) {
        children.forEach((element) => {
          element.style[action.style] = "";

          if (element.getAttribute("style") === "" || element.style === null) {
            element.removeAttribute("style");
          }
        });
      }

      // Direct children (> *) may have children (*) to be clean too
      const cleanChildrenChildren = Array.from(span.children).map((element) => {
        return this.cleanChildren(action, element);
      });

      if (!cleanChildrenChildren || cleanChildrenChildren.length <= 0) {
        return;
      }

      await Promise.all(cleanChildrenChildren);
    },
    replaceSelection: async function(container, action, selection, containers) {
      const range = selection.getRangeAt(0);

      const fragment = range.extractContents();

      const span = await this.createSpan(container, action, containers);
      span.appendChild(fragment);

      await this.cleanChildren(action, span);
      await this.flattenChildren(action, span);

      range.insertNode(span);
      selection.selectAllChildren(span);
    },
    createSpan: async function(container, action, containers) {
      const span = document.createElement("span");
      span.style[action.style] = await this.getStyleValue(
        container,
        action,
        containers
      );

      return span;
    },
    flattenChildren: async function(action, span) {
      if (!span.hasChildNodes()) {
        return;
      }

      // Flatten direct (> *) children with no style
      const children = Array.from(span.children).filter((element) => {
        const style = element.getAttribute("style");
        return !style || style === "";
      });

      if (children && children.length > 0) {
        children.forEach((element) => {
          const styledChildren = element.querySelectorAll("[style]");
          if (!styledChildren || styledChildren.length === 0) {
            const text = document.createTextNode(element.textContent);
            element.parentElement.replaceChild(text, element);
          }
        });

        return;
      }

      // Direct children (> *) may have children (*) to flatten too
      const flattenChildrenChildren = Array.from(span.children).map(
        (element) => {
          return this.flattenChildren(action, element);
        }
      );

      if (!flattenChildrenChildren || flattenChildrenChildren.length <= 0) {
        return;
      }

      await Promise.all(flattenChildrenChildren);
    },
  },
  watch: {
    getSelectedWidgetById: function(widget) {
      if (widget.type !== "text") this.displayEditor = false;
    },
    preventMove: function(value) {
      this.displayEditor = value;
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
    console.log(this.item.properties.text);
    if (this.item.properties.text === "Write your text here") {
      document.getElementById(this.item.i).innerHTML =
        // "<p>Write your text here</p>";
        `<p id="p">Example: <i>italic</i> and <b>bold</b></p>`;
    } else {
      document.getElementById(
        this.item.i
      ).innerHTML = this.item.properties.text;
    }
  },
  updated() {
    this.onTextHeight();
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
  /* -webkit-font-variant-ligatures: none;
  font-variant-ligatures: none; */
}
</style>
