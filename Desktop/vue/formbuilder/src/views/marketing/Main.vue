<template>
  <div class="main">
      <Compose/>
  </div>
</template>

<script>
import Compose from "./components/Compose.vue"; 

export default {
  name: "Main",
  components: {
    Compose,  
  },
  data() {
    return {
      tab: null,
      plan:null,
      hasPlans:null,
    };
  }
};
</script>

<style></style>
