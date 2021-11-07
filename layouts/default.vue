<template>
  <v-app>
    <v-system-bar app class="primary" dark>
      <v-spacer></v-spacer>
      <v-icon>wifi</v-icon>
      <v-icon>signal_cellular_alt</v-icon>
      <v-icon>battery_full</v-icon>
      <span> {{ time }}</span>
    </v-system-bar>
    <v-app-bar app flat class="primary" dark dense>
      <v-row no-gutters justify="center">
        <v-icon>emoji_nature</v-icon>
        <v-app-bar-title class="font-weight-bold">Apisearch</v-app-bar-title>
      </v-row>
    </v-app-bar>
    <v-main>
      <Nuxt id="main" />
    </v-main>
    <v-bottom-navigation v-model="value" app grow shift class="primary--text">
      <v-btn value="profile" nuxt exact to="/profile">
        <span>Profile</span>
        <v-icon>account_circle</v-icon>
      </v-btn>

      <v-btn value="map" nuxt exact to="/">
        <span>Map</span>
        <v-icon>public</v-icon>
      </v-btn>
      <v-btn value="notify" nuxt exact to="/settings">
        <span>Settings</span>
        <v-icon>settings</v-icon>
      </v-btn>
    </v-bottom-navigation>
  </v-app>
</template>

<script>
export default {
  data() {
    return {}
  },
  computed: {
    time() {
      const currentDate = new Date()
      return `${currentDate.getHours()}:${currentDate.getMinutes()}`
    },
    value: {
      get() {
        return this.$store.state.view
      },
      set(value) {
        this.$store.commit('SET_VIEW', value)
      },
    },
  },
}
</script>
<style>
.html,
body {
  width: 100%;
  height: 100%;
  padding: 0;
  margin: 0;
}
#main {
  padding: 0;
  margin: auto;
}
.v-toolbar__extension {
  background: white;
}
</style>
