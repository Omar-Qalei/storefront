<template>
  <v-card>
    <v-card-title class="headline grey lighten-2">
      Button Settings
    </v-card-title>
    <v-card-text>
      <v-card class="overflow-y-auto elevation-0" max-height="495">
        <v-tabs color="deep-purple accent-4">
          <v-tab>Content</v-tab>
          <v-tab>Design</v-tab>

          <v-tab-item>
            <ButtonContent />
          </v-tab-item>
          <v-tab-item>
            <v-container fluid>
              <v-row>
                <v-col v-for="i in 6" :key="i" cols="12" md="4"> </v-col>
              </v-row>
            </v-container>
          </v-tab-item>
        </v-tabs>
      </v-card>
    </v-card-text>
    <v-divider></v-divider>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="primary" text @click="$modal.hide('settings')">
        Cancel
      </v-btn>
      <v-btn color="primary" text @click="$modal.hide('settings')">
        Done
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import ButtonContent from "./ButtonContent";
export default {
  name: "ButtonDialog",
  components: { ButtonContent },
  methods: {
    beforeOpen(event) {
      console.log("before-open", event);
    },
    beforeClose() {},
    opened(event) {
      // e.ref should not be undefined here
      console.log("opened", event);
      console.log("ref", event.ref);
    },
    closed(event) {
      console.log("closed", event);
    },
  },
};
</script>

<style></style>
