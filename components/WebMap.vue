<template>
  <div class="map-view"></div>
</template>

<script>
import config from '@arcgis/core/config'
import ArcGISMap from '@arcgis/core/WebMap'
import MapView from '@arcgis/core/views/MapView'
export default {
  data: () => {
    return {}
  },
  mounted() {
    config.apiKey = '13df88da698d482f99f770d22f3bd9d9'
    const map = new ArcGISMap({
      basemap: 'arcgis-topographic', // Basemap layer service
    })

    const view = new MapView({
      map,
      center: [-118.805, 34.027], // Longitude, latitude
      zoom: 13, // Zoom level
      container: '"map-view', // Div element
    })

    view.when(() => console.log('View Ready'))
  },
}
</script>
<style scoped>
@import url('https://js.arcgis.com/4.21/esri/themes/light/main.css');
.map-view {
  height: 100%;
  width: 100%;
}
</style>
