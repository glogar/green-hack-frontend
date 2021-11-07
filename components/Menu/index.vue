<template>
  <v-menu
    v-model="menu"
    offset-y
    class="mt-3"
    min-width="350"
    nudge-bottom="10"
    :close-on-click="false"
    :close-on-content-click="false"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        icon
        class="white"
        text
        dark
        v-bind="attrs"
        fab
        small
        elevation="3"
        v-on="on"
      >
        <v-icon class="primary--text">filter_list</v-icon>
      </v-btn>
    </template>

    <v-card class="mx-auto">
      <v-card-title class="py-1 px-2 ma-0 primary white--text subtitle-2"
        ><v-row no-gutters align="center">
          Filters <v-spacer />
          <v-btn icon @click="menu = false"
            ><v-icon class="white--text">expand_less</v-icon></v-btn
          ></v-row
        ></v-card-title
      >
      <v-list dense class="px-1 pb-2">
        <v-list-item-group color="primary">
          <MenuCheckBox
            v-model="filter.beehives"
            label="Beehives"
            url="https://priot.io/img/icons/icn_beehive.svg"
          />
          <MenuCheckBox
            v-model="filter.apiaryStands"
            label="Apiary stands"
            url="https://priot.io/img/icons/icn_apiary_stand.svg"
          />
          <MenuCheckBox
            v-model="filter.breedings"
            label="Breeding farms"
            url="https://priot.io/img/icons/icn_queens.svg"
          />
          <MenuCheckBox v-model="filter.afb" label="American foulbrood (AFB)" />

          <v-divider class="my-2" />
          <v-row no-gutters>
            <v-btn text small @click="advanced = !advanced">
              <v-icon>{{ advanced ? 'expand_more' : 'expand_less' }}</v-icon
              >Advanced
            </v-btn>
          </v-row>
          <template v-if="advanced">
            <MenuCheckBox
              v-model="filter.migrations.value"
              label="Beehive migration plot"
            />
            <v-row no-gutters class="pa-1">
              <v-col cols="6">
                <v-dialog v-model="migrationsDialogFrom" width="290px">
                  <template #activator="{ on, attrs }">
                    <v-text-field
                      v-model="filter.migrations.from"
                      label="From"
                      dense
                      solo
                      prepend-inner-icon="event"
                      readonly
                      clearable
                      :disabled="!filter.migrations.value"
                      hide-details
                      v-bind="attrs"
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="filter.migrations.from">
                  </v-date-picker>
                </v-dialog>
              </v-col>
              <v-col cols="6">
                <v-dialog v-model="migrationsDialogTo" width="290px">
                  <template #activator="{ on, attrs }">
                    <v-text-field
                      v-model="filter.migrations.to"
                      label="To"
                      dense
                      solo
                      clearable
                      :disabled="!filter.migrations.value"
                      prepend-inner-icon="event"
                      readonly
                      hide-details
                      v-bind="attrs"
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="filter.migrations.to">
                  </v-date-picker>
                </v-dialog>
              </v-col>
            </v-row>

            <MenuCheckBox
              v-model="filter.history.value"
              label="AFB outbreak history"
            />
            <v-row no-gutters class="pa-1">
              <v-col cols="6">
                <v-dialog v-model="historyDialogFrom" width="290px">
                  <template #activator="{ on, attrs }">
                    <v-text-field
                      v-model="filter.history.from"
                      label="From"
                      dense
                      solo
                      :disabled="!filter.history.value"
                      prepend-inner-icon="event"
                      readonly
                      hide-details
                      v-bind="attrs"
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="filter.history.from"> </v-date-picker>
                </v-dialog>
              </v-col>
              <v-col cols="6">
                <v-dialog v-model="historyDialogTo" width="290px">
                  <template #activator="{ on, attrs }">
                    <v-text-field
                      v-model="filter.history.to"
                      label="To"
                      dense
                      solo
                      :disabled="!filter.history.value"
                      prepend-inner-icon="event"
                      readonly
                      hide-details
                      v-bind="attrs"
                      v-on="on"
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="filter.history.to"> </v-date-picker>
                </v-dialog>
              </v-col>
            </v-row>
          </template>
        </v-list-item-group>
      </v-list>
    </v-card>
  </v-menu>
</template>

<script>
export default {
  props: {
    value: {
      type: Object,
      required: true,
    },
  },
  data: () => {
    return {
      menu: false,
      advanced: false,
      migrationsDialogFrom: false,
      migrationsDialogTo: false,
      historyDialogFrom: false,
      historyDialogTo: false,
    }
  },
  computed: {
    filter: {
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
