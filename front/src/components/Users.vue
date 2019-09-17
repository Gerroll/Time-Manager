<template>
  <div class="users">
    <span v-for="user in users" :key="user.id">
        <p>id: {{ user.id }}</p>
        <p>username: {{ user.username }}</p>
        <p>email: {{ user.email }}</p>
    </span>
    <h3>Créer un utilisateur</h3>


<div class="container">
  <form>
    <div class="form-group">
      <label>Votre Prénom</label>
      <input type="text" class="form-control" placeholder="Prénom" v-model="new_user.username">
    </div>

    <div class="form-group">
      <label for="exampleInputEmail1">Adresse Email</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Entrez votre Email" v-model="new_user.email">
      <small id="emailHelp" class="form-text text-muted">Nous ne partagerons jamais votre courriel avec qui que ce soit d'autre.</small>
    </div>
    <button type="submit" class="btn btn-primary">Envoyer</button>
  </form>
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
