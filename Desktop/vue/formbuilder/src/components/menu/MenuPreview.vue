<template>
  <div class="widget">
    <nav :style="menuStyle()">
      <a class="logo mr-6">
        <img
          class="menu-logo"
          :src="getDefaultImage(item)"
          width="200"
          height="50"
        />
      </a>
      <template v-if="getScreenSize.screen === 'web'">
        <div class="w-100" :style="{ textAlign: textAlign }">
          <v-btn
            v-for="(element, index) in list"
            :key="index"
            :style="[
              textStyle(),
              hoverId === index ? onHover(item.properties.elementHover) : '',
            ]"
            text
            @mouseover="
              hover = true;
              hoverId = index;
            "
            @mouseleave="
              hover = false;
              hoverId = index;
            "
            v-show="element.status"
            @click="goToPath(element.path)"
          >
            {{ element.name }}
          </v-btn>
        </div>
      </template>
      <template v-else>
        <v-spacer></v-spacer>
        <!-- <v-btn
          :style="[
            { color: textStyle().color },
            onHover(item.properties.elementHover),
          ]"
          icon
          small
          @click="
            onShowMenu();
            onFetchDataMenu(item.properties.style, list);
          "
        >
          <v-icon>mdi-menu</v-icon>
        </v-btn>

        <v-list :style="[textStyle(), menuStyle()]">
          <v-list-item
            v-for="item in list"
            :key="item.title"
            @click="goTo(item.path)"
            link
          >
            <v-list-item-content>
              <v-list-item-title>{{ item.name }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list> -->

        <v-menu left :nudge-width="350" offset-y>
          <template v-slot:activator="{ on, attrs }">
            <v-btn
              dark
              v-bind="attrs"
              v-on="on"
              :style="[
                { color: textStyle().color },
                onHover(item.properties.elementHover),
              ]"
              icon
              small
              @click="onFetchDataMenu(item.properties.style, list)"
            >
              <v-icon>mdi-menu</v-icon>
            </v-btn>
          </template>

          <v-list :style="[textStyle(), menuStyle()]">
            <v-list-item
              v-for="item in list"
              :key="item.title"
              @click="goToPath(item.path)"
              link
            >
              <v-list-item-content>
                <v-list-item-title>{{ item.name }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-menu>
      </template>
    </nav>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "MenuWidget",
  data() {
    return {
      list: [],
      textAlign: "center",
      image: "../../assets/images/menu-logo.png",
      text: {
        alignSelf: "center",
        fontWeight: "",
        fontStyle: "",
        textDecoration: "",
        color: "black",
        textTransform: "none",
        fontSize: "18px",
      },
      menu: {
        background: "transparent",
        fixedPosition: false,
      },
      hover: false,
      hoverId: null,
    };
  },
  props: {
    item: {},
    sectionId: Number,
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById", "getPages", "getScreenSize"]),
  },
  watch: {
    getPages: function() {
      if (this.item.properties.fields.length > 0) {
        const pages = this.getPages.map((element) => element.id).sort();
        this.getPages.forEach((element) => (element.status = true));
        this.list = this.getPages;
        const fields = this.item.properties.fields
          .map((element) => element.id)
          .sort();
        const thiz = this;
        pages.forEach(function(element) {
          if (fields.indexOf(element) === -1) {
            const object = thiz.getPages.find((obj) => obj.id === element);
            thiz.item.properties.fields.push(object);
          }
        });
        this.list = thiz.item.properties.fields.map((element) => {
          return {
            id: element.id,
            name: element.name,
            path: element.path,
            status: element?.status !== undefined ? element.status : true,
          };
        });
      }
    },
    "item.properties.fields": function(value) {
      if (value.length > 0) this.list = value;
    },
  },
  methods: {
    ...mapActions(["onShowMenu", "fetchDataMenu"]),
    getDefaultImage(item) {
      if (item.properties.image) return item.properties.image;
      return "https://wimmly.com/storage/01becba3-9951-4516-8230-d7e5cf9d45fa/media/VVF6czRlyaQ0Y6NhWMoUgheJgZNhAv23AoZurw0R.png";
    },
    menuStyle: function() {
      if (this.item.properties.style) {
        return this.item.properties.style.menu
          ? this.item.properties.style.menu
          : this.menu;
      } else {
        return this.menu;
      }
    },
    textStyle: function() {
      if (this.item.properties.style) {
        if (this.item.properties.style.elements) {
          this.textAlign = this.item.properties.style.elements.text.textAlign;
          return this.item.properties.style.elements.text
            ? this.item.properties.style.elements.text
            : this.text;
        } else {
          return this.text;
        }
      } else {
        return this.text;
      }
    },
    onHover: function(elementHover) {
      if (this.hover) {
        if (elementHover !== undefined) {
          return elementHover;
        }
      } else {
        return "";
      }
    },
    onFetchDataMenu: function(styles, list) {
      const data = {
        fields: list,
        styles: styles,
      };
      this.fetchDataMenu(data);
    },
    goToPath: function(pagePath) {
      const data = this.getPages.find(
        (element) => element.path.toLowerCase() === pagePath.toLowerCase()
      );
      const siteId = data.site_id;
      const pageId = data.id;
      if (+this.$route.query.pageId !== pageId)
        this.$router.replace({
          path: "preview",
          query: { siteId: siteId, pageId: pageId },
        });
    },
  },
  created() {
    if (this.item.properties.fields.length === 0)
      this.list = this.getPages.map((element) => {
        return {
          id: element.id,
          name: element.name,
          path: element.path,
          status: element?.status !== undefined ? element.status : true,
        };
      });
    if (this.item.properties.fields.length > 0)
      this.list = this.item.properties.fields;
  },
};
</script>

<style scoped>
.widget {
  width: 100%;
  height: 100%;
}
nav {
  display: flex;
  align-items: center;
  width: 100%;
  height: 100%;
}
.widget ::v-deep.v-btn {
  text-transform: inherit;
}
.menu-logo {
  object-fit: cover;
}
.fixed {
  position: fixed;
}
.absolute {
  position: absolute;
}
</style>
