<template>
  <v-container class="menu-design" fluid>
    <v-expansion-panels>
      <v-expansion-panel>
        <v-expansion-panel-header>Padding</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row>
            <v-col cols="12">
              <v-chip-group
                active-class="primary--text"
                column
                light
                v-model="device"
                @click="onSwitchDevice()"
              >
                <v-chip
                  v-for="(item, index) in devices"
                  :key="index"
                  color="primary"
                  outlined
                  pill
                >
                  <v-icon small>{{ item.icon }}</v-icon>
                </v-chip>
              </v-chip-group>
            </v-col>
          </v-row>
          <v-row>
            <!--<v-col cols="3"> 
                  <v-text-field
                type="number"
                label="PX"
                outlined
                v-model="paddingTop"
                hide-details
                dense
              ></v-text-field>
            </v-col>
            <v-col cols="3">
              <v-text-field
                type="number"
                outlined
                v-model="paddingBottom"
                hide-details
                dense
                label="PX"
              ></v-text-field>
            </v-col> -->
            <template v-if="device === 0">
              <v-col cols="6">
                <v-text-field
                  type="number"
                  outlined
                  v-model="paddingWebLeft"
                  hide-details
                  dense
                  label="PX"
                  min="0"
                  max="200"
                ></v-text-field>
              </v-col>
              <v-col cols="6">
                <v-text-field
                  type="number"
                  outlined
                  v-model="paddingWebRight"
                  hide-details
                  dense
                  label="PX"
                  min="0"
                  max="200"
                ></v-text-field>
              </v-col>
            </template>
            <template v-else>
              <v-col cols="6">
                <v-text-field
                  type="number"
                  outlined
                  v-model="paddingMobileLeft"
                  hide-details
                  dense
                  label="PX"
                ></v-text-field>
              </v-col>
              <v-col cols="6">
                <v-text-field
                  type="number"
                  outlined
                  v-model="paddingMobileRight"
                  hide-details
                  dense
                  label="PX"
                ></v-text-field>
              </v-col>
            </template>
            <!-- <v-col align-self="center" cols="3">
              <h2 class="body-1 font-weight-medium text-center">
                Top
              </h2>
            </v-col>
            <v-col align-self="center" cols="3">
              <h2 class="body-1 font-weight-medium text-center">
                Bottom
              </h2>
            </v-col> -->
            <v-col align-self="center" cols="6">
              <h2 class="body-1 font-weight-medium text-center">
                Left
              </h2>
            </v-col>
            <v-col align-self="center" cols="6">
              <h2 class="body-1 font-weight-medium text-center">
                Right
              </h2>
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </v-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import StylesTransform from "../../mixins/styles";
export default {
  name: "SectionDesign",
  mixins: [StylesTransform],
  components: {},
  data() {
    return {
      // panel: 0,
      paddingTop: 0,
      paddingBottom: 0,
      paddingWebRight: 0,
      paddingWebLeft: 0,
      paddingMobileRight: 10,
      paddingMobileLeft: 10,
      device: 0,
      web: null,
      mobile: null,
      devices: [
        { id: 1, value: "web", icon: "mdi-monitor" },
        { id: 2, value: "mobile", icon: "mdi-cellphone-android" },
      ],
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getScreenSize"]),
  },
  methods: {
    ...mapActions(["onResizeSectionScreen"]),
    mediaDevices: function() {
      let styles;
      switch (this.device) {
        //   Web
        case 0:
          this.onResizeSectionScreen({
            width: "100%",
            responsive: false,
            cols: 24,
            screen: "web",
          });
          this.web = {
            paddingLeft: this.paddingWebLeft + "px",
            paddingRight: this.paddingWebRight + "px",
          };
          break;
        //   Mobile
        case 1:
          this.onResizeSectionScreen({
            width: "379px",
            responsive: true,
            cols: 2,
            screen: "mobile",
          });
          this.mobile = {
            paddingLeft: this.paddingMobileLeft + "px",
            paddingRight: this.paddingMobileRight + "px",
          };
          break;
      }
      styles = {
        web: this.web,
        mobile: this.mobile,
      };
      return styles;
    },
    onSwitchDevice: function() {
      //   console.log(this.device);
      switch (this.device) {
        //   Web
        case 0:
          if (this.web === null) {
            this.paddingWebLeft = 0;
            this.paddingWebRight = 0;
          }
          if (this.web !== null) {
            this.paddingWebLeft = this.convertPxToNumber(this.web.paddingLeft);
            this.paddingWebRight = this.convertPxToNumber(
              this.web.paddingRight
            );
          }
          break;
        //   Mobile
        case 1:
          if (this.mobile === null) {
            this.paddingMobileLeft = 0;
            this.paddingMobileRight = 0;
          }
          if (this.mobile !== null) {
            this.paddingMobileLeft = this.convertPxToNumber(
              this.mobile.paddingLeft
            );
            this.paddingMobileRight = this.convertPxToNumber(
              this.mobile.paddingRight
            );
          }
          break;
      }
    },
  },
  created() {
    if (this.getScreenSize.screen === "web") this.device = 0;

    if (this.getScreenSize.screen === "mobile") this.device = 1;

    if (this.getSelectedWidgetById.properties.style.design.web) {
      //     if (this.getSelectedWidgetById.properties.style.design.web.paddingLeft)
      //       this.style.web.paddingLeft = this.paddingLeft = this.convertPxToNumber(
      //         this.getSelectedWidgetById.properties.style.design.web.paddingLeft
      //       );

      //     if (this.getSelectedWidgetById.properties.style.design.web.paddingRight)
      //       this.style.web.paddingRight = this.paddingRight = this.convertPxToNumber(
      //         this.getSelectedWidgetById.properties.style.design.web.paddingRight
      //       );
      if (this.getSelectedWidgetById.properties.style.design.web.paddingLeft)
        if (
          typeof this.getSelectedWidgetById.properties.style.design.web
            .paddingLeft === "string"
        )
          this.paddingWebLeft = this.convertPxToNumber(
            this.getSelectedWidgetById.properties.style.design.web.paddingLeft
          );
        else
          this.paddingWebLeft = this.getSelectedWidgetById.properties.style.design.web.paddingLeft;

      if (this.getSelectedWidgetById.properties.style.design.web.paddingRight)
        if (
          typeof this.getSelectedWidgetById.properties.style.design.web
            .paddingRight === "string"
        )
          this.paddingWebRight = this.convertPxToNumber(
            this.getSelectedWidgetById.properties.style.design.web.paddingRight
          );
        else
          this.paddingWebRight = this.getSelectedWidgetById.properties.style.design.web.paddingRight;

      this.web = {
        paddingLeft: this.paddingWebLeft,
        paddingRight: this.paddingWebRight,
      };
    }

    if (this.getSelectedWidgetById.properties.style.design.mobile) {
      if (this.getSelectedWidgetById.properties.style.design.mobile.paddingLeft)
        if (
          typeof this.getSelectedWidgetById.properties.style.design.mobile
            .paddingLeft === "string"
        )
          this.paddingMobileLeft = this.convertPxToNumber(
            this.getSelectedWidgetById.properties.style.design.mobile
              .paddingLeft
          );
        else
          this.paddingMobileLeft = this.getSelectedWidgetById.properties.style.design.mobile.paddingLeft;

      if (
        this.getSelectedWidgetById.properties.style.design.mobile.paddingRight
      )
        if (
          typeof this.getSelectedWidgetById.properties.style.design.mobile
            .paddingRight === "string"
        )
          this.paddingMobileRight = this.convertPxToNumber(
            this.getSelectedWidgetById.properties.style.design.mobile
              .paddingRight
          );
        else
          this.paddingMobileRight = this.getSelectedWidgetById.properties.style.design.mobile.paddingRight;

      this.mobile = {
        paddingLeft: this.paddingMobileLeft,
        paddingRight: this.paddingMobileRight,
      };
    }
  },
  updated() {
    this.getSelectedWidgetById.properties.style.design = this.mediaDevices();
  },
};
</script>

<style scoped></style>
