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
          v-for="beehive in returnBeehives"
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
            <Popup :item="beehive" />
          </l-popup>
        </l-marker>
        <l-marker
          v-for="apiary in returnApiaryStands"
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
            <Popup stand :item="apiary" />
          </l-popup>
        </l-marker>

        <l-circle-marker
          v-for="disease in returnDiseases"
          :key="`DISEASE_${disease.id}`"
          :lat-lng="[disease.lat, disease.lon]"
          :radius="returnRadius(disease.radius)"
          fill-color="red"
          color="red"
        />
        <l-polyline
          v-for="movement in returnMovements"
          :key="`MOVEMENT${movement.id}`"
          :lat-lngs="returnLine(movement)"
          color="blue"
        ></l-polyline>
        <l-marker
          v-for="breeding in returnBreedings"
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
    <v-container v-else fluid fill-height>
      <v-row justify="center" align="center">
        <v-col class="text-center"
          ><v-progress-circular color="primary" indeterminate size="64"
        /></v-col>
      </v-row>
    </v-container>
  </Wrapper>
</template>

<script>
import { icon } from 'leaflet'
export default {
  data: () => {
    return {
      data: {
        beehives: [],
        apiaryStands: [],
        breedings: [],
        diseases: [],
        migrations: [],
      },
      map: {
        zoom: 9,
        center: [46.15108, 14.80513],
      },
      mapOptions: {
        zoomControl: false,
      },
      filter: {
        beehives: true,
        apiaryStands: false,
        breedings: false,
        afb: false,
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
        iconSize: [15, 20],
        iconAnchor: [10, -15],
      }),
      apiaryStandIcon: icon({
        iconUrl: 'https://priot.io/img/icons/icn_apiary_stand.svg',
        iconSize: [15, 20],
        iconAnchor: [10, -15],
      }),
      breedingIcon: icon({
        iconUrl: 'https://priot.io/img/icons/icn_queens.svg',
        iconSize: [15, 20],
        iconAnchor: [10, -15],
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
    await this.$axios.get('/beehives/?skip=1000&limit=250').then((res) => {
      this.data.beehives = res.data
    })
    await this.$axios.get('/beestands/?skip=600&limit=250').then((res) => {
      this.data.apiaryStands = res.data
    })
    await this.$axios.get('/breedings/?limit=150').then((res) => {
      this.data.breedings = res.data
    })
    await this.$axios.get('/diseases/?limit=20').then((res) => {
      this.data.diseases = res.data
    })
    await this.$axios.get('/movements/?limit=1000').then((res) => {
      this.data.movements = res.data
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

    returnBeehives() {
      return this.filter.beehives ? this.data.beehives : []
    },
    returnBreedings() {
      return this.filter.breedings ? this.data.breedings : []
    },
    returnApiaryStands() {
      return this.filter.apiaryStands ? this.data.apiaryStands : []
    },
    returnDiseases() {
      return this.filter.afb ? this.data.diseases : []
    },
    returnMovements() {
      if (this.filter.migrations.value) {
        let movements = this.data.movements
        if (this.filter.migrations.from) {
          movements = movements.filter((movement) => {
            return movement.date >= this.filter.migrations.from
          })
        }
        if (this.filter.migrations.to) {
          movements = movements.filter((movement) => {
            return movement.date < this.filter.migrations.to
          })
        }
        return movements
      } else {
        return []
      }
    },
  },
  methods: {
    centerUpdated(center) {
      this.center = center
    },
    returnRadius(item) {
      const value = 10 * this.map.zoom

      const radius = item / value
      return radius
    },
    returnLine(item) {
      return [
        [item.start_lat, item.start_lon],
        [item.end_lat, item.end_lon],
      ]
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
