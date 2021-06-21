<template>
  <div>
    <div class="d-flex settings">
      <v-navigation-drawer
        height="100%"
        v-model="drawer"
        :permanent="drawer"
        right
        app
        clipped
      >
        <!-- <v-list-item class="px-2">
          <v-list-item-title>Add Element</v-list-item-title>
        </v-list-item>

        <v-divider></v-divider> -->
        <v-row class="justify-space-around mt-4 mx-2">
          <v-col cols="6">
            <Carousel />
          </v-col>
          <v-col cols="6">
            <Button />
          </v-col>
          <v-col cols="6">
            <TextView />
          </v-col>
          <v-col cols="6">
            <ImageView />
          </v-col>
          <v-col cols="6">
            <Form />
          </v-col>
          <v-col cols="6">
            <Video />
          </v-col>
          <v-col cols="6">
            <Menu />
          </v-col>
          <v-col cols="6">
            <Map />
          </v-col>
          <!-- <v-col cols="6">
            <Audio />
          </v-col> -->
        </v-row>
      </v-navigation-drawer>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import Button from "../components/Button";
import Carousel from "../components/Carousel";
import TextView from "../components/TextView";
import ImageView from "../components/ImageView";
import Form from "../components/Form";
import Video from "../components/Video";
import Menu from "../components/Menu";
import Map from "../components/Map";
// import Audio from "../components/Audio";

export default {
  name: "Sidebar",
  components: {
    Button,
    Carousel,
    TextView,
    ImageView,
    Form,
    Video,
    Menu,
    Map,
    // Audio,
  },
  data: function() {
    return {
      drawer: true,
    };
  },
  computed: {
    ...mapGetters(["getDrawer"]),
  },
  watch: {
    getDrawer(value) {
      this.drawer = value;
    },
  },
  methods: {},
};
</script>

<style scoped>
.sidebar {
  /* width: 240px; */
  box-shadow: 0 10px 20px 0 rgb(0 0 0 / 5%);
  justify-content: center;
  flex-wrap: wrap;
  position: fixed;
  right: 0;
  top: 58px;
  height: 100%;
  background-color: white;
  z-index: 15;
}
.settings {
  margin-top: 58px;
}
.sidebar-title {
  padding: 2.7rem 3.3rem 1rem;
  font-size: 1rem;
  font-weight: 500;
}
</style>
