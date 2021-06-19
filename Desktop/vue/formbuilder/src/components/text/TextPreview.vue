<template>
  <div class="widget" @mouseover="hover = true" @mouseleave="hover = false">
    <div
      class="d-flex"
      :style="[
        item.properties.style ? item.properties.style : style,
        onHover(item.properties.elementHover),
      ]"
    >
      <textarea
        class="label"
        v-model="item.properties.text"
        contenteditable="true"
        :id="item.i"
        disabled="true"
      ></textarea>
    </div>
  </div>
</template>

<script>
export default {
  name: "TextPreview",
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
  methods: {
    onHover: function(elementHover) {
      if (this.hover) {
        if (elementHover !== undefined) {
          return elementHover;
        }
      } else {
        return "";
      }
    },
  },
  created() {
    if (this.item.properties.style === null) {
      this.style = {
        fontSize: "56px",
      };
    }
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
}
</style>
