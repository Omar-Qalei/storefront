<template>
  <div>
    <div class="d-flex settings">
      <v-navigation-drawer height="100%" v-model="getDrawer" :permanent="getDrawer" right app clipped>
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
            <Label />
          </v-col>
          <v-col cols="6">
            <ImageView />
          </v-col>
        </v-row>
      </v-navigation-drawer>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import Button from "./components/Button";
import Carousel from "./components/Carousel";
import Label from "./components/Label";
import ImageView from "./components/ImageView";
export default {
  name: "Sidebar",
  data: function() {
    return {
      addElement: false,
      drawer: false,
      items: [
        { title: "Home", icon: "mdi-home-city" },
        { title: "My Account", icon: "mdi-account" },
        { title: "Users", icon: "mdi-account-group-outline" },
      ],
      mini: true,
    };
  },
  components: {
    Button,
    Carousel,
    Label,
    ImageView
  },
  methods: {
    onAddElement: function() {
      this.addElement = !this.addElement;
    },
  },
  computed: {
    ...mapGetters(["getDrawer"]),
  },
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
