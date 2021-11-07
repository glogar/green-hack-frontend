<template>
  <div>
    <v-toolbar v-if="$slots.extension" flat dense>
      <slot name="extension" />
    </v-toolbar>
    <slot />
  </div>
</template>

<script>
export default {
  data: () => {
    return {}
  },
}
</script>
