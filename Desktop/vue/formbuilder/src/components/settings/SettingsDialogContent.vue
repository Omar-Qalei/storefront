<template>
  <div class="widget">
    <ButtonDialog v-if="typeWidget === 'button'" />
    <FormDialog v-else-if="typeWidget === 'form'" />
    <SectionDialog v-else-if="typeWidget === 'section'" />
    <AudioDialog v-else-if="typeWidget === 'audio'" />
    <CarouselDialog v-else-if="typeWidget === 'carousel'" />
    <ImageDialog v-else-if="typeWidget === 'image'" />
    <MapDialog v-else-if="typeWidget === 'map'" />
    <MenuDialog v-else-if="typeWidget === 'menu'" />
    <TextDialog v-else-if="typeWidget === 'text'" />
    <VideoDialog v-else-if="typeWidget === 'video'" />
  </div>
</template>

<script>
import ButtonDialog from "../button/ButtonDialog";
import FormDialog from "../form/FormDialog";
import SectionDialog from "../section/SectionDialog";
import AudioDialog from "../audio/AudioDialog";
import CarouselDialog from "../carousel/CarouselDialog";
import ImageDialog from "../image/ImageDialog";
import MapDialog from "../map/MapDialog";
import MenuDialog from "../menu/MenuDialog";
import TextDialog from "../text/TextDialog";
import VideoDialog from "../video/VideoDialog";
import { mapGetters } from "vuex";

export default {
  name: "SettingsDialogContent",
  components: {
    ButtonDialog,
    FormDialog,
    SectionDialog,
    AudioDialog,
    CarouselDialog,
    ImageDialog,
    MapDialog,
    MenuDialog,
    TextDialog,
    VideoDialog,
  },
  data() {
    return {
      typeWidget: null,
    };
  },
  computed: {
    ...mapGetters(["getSelectedWidgetById"]),
  },
  mounted() {
    this.typeWidget = this.getSelectedWidgetById.type;
  },
};
</script>

<style></style>
