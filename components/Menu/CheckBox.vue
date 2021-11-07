<template>
  <v-checkbox v-model="checkbox" dense hide-details :label="label"></v-checkbox>
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
