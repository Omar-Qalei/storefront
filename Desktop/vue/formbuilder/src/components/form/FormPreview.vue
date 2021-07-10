<template>
  <div class="widget" @mouseover="hover = true" @mouseleave="hover = false">
    <v-form :style="formStyle" id="form" v-model="isValid">
      <h2
        class="h5 font-weight-medium mb-2"
        v-show="!item.properties.hideFormName"
      >
        {{ item.properties.name }}
      </h2>
      <template v-if="item.properties.fields.length > 0">
        <!-- :error-messages="nameErrors" -->
        <v-text-field
          class="mt-2"
          v-for="(field, index) in item.properties.fields"
          :key="index"
          v-model="name"
          :label="field.label"
          :placeholder="field.placeholder"
          :rules="field.isRequired ? rules : []"
          :style="fieldStyle"
          hide-details
          outlined
        ></v-text-field>
      </template>
      <!-- :error-messages="nameErrors" -->
      <template v-else>
        <v-text-field
          class="mt-4"
          v-for="(field, index) in fields"
          :key="index + 'disabled'"
          v-model="field.value"
          :label="field.label"
          hide-details
          :placeholder="field.placeholder"
          :required="field.isRequired"
          :rules="field.isRequired ? rules : []"
          :style="fieldStyle"
          outlined
        ></v-text-field>
      </template>
      <v-btn
        class="mr-4 mt-4"
        @click="submit(item.properties)"
        :style="buttonStyle"
      >
        {{
          item.properties.submitBtnName
            ? item.properties.submitBtnName
            : "Submit"
        }}
      </v-btn>
    </v-form>
  </div>
</template>

<script>
// import { validationMixin } from "vuelidate";
// import { required, maxLength, email } from "vuelidate/lib/validators";
import { mapActions } from "vuex";
export default {
  // mixins: [validationMixin],
  name: "FormPreview",
  // validations: {
  //   name: { required, maxLength: maxLength(10) },
  //   email: { required, email },
  //   select: { required },
  //   checkbox: {
  //     checked(val) {
  //       return val;
  //     },
  //   },
  // },
  props: {
    item: {},
  },
  data() {
    return {
      hover: false,
      selectedLinkTo: 0,
      isValid: false,
      defaultElementHover: {
        color: "#FFFFFFFF",
        backgroundColor: "#A05CFFFF",
      },
      name: "",
      email: "",
      select: null,
      items: ["Item 1", "Item 2", "Item 3", "Item 4"],
      checkbox: false,
      rules: [(v) => !!v || "Required"],
      fields: [
        {
          icon: "mdi-account",
          text: "Name",
          label: "Name",
          placerholder: "Enter your name",
          isRequired: true,
          type: "name",
        },
        {
          icon: "mdi-email",
          text: "Email",
          label: "Email",
          placerholder: "Enter your email",
          isRequired: false,
          type: "email",
        },
        {
          icon: "mdi-phone",
          text: "Phone",
          label: "Phone ",
          placerholder: "Enter your phone",
          isRequired: false,
          type: "phone",
        },
      ],
      form: {
        textAlign: "center",
        border: "solid",
        borderWidth: "10px",
        borderColor: "transparent",
        backgroundColor: "#EBEBEBFF",
        borderRadius: "21px",
      },
      field: {
        fontSize: "16px",
        color: "#000000de",
        backgroundColor: "#FFFFFFFF",
        borderRadius: "40px",
      },
      button: {
        color: "#FFFFFFFF",
        backgroundColor: "#4E00BBFF",
        borderRadius: "16px",
      },
    };
  },
  computed: {
    // checkboxErrors() {
    //   const errors = [];
    //   if (!this.$v.checkbox.$dirty) return errors;
    //   !this.$v.checkbox.checked && errors.push("You must agree to continue!");
    //   return errors;
    // },
    // selectErrors() {
    //   const errors = [];
    //   if (!this.$v.select.$dirty) return errors;
    //   !this.$v.select.required && errors.push("Item is required");
    //   return errors;
    // },
    // nameErrors() {
    //   const errors = [];
    //   if (!this.$v.name.$dirty) return errors;
    //   !this.$v.name.maxLength &&
    //     errors.push("Name must be at most 10 characters long");
    //   !this.$v.name.required && errors.push("Name is required.");
    //   return errors;
    // },
    // emailErrors() {
    //   const errors = [];
    //   if (!this.$v.email.$dirty) return errors;
    //   !this.$v.email.email && errors.push("Must be valid e-mail");
    //   !this.$v.email.required && errors.push("E-mail is required");
    //   return errors;
    // },
    formStyle: function() {
      if (this.item.properties.style) {
        return this.item.properties.style.form
          ? this.item.properties.style.form
          : this.form;
      } else {
        return this.form;
      }
    },
    fieldStyle: function() {
      if (this.item.properties.style) {
        return this.item.properties.style.field
          ? this.item.properties.style.field
          : this.field;
      } else {
        return this.field;
      }
    },
    buttonStyle: function() {
      if (this.item.properties.style) {
        return this.item.properties.style.button
          ? this.item.properties.style.button
          : this.button;
      } else {
        return this.button;
      }
    },
  },
  methods: {
    ...mapActions(["onShowSnackbar"]),
    submit: function(properties) {
      let siteId, pageId, url, newTab, content;
      if (this.isValid)
        switch (this.selectedLinkTo) {
          case 0:
            siteId = properties.page.site_id;
            pageId = properties.page.id;
            if (+this.$route.query.pageId !== pageId)
              this.$router.replace({
                path: "preview",
                query: { siteId: siteId, pageId: pageId },
              });
            break;
          case 1:
            url = properties.url;
            newTab = properties.newTab;
            if (newTab) {
              window.open(url, "_blank");
            } else {
              window.open(url, "_self");
            }
            break;
          case 2:
            content = properties.showMessage;
            if (content) {
              this.onShowSnackbar(content);
            }
            break;
        }
    },
    clear: function() {
      this.$v.$reset();
      this.name = "";
      this.email = "";
      this.select = null;
      this.checkbox = false;
    },
    calcHeight: function() {
      let h = document.getElementById("form").getBoundingClientRect().height;
      let out = {
        height: h === Infinity ? h : Math.round((h - 0) / 30),
      };

      if (out.height % 2 !== 0) {
        out.height += 1;
      }
      // this.item.y = out.height;
      // return out.height;
    },
    onHover: function(elementHover) {
      if (this.hover) {
        if (elementHover !== undefined) {
          return elementHover;
        } else {
          return {};
        }
      } else {
        return "";
      }
    },
  },
  created() {
    this.item.properties.hideFormName = true;
    if (this.item.properties.selectedLinkTo !== null) {
      if (this.item.properties.selectedLinkTo !== undefined)
        this.selectedLinkTo = this.item.properties.selectedLinkTo;
    }
  },
  updated() {
    this.calcHeight();
  },
};
</script>

<style scoped>
.vue-grid-item:not(.vue-grid-placeholder) {
  background: #ccc;
  border: 1px solid black;
}
.vue-grid-item .resizing {
  opacity: 0.9;
}
.vue-grid-item .static {
  background: #cce;
}
.widget {
  width: 100%;
  height: 100%;
  z-index: 0;
}
form {
  z-index: 1;
  display: block !important;
  width: 100% !important;
}
.widget .v-text-field ::v-deep.v-label {
  color: inherit !important;
  font-size: inherit;
}
.widget ::v-deep.v-btn {
  text-transform: inherit;
}
.widget .v-btn ::v-deep.v-btn__content {
  align-items: inherit;
  height: 100%;
}
</style>
