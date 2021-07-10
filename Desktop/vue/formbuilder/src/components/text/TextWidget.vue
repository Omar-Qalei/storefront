<template>
  <!-- @mouseover="hover = true" @mouseleave="hover = false" -->
  <div class="widget">
    <SettingsWidget
      :show="item.i === getSelectedWidgetById.i"
      :item="item"
      :sectionId="sectionId"
    ></SettingsWidget>
    <!-- onHover(item.properties.elementHover), -->
    <div
      class="d-flex"
      :style="[item.properties.style ? item.properties.style : style]"
    >
      <textarea
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
      ></textarea>
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
      <!-- <v-textarea
          @keydown="calcHeight"
          @keydown.enter="calcHeight('enter')"
          v-model="item.properties.name"
          color="grey"
          flat
          auto-grow
          solo
          id="text"
          hide-details
          rows="1"
        ></v-textarea> -->
    </div>
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters, mapActions } from "vuex";
export default {
  name: "TextWidget",
  components: {
    SettingsWidget,
  },
  data() {
    return {
      hover: false,
      style: {},
    };
  },
  props: {
    item: {},
    sectionId: Number,
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
  },
  created() {
    if (this.item.properties.style === null) {
      this.style = {
        fontSize: "56px",
      };
    }
  },
  updated() {
    this.onTextHeight();
    // this.calcHeight();
    // this.item = this.getSelectedWidgetById;
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
</style>
