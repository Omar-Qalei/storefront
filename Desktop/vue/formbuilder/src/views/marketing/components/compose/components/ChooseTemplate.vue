<template>
  <div>
    <h2>What kind of email will you be sending?</h2>
    <p>
      Pick the option that best applies to the purpose of your email. You'll be
      able to edit the contents later.
    </p>
    <v-tabs
      light
      next-icon="mdi-arrow-right-bold-box-outline"
      prev-icon="mdi-arrow-left-bold-box-outline"
      show-arrows
      v-model="selectedChooseTemplateTab"
    >
      <v-tabs-slider></v-tabs-slider>
      <v-tab
        v-for="(item, index) of chooseTemplateTabs"
        :key="index"
        :href="'#tab-' + index"
      >
        {{ item }}
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="selectedChooseTemplateTab">
      <v-tab-item v-for="(item, index) of chooseTemplateTabs" :key="index">
        <v-card flat>
          <v-card-text v-text="item"></v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </div>
</template>

<script>
export default {
  name: "ChooseTemplate",
  data() {
    return {
      chooseTemplateTabs: ["General", "Commerce", "Announcements", "Saved"],
      selectedChooseTemplateTab: null,
    };
  },
};
</script>

<style scoped>
h2 {
  font-size: 30px;
  margin-bottom: 10px;
}
p {
  line-height: 30px;
  color: #70767c;
  margin-bottom: 30px;
}
</style>
