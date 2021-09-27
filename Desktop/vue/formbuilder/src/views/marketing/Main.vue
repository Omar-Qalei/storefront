<template>
  <div class="main">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "Main",
  components: {},
  data() {
    return {
      tab: null,
      plan: null,
      hasPlans: null,
    };
  },
};
</script>

<style></style>
