<template>
  <div class="compose">
    <!-- <v-btn color="primary" class="ma-2" dark @click="dialog = true">
      Compose Email
    </v-btn> -->
    <!-- <v-dialog
      v-model="dialog"
      fullscreen
      hide-overlay
      transition="dialog-bottom-transition"
      scrollable
    > -->
    <v-card tile flat>
      <!-- <v-toolbar dark color="primary" max-height="65">
        <v-btn icon dark @click="dialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
        <v-toolbar-title>Settings</v-toolbar-title>
        <v-spacer></v-spacer>
      </v-toolbar> -->
      <!-- <v-stepper v-model="current" vertical>
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
        </v-stepper> -->
      <!-- <div style="flex: 1 1 auto;"></div> -->
      <v-stepper v-model="current">
        <v-stepper-header>
          <!-- :complete="e1 > index" -->
          <template v-for="(step, index) of steps">
            <v-stepper-step :key="`${step}-step`" :step="index" editable>
              {{ step }}
            </v-stepper-step>

            <v-divider v-if="index !== steps" :key="step"></v-divider>
          </template>
        </v-stepper-header>
        <v-stepper-items>
          <v-stepper-content :step="0">
            <v-card class="mb-12" color="grey lighten-1" flat></v-card>

            <v-btn color="primary" @click="current = 1">
              Continue
            </v-btn>

            <v-btn text @click="dialog = false" color="red">
              Cancel
            </v-btn>
          </v-stepper-content>
        </v-stepper-items>
        <v-stepper-items>
          <v-stepper-content :step="1">
            <v-row>
              <v-col cols="12">
                <Navbar />
              </v-col>
              <v-col cols="9">
                <GridView />
              </v-col>
              <v-col cols="3" style="min-height: 400px">
                <Sidebar />
              </v-col>
            </v-row>
            <v-btn color="primary" @click="current = 2">
              Continue
            </v-btn>
            <v-btn text color="grey" @click="current = 0">
              Back
            </v-btn>
            <v-btn text @click="dialog = false" color="red">
              Cancel
            </v-btn>
          </v-stepper-content>
        </v-stepper-items>
        <v-stepper-items>
          <v-stepper-content :step="2">
            <CampaignSubject />
            <v-btn color="primary" @click="current = 3">
              Continue
            </v-btn>
            <v-btn text color="grey" @click="current = 1">
              Back
            </v-btn>
            <v-btn text @click="dialog = false" color="red">
              Cancel
            </v-btn>
          </v-stepper-content>
        </v-stepper-items>
        <v-stepper-items>
          <v-stepper-content :step="3">
            <v-card class="mb-12" color="grey lighten-1"></v-card>

            <v-btn color="primary" @click="current = 4">
              Continue
            </v-btn>
            <v-btn text color="grey" @click="current = 2">
              Back
            </v-btn>
            <v-btn text @click="dialog = false" color="red">
              Cancel
            </v-btn>
          </v-stepper-content>
        </v-stepper-items>
        <v-stepper-items>
          <v-stepper-content :step="4">
            <v-card class="mb-12" color="grey lighten-1"></v-card>
            <!--  @click="nextStep(current)" -->
            <v-btn color="primary">
              Continue
            </v-btn>
            <v-btn text color="grey" @click="current = 3">
              Back
            </v-btn>
            <v-btn text @click="dialog = false" color="red">
              Cancel
            </v-btn>
          </v-stepper-content>
        </v-stepper-items>
      </v-stepper>
    </v-card>
    <!-- </v-dialog> -->
  </div>
</template>

<script>
import CampaignSubject from "./CampaignSubject.vue";
import GridView from "../../GridView.vue";
import Navbar from "../../../layouts/compose-email/Navbar";
import Sidebar from "../../../layouts/compose-email/Sidebar";
export default {
  name: "Compose",
  components: {
    CampaignSubject,
    GridView,
    Navbar,
    Sidebar,
  },
  data() {
    return {
      current: 1,
      lastStep: 5,
      loading: true,
      dialog: "",
      valid: false,
      stepForm: [],
      steps: [
        "Choose template",
        "Design Email",
        "Email Information",
        "Add Recipients",
        "Review and Send",
      ],
    };
  },
  methods: {
    stepComplete(step) {
      return this.current > step;
    },
    previous() {
      this.current = this.current != 1 ? this.current - 1 : 1;
    },
    stepStatus(step) {
      return this.current > step ? "green" : "blue";
    },
    validate(n) {
      this.steps[n].valid = false;
      let v = this.$refs.stepForm[n].validate();
      if (v) {
        this.steps[n].valid = true;
        this.curr = n + 2;
      }
    },
  },
};
</script>
<style></style>
