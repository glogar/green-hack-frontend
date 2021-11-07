<template>
  <v-card flat min-height="16vh">
    <v-row justify="end" align="center">
      <v-card-title class="pa-0 primary--text subtitle-2">{{
        stand ? 'Apiary stand' : 'Beehive'
      }}</v-card-title>
      <v-spacer />
      <v-btn v-if="window !== 'main'" icon text @click="window = 'main'">
        <v-icon class="primary--text" small>chevron_left</v-icon>
      </v-btn>
      <v-btn
        v-if="window === 'main' && !stand"
        icon
        text
        @click="window = 'location'"
      >
        <v-icon class="primary--text" small>my_location</v-icon>
      </v-btn></v-row
    >
    <template v-if="!stand">
      <div v-if="window === 'location'" class="pa-0 ma-0">
        <v-row
          class="text--center pt-4"
          no-gutters
          align="center"
          justify="center"
        >
          Set current location as this beehive's location.</v-row
        >
        <v-row align="center" justify="center" class="my-2">
          <v-btn
            rounded
            class="my-1"
            small
            :class="setLocation ? 'success' : 'primary'"
            @click="setLocation = !setLocation"
          >
            <v-icon v-if="setLocation" small class="mr-1">check</v-icon>
            <b>{{ setLocation ? 'Location set' : 'Set' }}</b>
          </v-btn>
        </v-row>
      </div>

      <div v-if="window === 'main'" class="pa-0 ma-0">
        <v-row class="mb-0">
          <span>Location: <b>Sinja gorica</b></span>
        </v-row>
        <v-row class="my-0">
          <span
            >ID: <b>{{ item.id }}</b></span
          ></v-row
        >
        <v-row class="my-0">
          <span>{{ item.lat }}° {{ item.lon }}° </span>
        </v-row>
        <v-row class="my-0">
          <span>Weather: no</span>
        </v-row>
        <v-row align="center" justify="center">
          <v-btn rounded class="error my-1" small @click="window = 'report'">
            <b>Report disease</b>
          </v-btn>
        </v-row>
      </div>

      <div v-if="window === 'report'" class="pa-0 ma-0">
        <MenuCheckBox label="American foulbrood (AFB)" />
        <MenuCheckBox label="European foulbrood (EFB)" />
        <MenuCheckBox label="Amebiosis" />
        <MenuCheckBox label="Varroa" />
        <MenuCheckBox label="Chalkbrood" />
        <v-row align="center" justify="center" class="my-2">
          <v-btn rounded class="error" small>
            <b>Report </b>
          </v-btn>
        </v-row>
        <v-row no-gutters justify="center">
          <p class="caption ma-0">This will notify beekepers nerby</p>
        </v-row>
      </div>
    </template>
    <!-- APIARY STAND -->
    <template v-else>
      <div class="pa-0 mt-2">
        <v-row class="mb-0">
          <span>Location: <b>Sinja gorica</b></span>
        </v-row>
        <v-row class="my-0">
          <span
            >ID: <b>{{ item.id }}</b></span
          ></v-row
        >
        <v-row class="my-0">
          <span>{{ item.lat }}° {{ item.lon }}° </span>
        </v-row>
        <v-row class="my-0">
          <span>Weather: no</span>
        </v-row>
        <v-row class="my-0">
          <span>Availability: {{ returnAvailability }}</span>
        </v-row>
        <v-row v-if="window === 'main'" align="center" justify="center">
          <v-btn rounded class="primary my-1" small @click="window = 'report'">
            <b>Book stand</b>
          </v-btn>
        </v-row>
      </div>
      <div v-if="window === 'report'" class="pa-0 ma-0">
        <v-row class="mt-2">
          <v-col cols="12">
            <v-dialog v-model="from.dialog" width="290px">
              <template #activator="{ on, attrs }">
                <v-text-field
                  v-model="from.value"
                  label="From"
                  dense
                  solo
                  prepend-inner-icon="event"
                  readonly
                  hide-details
                  v-bind="attrs"
                  v-on="on"
                ></v-text-field>
              </template>
              <v-date-picker v-model="from.value"> </v-date-picker>
            </v-dialog>
          </v-col>
          <v-col cols="12">
            <v-dialog v-model="to.dialog" width="290px">
              <template #activator="{ on, attrs }">
                <v-text-field
                  v-model="to.value"
                  label="From"
                  dense
                  solo
                  prepend-inner-icon="event"
                  readonly
                  hide-details
                  v-bind="attrs"
                  v-on="on"
                ></v-text-field>
              </template>
              <v-date-picker v-model="to.value"> </v-date-picker>
            </v-dialog>
          </v-col>
        </v-row>
        <v-row align="center" justify="center">
          <v-card-text class="pa-0 ma-0">
            Number of slots
            <v-slider
              v-model="slots"
              step="1"
              :max="15"
              :min="1"
              tick-size="4"
              thumb-label
            ></v-slider>
          </v-card-text>
        </v-row>
        <v-row
          v-if="window === 'report'"
          align="center"
          justify="center"
          class="my-3"
        >
          <v-btn rounded class="primary" small @click="window = 'main'">
            <b>Book</b>
          </v-btn>
        </v-row>
      </div>
    </template>
  </v-card>
</template>

<script>
export default {
  props: {
    stand: {
      type: Boolean,
      default: false,
    },
    item: {
      type: Object,
      default: null,
    },
  },
  data: () => {
    return {
      window: 'main',
      setLocation: false,
      from: {
        dialog: false,
        value: '',
      },
      to: {
        dialog: false,
        value: '',
      },
      slots: 0,
    }
  },
  computed: {
    returnAvailability() {
      const value = 1 - this.item.occupancy.toFixed(2)
      return `${value.toFixed(2) * 100}%`
    },
  },
}
</script>

<style></style>
