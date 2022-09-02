<template>  
  <button @click="count++" class="btn btn-success">You clicked me {{ count }} times.</button>
  <p v-for="done in doneTodos" :key="done.id">{{done}}</p>
</template> 

<script>
import store from '../store/index'
import { mapGetters } from 'vuex'

export default {
  data(){
    return{
      count: store.state.count,
    }
  },
  computed: {
    ...mapGetters(['doneTodos'])
  }
}  
console.log(store.state.count)
</script>  
  