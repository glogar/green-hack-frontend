<template>
  <Wrapper>
    <v-sheet>
      <v-list nav dense>
        <v-list-item
          v-for="(item, i) in items"
          :key="i"
          @click="handleClick(item)"
        >
          <v-list-item-icon>
            <v-icon v-text="item.icon"></v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title v-text="item.text"></v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-sheet>
    <v-dialog v-model="notificationsDialog" width="290px">
      <v-card class="pa-3">
        <v-card-title class="pa-1 ma-0 grey--text subtitle-2">
          Notifications
          <v-spacer />
          <v-btn icon @click="notificationsDialog = false">
            <v-icon>close</v-icon>
          </v-btn>
        </v-card-title>
        <v-row no-gutters>
          <MenuCheckBox
            v-model="notifications.text"
            label="Notify me via text message"
          />
          <MenuCheckBox
            v-model="notifications.push"
            label="Notify me via push notifications"
          />
        </v-row>
      </v-card>
    </v-dialog>
  </Wrapper>
</template>

<script>
export default {
  data: () => {
    return {
      notificationsDialog: false,
      notifications: {
        text: false,
        push: true,
      },
      selectedItem: 0,
      items: [
        { text: 'Password change', icon: 'key' },
        { text: 'Add ceertificate', icon: 'card_membership' },
        { text: 'Notifications', icon: 'notifications' },
        { text: 'Accessibility', icon: 'accessibility' },
        { text: 'Email settings', icon: 'email' },
        { text: 'Logout', icon: 'logout' },
      ],
    }
  },
  methods: {
    handleClick(event) {
      if (event.icon === 'notifications') {
        this.notificationsDialog = !this.notificationsDialog
      }
    },
  },
}
</script>
