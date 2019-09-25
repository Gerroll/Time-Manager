<template>
  <div class="users">

    <div id="logo">
      <img src="../assets/gotham.png" alt="logo" width="15%"/>
    </div>

    <div class="div_form">
      <h1 class="titre">The General Manager</h1>

      <form class="container form_user">
        <h3>Account Settings</h3>
        <div class="form-group">
          <label for="exampleInputPassword1">Name</label>
          <input type="text" class="form-control" placeholder="Enter Name">
        </div>
        <div class="form-group">
          <label for="exampleInputEmail1">Email Address</label>
          <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                 placeholder="Enter Email">
        </div>
        <button type="submit" class="btn btn-dark">Edit</button>

        <div id="buttons">
          <button type="submit" class="btn btn-light">Promote</button>
          <button id="btn_view" type="submit" class="btn btn-dark">View</button>
          <button type="submit" class="btn btn-light">Delete</button>
        </div>
      </form>
    </div>


    <span v-for="user in users" :key="user.id">
        <p>id: {{ user.id }}</p>
        <p>username: {{ user.username }}</p>
        <p>email: {{ user.email }}</p>
    </span>
    <h3 style="text-align: center">Créer un utilisateur</h3>


    <div class="container">
      <form>
        <div class="form-group">
          <label>Votre Prénom</label>
          <input type="text" class="form-control" placeholder="Prénom" v-model="new_user.username">
        </div>

        <div class="form-group">
          <label for="exampleInputEmail1">Adresse Email</label>
          <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                 placeholder="Entrez votre Email" v-model="new_user.email">
          <small id="emailHelp" class="form-text text-muted">Nous ne partagerons jamais votre courriel avec qui que ce
            soit d'autre.</small>
        </div>
        <button type="submit" class="btn btn-primary">Ajouter</button>
      </form>
    </div>

  </div>
</template>

<script>
    import axios from "axios";

    export default {

        name: 'General_Manager',

        data() {
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
                axios.get(process.env.ROOT_API + "/api/users", {crossOrigin: true})
                    .then(resp => {
                        console.log(resp);
                        this.users = resp.data.data;
                        console.log(resp);
                    }).catch(err => {
                    console.log(err);
                });
            },
            createUser() {
                axios.post(process.env.ROOT_API + "/api/users", {users: this.new_user}, {crossOrigine: true})
                    .then(result => {
                        this.error = "";
                        this.list_user = result.data.data;
                    })
                    .catch((err, data) => {
                        this.error = err.response.data.errors;
                    });
            }
        }
    }
</script>

<style scoped>
  .users {
    text-align: center;
    font-family: "DejaVu Math TeX Gyre";
  }

  #logo {
    padding: 2%;
  }

  .div_form {
    background-color: black;
    color: white;
    padding: 5%;
  }

  .form_user {
    background-color: #9f9f9f;
    padding: 4%;
  }

  #buttons {
    margin: 4%;
  }

  #btn_view {
    margin-left: 10%;
    margin-right: 10%;
  }



  @media screen and (max-width: 708px)
  {
    #buttons {
      display: grid;
      margin-top: 10%;
    }
    #btn_view {
      margin-top: 5%;
      margin-bottom: 5%;
    }

    #logo img {
      width: 30%;
    }
  }
</style>
