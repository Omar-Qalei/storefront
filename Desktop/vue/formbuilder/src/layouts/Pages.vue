<template>
  <div>
    <div class="d-flex">
      <v-navigation-drawer
        height="100%"
        v-model="drawer"
        left
        app
        clipped
        absolute
        temporary
        class="settings"
      >
        <v-list>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Pages</v-list-item-title>
            </v-list-item-content>

            <v-list-item-action>
              <v-btn class="red--text" icon @click="onDrawerPages">
                <v-icon>mdi-window-close</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>
        </v-list>
        <v-divider></v-divider>
        <v-list>
          <v-list-item
            v-for="(page, index) in getPages"
            :key="index"
            @click="
              selectedPage = page.id;
              onDrawerPages();
            "
          >
            <v-list-item-icon>
              <v-icon v-text="page.icon"></v-icon>
            </v-list-item-icon>
            <v-list-item-title v-text="page.title"></v-list-item-title>
          </v-list-item>
        </v-list>
      </v-navigation-drawer>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "Pages",
  data: function() {
    return {
      addElement: false,
      drawer: false,
      mini: true,
      selectedPage: null,
    };
  },
  components: {},
  methods: {
    ...mapActions(["onDrawerPages", "onSelectedPage"]),
    onAddElement: function() {
      this.addElement = !this.addElement;
    },
  },
  computed: {
    ...mapGetters(["getDrawerPages", "getPages"]),
  },
  watch: {
    getDrawerPages(value) {
      this.drawer = value;
    },
    drawer(value) {
      this.onDrawerPages(value);
    },
    selectedPage(value) {
      this.onSelectedPage(value);
    },
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
  top: 48px !important;
}
.sidebar-title {
  padding: 2.7rem 3.3rem 1rem;
  font-size: 1rem;
  font-weight: 500;
}
</style>
