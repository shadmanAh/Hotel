import { createApp } from 'vue/dist/vue.esm-bundler'
import store from '@/store'
import ButtonCounter from '../components/ButtonCounter.vue'
import "trix"
import "@rails/actiontext"

  
const app = createApp({  
  data() {  
    return {  
      course: 'Intro to Vue 3 and Rails'  
    }  
  }  
})

app.component('ButtonCounter', ButtonCounter)
app.use(store)
app.mount('#app');  