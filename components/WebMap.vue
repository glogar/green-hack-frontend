<template>
  <Wrapper>
    <v-sheet v-if="!$fetchState.pending" id="map">
      <l-map
        :center="map.center"
        :zoom.sync="map.zoom"
        :style="returnStyle"
        :max-zoom="15"
        :min-zoom="6"
        no-blocking-animations
        :options="mapOptions"
        @update:center="centerUpdated"
      >
        <l-tile-layer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        ></l-tile-layer>
        <l-control position="topleft">
          <v-row justify="center" class="ml-0">
            <v-col cols="12" class="px-0">
              <v-text-field
                solo
                dense
                rounded
                hide-details
                label="Search locations, address, KMG MID ..."
                style="width: 43.5vh"
                prepend-inner-icon="place"
              />
            </v-col>
          </v-row>
          <v-col class="px-0">
            <v-row justify="space-between" no-gutters>
              <Menu v-model="filter" />
              <v-spacer />
            </v-row>
          </v-col>
        </l-control>

        <l-marker
          v-for="beehive in data.beehives"
          :key="`HIVE_${beehive.id}`"
          :lat-lng="[beehive.lat, beehive.lon]"
          :icon="beehiveIcon"
        >
          <l-popup
            :options="{
              closeButton: false,
              minWidth: 200,
              className: 'ma-0',
            }"
          >
            <Popup />
          </l-popup>
        </l-marker>
        <l-marker
          v-for="apiary in data.apiaryStands"
          :key="`STAND_${apiary.id}`"
          :lat-lng="[apiary.lat, apiary.lon]"
          :icon="apiaryStandIcon"
        >
          <l-popup
            :options="{
              closeButton: false,
              minWidth: 200,
              className: 'ma-0',
            }"
          >
            <Popup stand />
          </l-popup>
        </l-marker>

        <l-marker
          v-for="breeding in data.breedings"
          :key="`BREEDING_${breeding.id}`"
          :lat-lng="[breeding.lat, breeding.lon]"
          :icon="breedingIcon"
        >
        </l-marker>

        <!-- <l-polyline
          v-for="movement in movements"
          :key="`MOVEMENT_${movement.id}`"
          stroke
          :lat-lngs="[movement.latLangs]"
        ></l-polyline> -->
      </l-map>
    </v-sheet>
    <v-container fluid fill-height>
      <v-row justify="center" align="center">
        <v-progress-circular color="primary" indeterminate size="64" />
      </v-row>
    </v-container>
  </Wrapper>
</template>

<script>
// https://cdn-icons.flaticon.com/png/512/2129/premium/2129718.png?token=exp=1636240004~hmac=b6f0b36045242d16b244addee62f6c41
// https://cdn-icons.flaticon.com/png/512/1549/premium/1549346.png?token=exp=1636239852~hmac=a0e58f572932978329d71399e56cdeb5
// https://cdn-icons-png.flaticon.com/512/656/656330.png

// import { L } from 'leaflet'
import { icon } from 'leaflet'
export default {
  data: () => {
    return {
      data: {
        beehives: [],
        apiaryStands: [],
        breedings: [],
      },
      map: {
        zoom: 9,
        center: [46.15108, 14.80513],
      },
      mapOptions: {
        zoomControl: false,
      },
      filter: {
        beehives: false,
        apiaryStands: false,
        afb: false,
        breeding: false,
        migrations: {
          value: false,
          from: '',
          to: '',
        },
        history: {
          value: false,
          from: '',
          to: '',
        },
      },
      beehiveIcon: icon({
        iconUrl: 'https://priot.io/img/icons/icn_beehive.svg',
        iconSize: [19, 25],
        iconAnchor: [10, -5],
      }),
      apiaryStandIcon: icon({
        iconUrl: 'https://priot.io/img/icons/icn_apiary_stand.svg',
        iconSize: [19, 25],
        iconAnchor: [10, -5],
      }),
      breedingIcon: icon({
        iconUrl: 'https://priot.io/img/icons/icn_queens.svg',
        iconSize: [19, 25],
        iconAnchor: [10, -5],
      }),

      // icon: icon({
      //   iconUrl:
      //     'https://cdn-icons.flaticon.com/png/512/2129/premium/2129718.png?token=exp=1636240004~hmac=b6f0b36045242d16b244addee62f6c41',
      //   iconSize: [32, 37],
      //   iconAnchor: [16, 37],
      // }),
    }
  },
  async fetch() {
    await this.$axios.get('/beehives/').then((res) => {
      this.data.beehives = res.data
    })
    await this.$axios.get('/beestands/').then((res) => {
      this.data.apiaryStands = res.data
    })
    await this.$axios.get('/breedings/').then((res) => {
      this.data.breedings = res.data
    })
  },
  computed: {
    returnStyle() {
      if (this.$vuetify.breakpoint.smAndDown) {
        return 'height: 84.2vh'
      }
      return 'height: 86.29vh'
    },
    icon() {
      return {
        size: [19, 25],
        anchor: [16, 37],
      }
    },
  },
  methods: {
    centerUpdated(center) {
      this.center = center
    },
  },
}
</script>
<style>
@import url('https://unpkg.com/leaflet-geosearch@2.6.0/assets/css/leaflet.css');
#map {
  width: 100%;
  height: 100%;
  padding-top: 0px;
  margin: 0;
}
.popup {
  padding: 0;
  margin: 0;
}
</style>
