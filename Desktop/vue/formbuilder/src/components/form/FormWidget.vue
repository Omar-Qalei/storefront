<template>
  <div class="widget">
    <SettingsWidget :show="item.i === getSelectedWidgetById.i"></SettingsWidget>
    <form :style="formStyle" id="form">
      <h2
        class="h5 font-weight-medium mb-2"
        v-show="!item.properties.hideFormName"
      >
        {{ item.properties.name }}
      </h2>
      <template v-if="item.properties.fields.length > 0">
        <v-text-field
          class="mt-2"
          v-for="(field, index) in item.properties.fields"
          :key="index"
          v-model="name"
          :error-messages="nameErrors"
          :label="field.label"
          :placeholder="field.placeholder"
          :required="field.isRequired"
          @input="$v.name.$touch()"
          @blur="$v.name.$touch()"
          :style="fieldStyle"
          hide-details
          outlined
        ></v-text-field>
      </template>
      <template v-else>
        <v-text-field
          class="mt-4"
          v-for="(field, index) in fields"
          :key="index + 'disabled'"
          v-model="name"
          :error-messages="nameErrors"
          :label="field.label"
          :disabled="true"
          hide-details
          :placeholder="field.placeholder"
          :required="field.isRequired"
          @input="$v.name.$touch()"
          @blur="$v.name.$touch()"
          :style="fieldStyle"
          outlined
        ></v-text-field>
      </template>
      <v-btn class="mr-4 mt-4" @click="submit" :style="buttonStyle">
        {{
          item.properties.submitBtnName
            ? item.properties.submitBtnName
            : "Submit"
        }}
      </v-btn>
    </form>
  </div>
</template>

<script>
import { validationMixin } from "vuelidate";
import { required, maxLength, email } from "vuelidate/lib/validators";
import { mapGetters } from "vuex";
import SettingsWidget from "../settings/SettingsWidget";

export default {
  mixins: [validationMixin],
  name: "FormWidget",
  components: {
    SettingsWidget,
  },
  validations: {
    name: { required, maxLength: maxLength(10) },
    email: { required, email },
    select: { required },
    checkbox: {
      checked(val) {
        return val;
      },
    },
  },
  props: {
    item: {},
  },
  data() {
    return {
      name: "",
      email: "",
      select: null,
      items: ["Item 1", "Item 2", "Item 3", "Item 4"],
      checkbox: false,
      fields: [
        {
          icon: "mdi-account",
          text: "Name",
          label: "Name",
          placerholder: "Enter your name",
          isRequired: false,
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
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
    checkboxErrors() {
      const errors = [];
      if (!this.$v.checkbox.$dirty) return errors;
      !this.$v.checkbox.checked && errors.push("You must agree to continue!");
      return errors;
    },
    selectErrors() {
      const errors = [];
      if (!this.$v.select.$dirty) return errors;
      !this.$v.select.required && errors.push("Item is required");
      return errors;
    },
    nameErrors() {
      const errors = [];
      if (!this.$v.name.$dirty) return errors;
      !this.$v.name.maxLength &&
        errors.push("Name must be at most 10 characters long");
      !this.$v.name.required && errors.push("Name is required.");
      return errors;
    },
    emailErrors() {
      const errors = [];
      if (!this.$v.email.$dirty) return errors;
      !this.$v.email.email && errors.push("Must be valid e-mail");
      !this.$v.email.required && errors.push("E-mail is required");
      return errors;
    },
    formStyle: function() {
      if (this.item.properties.style) {
        console.log(this.item.properties.style.form);
        return this.item.properties.style.form
          ? this.item.properties.style.form
          : "";
      } else {
        return "";
      }
    },
    fieldStyle: function() {
      if (this.item.properties.style) {
        return this.item.properties.style.field
          ? this.item.properties.style.field
          : "";
      } else {
        return "";
      }
    },
    buttonStyle: function() {
      if (this.item.properties.style) {
        return this.item.properties.style.button
          ? this.item.properties.style.button
          : "";
      } else {
        return "";
      }
    },
  },
  methods: {
    submit: function() {
      this.$v.$touch();
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
}
form {
  z-index: -1;
  position: absolute !important;
  display: block !important;
  z-index: -1 !important;
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
