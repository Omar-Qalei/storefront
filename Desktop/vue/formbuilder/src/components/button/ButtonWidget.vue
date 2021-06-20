<template>
  <div class="widget" @mouseover="hover = true" @mouseleave="hover = false">
    <!--  x: {{ item.x }} y: {{ item.y }} -->
    <SettingsWidget
      :show="item.i === getSelectedWidgetById.i"
      :item="item"
      :sectionId="sectionId"
    ></SettingsWidget>
    <!-- <template v-if="selectedLinkTo === null"> -->
    <v-btn
      class="draggable"
      draggable="true"
      unselectable="on"
      :style="[
        item.properties.style ? item.properties.style : style,
        onHover(item.properties.elementHover),
      ]"
      :id="item.i + 'button'"
    >
      {{ item.properties.name }}
    </v-btn>
    <!-- </template> -->

    <!-- <template v-if="selectedLinkTo && selectedLinkTo === 0">
      <v-btn
        class="draggable"
        draggable="true"
        unselectable="on"
        :to="'/' + getSelectedWidgetById.properties.page"
        :style="[item.properties.style ? item.properties.style : '', onHover()]"
        :id="item.i + 'button'"
      >
        {{ item.properties.name }}
      </v-btn>
    </template>

    <template v-if="selectedLinkTo && selectedLinkTo === 1">
      <v-btn
        class="draggable"
        draggable="true"
        unselectable="on"
        :to="'/' + getSelectedWidgetById.properties.page"
        :style="[item.properties.style ? item.properties.style : '', onHover()]"
        :id="item.i + 'button'"
        @click="goTo"
      >
        {{ item.properties.name }}
      </v-btn>
    </template>

    <template v-if="selectedLinkTo && selectedLinkTo === 2">
      <v-btn
        class="draggable"
        draggable="true"
        unselectable="on"
        :to="'/' + getSelectedWidgetById.properties.page"
        :style="[item.properties.style ? item.properties.style : '', onHover()]"
        :id="item.i + 'button'"
        @click="onCall"
      >
        {{ item.properties.name }}
      </v-btn>
    </template>

    <template v-if="selectedLinkTo && selectedLinkTo === 3">
      <v-btn
        class="draggable"
        draggable="true"
        unselectable="on"
        :to="'/' + getSelectedWidgetById.properties.page"
        :style="[item.properties.style ? item.properties.style : '', onHover()]"
        :id="item.i + 'button'"
        @click="onEmail"
      >
        {{ item.properties.name }}
      </v-btn>
    </template> -->
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
// mapActions,
import { mapGetters } from "vuex";
export default {
  name: "ButtonWidget",
  components: {
    SettingsWidget,
  },
  data() {
    return {
      hover: false,
      selectedLinkTo: null,
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
    onHover: function(elementHover) {
      if (this.hover) {
        if (elementHover !== undefined) {
          return elementHover;
        }
      } else {
        return "";
      }
    },
    goTo: function() {
      let url = this.getSelectedWidgetById.properties.selectedLinkTo.url;
      let newTab = this.getSelectedWidgetById.properties.selectedLinkTo.newTab;
      if (newTab) {
        window.open(url, "_blank");
      } else {
        window.open(url, "_self");
      }
    },
    onCall: function() {
      let phone = this.getSelectedWidgetById.properties.selectedLinkTo.phone;
      if (phone) {
        window.open("tel:" + phone);
      }
    },
    onEmail: function() {
      let email = this.getSelectedWidgetById.properties.selectedLinkTo.email;
      if (email) {
        window.location.href = "mailto:" + email;
      }
    },
  },
  created() {
    if (this.item.properties.style === null) {
      this.style = {
        justifyContent: "center",
        alignItems: "center",
        borderRadius: "30px",
        color: "#FFFFFFFF",
        backgroundColor: "#4E00BBFF",
      };
    }
  },
  updated() {
    if (this.getSelectedWidgetById.properties?.selectedLinkTo) {
      this.selectedLinkTo = this.getSelectedWidgetById.properties.selectedLinkTo;
    }
  },
};
</script>

<style scoped>
.v-btn {
  position: absolute !important;
  display: block !important;
  z-index: -1 !important;
  width: 100% !important;
  height: 100% !important;
}
.widget {
  position: absolute;
  width: 100%;
  height: 100%;
}
.widget ::v-deep.v-btn {
  text-transform: inherit;
}
.widget .v-btn ::v-deep.v-btn__content {
  align-items: inherit;
  height: 100%;
}
</style>
