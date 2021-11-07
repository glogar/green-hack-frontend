<template>
  <Wrapper>
    <template #extension>
      <v-toolbar-title>Personal information</v-toolbar-title>
      <v-spacer />
      <v-btn icon class="" text>
        <v-icon class="primary--text">edit</v-icon>
      </v-btn>
    </template>
    <v-sheet>
      <v-card flat class="pa-5">
        <v-row no-gutters align="center">
          <v-col cols="4">
            <v-avatar color="primary" size="80">
              <img src="https://cdn.vuetifyjs.com/images/john.jpg" />
            </v-avatar>
          </v-col>
          <v-col>
            <v-row>
              <v-card-title class="pa-0">Jan Novak</v-card-title>
            </v-row>
            <v-row class="mb-2">
              <span class="caption"
                ><span class="font-weight-medium">Subject ID: </span>
                12312</span
              >
            </v-row>
            <v-row>
              <span class="subtitle-2 font-weight-regular">Mariborksa 51</span>
            </v-row>
            <v-row>
              <span class="subtitle-2 font-weight-regular">2000 Maribor</span>
            </v-row>
            <v-row>
              <span class="caption font-weight-medium">+38651672331</span>
            </v-row>
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <v-data-table
              :headers="[
                {
                  text: 'Behive loc ID',
                  align: 'center',
                  sortable: false,
                  value: 'id',
                },
                { text: 'Num. of families', value: 'count', align: 'center' },
              ]"
              :items="items"
              hide-default-footer
              :mobile-breakpoint="0"
            ></v-data-table>
          </v-col>
        </v-row>
        <v-row class="mt-5" justify="center">
          <v-dialog v-model="dialog" width="500">
            <template #activator="{ on, attrs }">
              <v-btn class="primary" rounded v-bind="attrs" v-on="on"
                >Apply for migration</v-btn
              >
            </template>

            <v-card>
              <v-card-title class="pa-1 ma-0">
                <v-spacer />
                <v-btn icon @click="dialog = false">
                  <v-icon>close</v-icon>
                </v-btn>
              </v-card-title>

              <v-card-text class="py-1 px-3">
                Which beehive are you moving?
              </v-card-text>
              <v-col cols="12">
                <v-select
                  v-model="selected"
                  solo
                  label="Select beehive ID"
                  :items="items"
                  item-text="id"
                  hide-details
                  item-value="id"
                />
              </v-col>
              <template v-if="selected">
                <div class="px-4">
                  <span class="subtitle-1 grey--text">Current location</span>

                  <v-row class="my-0" no-gutters>
                    <span>ID: <b>396313</b></span></v-row
                  >
                  <v-row class="my-0" no-gutters>
                    <span>46.234513° 37.234235° </span>
                  </v-row>
                  <v-row class="mb-0" no-gutters>
                    <span>Parcel: <b>631/1</b></span>
                  </v-row>

                  <v-row class="my-0" no-gutters>
                    <span>Num of fammilies: <b>12</b></span>
                  </v-row>
                </div>
                <div class="px-4 mt-3">
                  <span class="subtitle-1 grey--text">Migration location</span>
                  <br />
                  <v-btn
                    v-if="!showMigration"
                    text
                    class="primary--text white px-0"
                    small
                    @click="showMigration = !showMigration"
                    ><v-icon class="mr-1">place</v-icon>Find on map</v-btn
                  >
                  <template v-else>
                    <v-row class="mb-0" no-gutters>
                      <span>ID: <b>749145</b></span>
                    </v-row>

                    <v-row class="my-0" no-gutters>
                      <span>46.234513° 37.234235° </span>
                    </v-row>
                    <v-row class="mb-0" no-gutters>
                      <span>Parcel: <b>22/13</b></span>
                    </v-row>
                  </template>
                </div>
                <v-col cols="12">
                  <v-dialog v-model="migration.dialog" width="290px">
                    <template #activator="{ on, attrs }">
                      <v-text-field
                        v-model="migration.value"
                        label="Date of migration"
                        dense
                        solo
                        prepend-inner-icon="event"
                        readonly
                        hide-details
                        v-bind="attrs"
                        v-on="on"
                      ></v-text-field>
                    </template>
                    <v-date-picker v-model="migration.value"> </v-date-picker>
                  </v-dialog>
                </v-col>
                <v-col cols="12">
                  <v-checkbox
                    label="By sending this application I am declaring that the bees are not exhibiting sign of AFB, EFB, varroa or any other apiary disease."
                  />
                </v-col>
                <v-card-actions class="py-4">
                  <v-row justify="center">
                    <v-btn
                      color="primary"
                      class="my-4"
                      rounded
                      @click="dialog = false"
                    >
                      Send application
                    </v-btn>
                  </v-row>
                </v-card-actions>
              </template>
            </v-card>
          </v-dialog>
        </v-row>
      </v-card>
    </v-sheet>
  </Wrapper>
</template>

<script>
export default {
  data: () => {
    return {
      items: [
        {
          id: '396313',
          count: 3,
        },
        {
          id: '584324',
          count: 12,
        },
        {
          id: '623416',
          count: 6,
        },
        {
          id: '345738',
          count: 2,
        },
        {
          id: '634129',
          count: 6,
        },
      ],
      dialog: false,
      selected: null,
      migration: {
        dialog: false,
        value: '',
      },
      showMigration: false,
    }
  },
}
</script>
