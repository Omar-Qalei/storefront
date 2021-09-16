<template>
  <div class="compose">
    <v-btn color="primary" class="ma-2" dark @click="dialog = true">
      Compose Email
    </v-btn>
    <v-dialog v-model="dialog" fullscreen hide-overlay transition="dialog-bottom-transition" scrollable>
      <v-card tile>
        <v-toolbar flat dark color="primary">
          <v-btn icon dark @click="dialog = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
          <v-toolbar-title>Settings</v-toolbar-title>
          <v-spacer></v-spacer>
        </v-toolbar>
        <v-stepper v-model="current" vertical>
          <v-stepper-step :color="stepStatus(1)" :complete="current > 1" step="1">
            Select an Template
            <small class="mt-2">You can select template for you email campaign or saved template.</small>
          </v-stepper-step>
          <v-stepper-content step="1">
            <v-card color="grey lighten-1" class="mb-12" height="200px"></v-card>
            <v-btn color="primary" @click="current = 2">
              Next
            </v-btn>
          </v-stepper-content>
          <v-stepper-step :color="stepStatus(2)" :complete="current > 2" step="2">
            Design Email
          </v-stepper-step>

          <v-stepper-content step="2">
            <v-card color="grey lighten-1" class="mb-12" height="200px"></v-card>
            <v-btn color="primary" @click="current = 3">
              Next
            </v-btn>
            <v-btn text @click="previous()">
              Previous
            </v-btn>
          </v-stepper-content>

          <v-stepper-step :color="stepStatus(3)" :complete="current > 3" step="3">
            Email Information
            <small class="mt-2">Enter the name and email address that recipients will see.</small>
          </v-stepper-step>

          <v-stepper-content step="3">
            <CampaignSubject />
            <v-btn color="primary" @click="current = 4">
              Next
            </v-btn>
            <v-btn text @click="previous()">
              Previous
            </v-btn>
          </v-stepper-content>

          <v-stepper-step :color="stepStatus(4)" step="4">
            Add Recipients
          </v-stepper-step>
          <v-stepper-content step="4">
            <v-card color="grey lighten-1" class="mb-12" height="200px"></v-card>
            <v-btn color="primary" @click="current = 1">
              Next
            </v-btn>
            <v-btn text @click="previous()">
              Previous
            </v-btn>
          </v-stepper-content>
          <v-stepper-step :color="stepStatus(5)" step="5">
            Review and Send
          </v-stepper-step>
          <v-stepper-content step="5">
            <v-card color="grey lighten-1" class="mb-12" height="200px"></v-card>
            <v-btn color="primary" @click="current = 1">
              Next
            </v-btn>
            <v-btn text @click="previous()">
              Previous
            </v-btn>
          </v-stepper-content>
        </v-stepper>
        <div style="flex: 1 1 auto;"></div>
      </v-card>
    </v-dialog>
  </div>
</template>


<script>
  import CampaignSubject from "./CampaignSubject.vue";

  export default {
    name: "Compose",
    components: {
      CampaignSubject,
    },
    data() {
      return {
        current: 1,
        lastStep: 5,
        loading: true,
        dialog: '',
        valid: false,
        stepForm: []
      };
    },
    methods: {
      stepComplete(step) {
        return this.current > step
      },
      previous() {
        this.current = (this.current != 1) ? this.current - 1 : 1;
      },
      stepStatus(step) {
        return this.current > step ? 'green' : 'blue'
      },
      validate(n) {
        this.steps[n].valid = false
        let v = this.$refs.stepForm[n].validate()
        if (v) {
          this.steps[n].valid = true
          this.curr = n + 2
        }
      }
    },
  };
</script>
<style></style>