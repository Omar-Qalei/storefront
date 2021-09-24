<template>
  <div class="widget">
    <SettingsWidget
      :show="item.i === getSelectedWidgetById.i"
      :item="item"
      :sectionId="sectionId"
    ></SettingsWidget>
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
            :style="[textStyle(), onHover(item.properties.elementHover)]"
            text
            @mouseover="hover = true"
            @mouseleave="hover = false"
            v-show="element.status"
          >
            {{ element.name }}
          </v-btn>
        </div>
      </template>
      <template v-else>
        <v-spacer></v-spacer>
        <v-btn
          :style="[
            { color: textStyle().color },
            onHover(item.properties.elementHover),
          ]"
          icon
          small
        >
          <v-icon>mdi-menu</v-icon>
        </v-btn>
      </template>
    </nav>
  </div>
</template>

<script>
import SettingsWidget from "../settings/SettingsWidget";
import { mapGetters } from "vuex";
export default {
  name: "MenuWidget",
  components: {
    SettingsWidget,
  },
  data() {
    return {
      drawer: false,
      list: [],
      textAlign: "right",
      image: "../../assets/images/menu-logo.png",
      text: {
        alignSelf: "right",
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
      if (this.getPages.length > 0) {
        // if (this.getPages.length < this.item.properties.fields.length) {
        //   console.log(this.item.properties.fields, this.getPages);
        // }
        const thiz = this;
        if (this.getPages.length < this.item.properties.fields.length) {
          this.item.properties.fields.forEach(function(element) {
            const index = thiz.getPages.indexOf((obj) => obj.id !== element);
            if (index === -1) {
              thiz.item.properties.fields = thiz.item.properties.fields.filter(
                (obj) => obj.id !== element.id
              );
            }
          });
        }
        // const pages = this.getPages.map((element) => element.id).sort();
        this.getPages.forEach((element) => (element.status = true));
        // this.list = pages;
        const fields = this.getPages.map((element) => element.id).sort();
        fields.forEach(function(element) {
          // console.log(thiz.item.properties.fields.indexOf(element) === -1);
          const newPage = thiz.item.properties.fields.find(
            (ele) => ele.id === element
          );
          // We can use it if happened any error
          // const s = thiz.item.properties.fields.indexOf(
          //   (obj) => obj.id === element
          // );
          if (newPage === undefined) {
            const object = thiz.getPages.find((obj) => obj.id === element);
            thiz.item.properties.fields.push(object);
          }
        });

        this.list = this.item.properties.fields.map((element) => {
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
    getDefaultImage(item) {
      if (item.properties.image) return item.properties.image;
      return "https://wimmly.com/storage/01becba3-9951-4516-8230-d7e5cf9d45fa/media/VVF6czRlyaQ0Y6NhWMoUgheJgZNhAv23AoZurw0R.png";
    },
    navStyle: function() {
      if (this.item.properties.style) {
        if (this.item.properties.style.menu) {
          return this.item.properties.style.menu
            ? this.item.properties.style.menu
            : this.menu;
        } else {
          return this.menu;
        }
      } else {
        return this.menu;
      }
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
  position: absolute;
  display: flex;
  align-items: center;
  z-index: -1;
  width: 100%;
  height: 100%;
}
.widget ::v-deep.v-btn {
  text-transform: inherit;
}
.menu-logo {
  object-fit: cover;
}
</style>
