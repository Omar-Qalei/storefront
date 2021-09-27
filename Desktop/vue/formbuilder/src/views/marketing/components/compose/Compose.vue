<template>
  <div class="compose">
    <v-card flat>
      <v-stepper v-model="current" class="elevation-0">
        <v-row>
          <!-- Stepper -->
          <v-col cols="2" class="mt-15">
            <v-row>
              <v-col
                cols="12"
                v-for="(step, index) of steps"
                :key="`${step}-step`"
              >
                <v-stepper-step :step="index + 1" editable>
                  {{ step }}
                </v-stepper-step>
                <v-divider v-if="index !== steps" :key="step"></v-divider>
              </v-col>
              <v-col class="text-center">
                <v-btn color="primary" @click="onNext()">
                  Continue
                </v-btn>
                <v-btn text color="grey" @click="onPrevious()">
                  Back
                </v-btn>
              </v-col>
            </v-row>
          </v-col>
          <!-- Stepper -->

          <!-- Content -->
          <v-col cols="10">
            <v-stepper-items>
              <v-stepper-content :step="1">
                <v-row>
                  <v-col cols="12">
                    <ChooseTemplate />
                  </v-col>
                </v-row>
              </v-stepper-content>
            </v-stepper-items>
            <v-stepper-items>
              <v-stepper-content :step="2">
                <EmailDesign />
              </v-stepper-content>
            </v-stepper-items>
            <v-stepper-items>
              <v-stepper-content :step="3">
                <CampaignSubject />
              </v-stepper-content>
            </v-stepper-items>
            <v-stepper-items>
              <v-stepper-content :step="4">
                <AddRecipients />
              </v-stepper-content>
            </v-stepper-items>
            <v-stepper-items>
              <v-stepper-content :step="5">
                <ReviewAndSend />
              </v-stepper-content>
            </v-stepper-items>
          </v-col>
          <!-- Content -->
        </v-row>
      </v-stepper>
    </v-card>
    <!-- </v-dialog> -->
  </div>
</template>

<script>
import CampaignSubject from "./components/CampaignSubject.vue";
import EmailDesign from "./components/EmaiDesign.vue";
import ChooseTemplate from "./components/ChooseTemplate.vue";
import AddRecipients from "./components/AddRecipients.vue";
import ReviewAndSend from "./components/ReviewAndSend.vue";
export default {
  name: "Compose",
  components: {
    CampaignSubject,
    EmailDesign,
    ChooseTemplate,
    AddRecipients,
    ReviewAndSend,
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
    onNext: function() {
      if (this.steps.length > this.current) this.current += 1;
    },
    onPrevious: function() {
      if (1 < this.current) this.current -= 1;
    },
  },
};
</script>
<style scoped>
.fixed {
  position: fixed;
}
</style>
