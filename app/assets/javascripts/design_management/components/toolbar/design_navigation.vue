<script>
/* global Mousetrap */
import 'mousetrap';
import { GlButton, GlButtonGroup } from '@gitlab/ui';
import { s__, sprintf } from '~/locale';
import allDesignsMixin from '../../mixins/all_designs';
import { DESIGN_ROUTE_NAME } from '../../router/constants';

export default {
  components: {
    GlButton,
    GlButtonGroup,
  },
  mixins: [allDesignsMixin],
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  computed: {
    designsCount() {
      return this.designs.length;
    },
    currentIndex() {
      return this.designs.findIndex(design => design.filename === this.id);
    },
    paginationText() {
      return sprintf(s__('DesignManagement|%{current_design} of %{designs_count}'), {
        current_design: this.currentIndex + 1,
        designs_count: this.designsCount,
      });
    },
    previousDesign() {
      if (this.currentIndex === 0) return null;

      return this.designs[this.currentIndex - 1];
    },
    nextDesign() {
      if (this.currentIndex + 1 === this.designsCount) return null;

      return this.designs[this.currentIndex + 1];
    },
  },
  mounted() {
    Mousetrap.bind('left', () => this.navigateToDesign(this.previousDesign));
    Mousetrap.bind('right', () => this.navigateToDesign(this.nextDesign));
  },
  beforeDestroy() {
    Mousetrap.unbind(['left', 'right'], this.navigateToDesign);
  },
  methods: {
    navigateToDesign(design) {
      if (design) {
        this.$router.push({
          name: DESIGN_ROUTE_NAME,
          params: { id: design.filename },
          query: this.$route.query,
        });
      }
    },
  },
};
</script>

<template>
  <div v-if="designsCount" class="d-flex align-items-center">
    {{ paginationText }}
    <gl-button-group class="ml-3 mr-3">
      <gl-button
        :disabled="!previousDesign"
        :title="s__('DesignManagement|Go to previous design')"
        icon="angle-left"
        class="js-previous-design"
        @click="navigateToDesign(previousDesign)"
      />
      <gl-button
        :disabled="!nextDesign"
        :title="s__('DesignManagement|Go to next design')"
        icon="angle-right"
        class="js-next-design"
        @click="navigateToDesign(nextDesign)"
      />
    </gl-button-group>
  </div>
</template>
