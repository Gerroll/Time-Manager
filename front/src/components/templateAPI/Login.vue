<template>
    <div id="login">
    <div class="form">
      <h1 class="titre">Welcome to the Gotham City hall website.</h1>
    <br>
    <br>
    <form class="container">
        <div class="form-group">
             <label for="exampleInputEmail1">Email Address</label>
            <input type="email" placeholder="email" v-model="loginEmail">
        </div>
            <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <input type="text" placeholder="password" v-model="loginPass">
            </div>
             <button v-on:click=login>Login</button> {{ loginErrMsg }}
    </form>
    </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'Login',
    methods: {
        login() {
            axios.post("http://localhost:4000/api/sign_in", {
                    crossOrigine: true,
                    email: this.loginEmail,
                    password: this.loginPass,
                })
                .then(response => {
                    localStorage.setItem('token', response.data.token)
                    localStorage.setItem('rank', response.data.rank)
                    axios.defaults.headers.common['x-xsrf-token'] = response.data.token
                    this.$router.push('/user/home')
                })
                .catch(err => {
                    console.log(err)
                    this.loginErrMsg = err.response.data
                })
        }
    },
    data() {
        return {
            loginEmail: null,
            loginPass: null,
            loginErrMsg: null
        }
    }
}
</script>

<style scoped>
  .login {
    text-align: center;
    font-family: "DejaVu Math TeX Gyre";
  }

  #logo {
    padding: 2%;
  }

  .form {
      text-align: center;
    background-color: black;
    color: white;
    padding: 5%;
  }

  .infos {
    background-color: #9f9f9f;
    color: white;
    padding: 5%;
    font-size: 26px;
  }




  @media screen and (max-width: 708px)
  {
    #logo img {
      width: 30%;
    }
  }
</style>
