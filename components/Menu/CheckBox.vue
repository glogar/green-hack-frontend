<template>
  <v-checkbox v-model="checkbox" dense hide-details :label="label">
    <template #append><v-img v-if="url" :src="url"></v-img></template>
  </v-checkbox>
</template>

<script>
export default {
  props: {
    value: {
      type: Boolean,
      required: true,
    },
    label: {
      type: String,
      required: true,
    },
    url: {
      type: String,
      default: null,
    },
  },
  data: () => {
    return {}
  },
  computed: {
    checkbox: {
      get() {
        return this.value
      },
      set(value) {
        this.$emit('input', value)
      },
    },
  },
}
</script>

<style></style>
