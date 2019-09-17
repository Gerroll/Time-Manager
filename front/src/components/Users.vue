<template>
  <div class="users">
    <span v-for="user in users" :key="user.id">
        <p>id: {{ user.id }}</p>
        <p>username: {{ user.username }}</p>
        <p>email: {{ user.email }}</p>
    </span>
    <div>
        <h3>Create a user</h3>
        <input type="text" placeholder="Username" v-model="new_user.username">
        <br>
        <input type="email" placeholder="Email" v-model="new_user.email">
        <br>
        <button @click="createUser()">submit</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {

  name: 'Users',

  data () {
    return {
        users: {},
        new_user: {username: "", email: ""}
    }
  },

  created() {
      this.getAll()
  },

  watch: {
      $route: "getAll"
  },

  methods: {
    getAll() {
        axios.get("http://localhost:4000/api/users", { crossOrigin: true })
        .then(resp => {
            console.log(resp);
            this.users = resp.data.data;
            console.log(resp);
        }).catch(err => {
            console.log(err);
        });
    },
    createUser() {
        axios.post("http://localhost:4000/api/users", { users:this.new_user }, { crossOrigine:true })
        .then(result=> { this.error=""; this.list_user=result.data.data;})
        .catch((err, data) => { this.error=err.response.data.errors;});
    }
  }
}
</script>