<template>
  <v-sheet class="loading">
    <v-progress-circular
      :width="3"
      :size="70"
      color="primary"
      indeterminate
    ></v-progress-circular>
  </v-sheet>
</template>

<script>
export default {
  name: "LoadingPage",
  data() {
    return {
      interval: {},
      value: 0,
    };
  },
  mounted() {
    this.interval = setInterval(() => {
      if (this.value === 100) {
        return (this.value = 0);
      }
      this.value += 10;
    }, 1000);
  },
  beforeDestroy() {
    clearInterval(this.interval);
  },
};
</script>

<style scoped>
.loading {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
