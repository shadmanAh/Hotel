import Vuex from 'vuex'

export default new Vuex.Store({
  state: {
    count: 5,
    todos: [
      { id: 1, text: '...', done: true },
      { id: 2, text: '...', done: true },
      { id: 2, text: '...', done: false }
    ]
  },
  mutations: {
    increment (state) {
      state.count++
    }
  },
  getters: {
    doneTodos (state) {
      return state.todos.filter(todo => todo.done)
    }
  }
})


