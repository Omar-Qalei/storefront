<template>
  <div>
    <div class="d-flex settings">
      <v-navigation-drawer
        height="100%"
        v-model="drawer"
        :permanent="drawer"
        left
        app
        clipped
        color="transparent"
      >
        <v-list nav dense light>
          <v-list-item class="display-1 font-weight-bold my-4 text-center">
            <p style="color:#6200ea;">Wimmly</p>
          </v-list-item>
          <v-list-item-group color="primary">
            <template v-for="(item, index) in items">
              <v-list-item
                v-if="item.submenu.length === 0"
                :key="index"
                color="primary"
                link
              >
                <v-list-item-icon>
                  <v-icon color="#7683a8" v-text="item.icon"></v-icon>
                </v-list-item-icon>

                <v-list-item-content>
                  <v-list-item-title
                    class="silver-blue-text"
                    v-text="item.text"
                  ></v-list-item-title>
                </v-list-item-content>
              </v-list-item>
              <v-list-group
                v-else
                :key="index"
                v-model="item.active"
                :prepend-icon="item.icon"
                color="#7683a8"
                no-action
              >
                <template v-slot:activator>
                  <v-list-item-content>
                    <v-list-item-title
                      class="silver-blue-text"
                      v-text="item.text"
                    ></v-list-item-title>
                  </v-list-item-content>
                </template>

                <v-list-item v-for="child in item.submenu" :key="child.title">
                  <v-list-item-content>
                    <v-list-item-title
                      class="silver-blue-text"
                      v-text="child.text"
                    ></v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list-group>
            </template>
          </v-list-item-group>
        </v-list>
      </v-navigation-drawer>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  name: "Sidebar",
  data: function() {
    return {
      drawer: true,
      selectedItem: 0,
      items: [
        {
          text: "Dashboard",
          icon: "mdi-view-dashboard",
          url: "",
          submenu: [],
        },
        {
          text: "Contacts",
          icon: "mdi-account-box",
          url: "",
          submenu: [],
        },
        {
          text: "Sites",
          icon: "mdi-web-box",
          url: "Sites",
          submenu: [],
        },
        {
          text: "Marketing",
          icon: "mdi-shopping-outline",
          submenu: [
            { text: "Compose", url: "" },
            { text: "Campaigns", url: "" },
            { text: "Mailing Lists", url: "" },
            { text: "Sender", url: "" },
          ],
        },
      ],
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
}
.settings {
  margin-top: 58px;
}
.sidebar-title {
  padding: 2.7rem 3.3rem 1rem;
  font-size: 1rem;
  font-weight: 500;
}
.silver-blue-text {
  color: #7683a8;
}
</style>
