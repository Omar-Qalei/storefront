<template>
  <div class="main">
    <v-card class="pa-4">
      <v-tabs v-model="tab">
        <v-tabs-slider color="orange lighten-2"></v-tabs-slider>
        <v-tab>
          Contacts
        </v-tab>
        <v-tab>
          Companies
        </v-tab>
      </v-tabs>
      <v-divider></v-divider>
      <v-tabs-items v-model="tab">
        <v-tab-item>
          <Contacts />
        </v-tab-item>
        <v-tab-item>
          <Companies />
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
import Contacts from "./components/Contacts.vue";
import Companies from "./components/Companies.vue";
export default {
  name: "Main",
  components: {
    Contacts,
    Companies,
  },
  data() {
    return {
      tab: null,
    };
  },
  methods: {},
};
</script>

<style></style>
