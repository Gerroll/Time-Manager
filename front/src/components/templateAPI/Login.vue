<template>
    <div id="Login">
    <div class="form">
      <h1 class="titre">Welcome to the Gotham City hall website.</h1>
    <br>
    <br>
    <div id="login">
    <div id="description">
      <h1>Login</h1>
      <a href="/template" ><p>Sign Up.</p></a>
    </div>
            <!-- <form class="container" @submit="login">
                <div class="form-group">
                    <div>
                        <label for="exampleInputEmail1">Email Address</label>
                    </div>
                    <div>
                        <input type="text" placeholder="email" v-model="loginEmail">
                    </div>
                </div>
                <div class="form-group">
                    <div>
                        <label for="exampleInputPassword1">Password</label>
                    </div>
                    <div>
                        <input type="password" placeholder="password" v-model="loginPass">
                    </div>
                </div>
                <button>Login</button> {{ loginErrMsg }}
            </form> -->


    <div id="form">
      <form @submit="login">
        <label for="email">Email</label>
        <input type="text" placeholder="email" v-model="loginEmail">

        <label for="password">Password</label>&nbsp;
        <i class="fas" :class="[passwordIcon]" @click="hidePassword = !hidePassword"></i>
        <input type="password" placeholder="password" v-model="loginPass">
        <button>Login</button>
        {{ loginErrMsg }}

      </form>
    </div>
  </div>
    </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'Login',
    methods: {
        login(e) {
            e.preventDefault();
            console.log(this.loginEmail)
            if (this.loginEmail && this.loginPass)
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

  .Login {
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

 * {
  box-sizing: border-box;
  font-family: 'Nunito', sans-serif;
}

html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
  width: 100%;
}

div#Login {
  width: 100%;
  height: 100%;
}

div#Login div#login {
  align-items: center;
  background-color: #39393a;
  display: flex;
  justify-content: center;
  width: 100%;
  height: 100%;
}

div#Login div#login div#description {
  background-color: #707070;
  width: 280px;
  padding: 35px;
}

div#Login div#login div#description h1,
div#Login div#login div#description p {
  margin: 0;
}

div#Login div#login div#description p {
  font-size: 0.8em;
  color: #95a5a6;
  margin-top: 10px;
}

div#Login div#login div#form {
  background-color: #181818;
  border-radius: 5px;
  box-shadow: 0px 0px 30px 0px #666;
  color: #ecf0f1;
  width: 260px;
  padding: 35px;
}

div#Login div#login div#form label,
div#Login div#login div#form input {
  outline: none;
  width: 100%;
}

div#Login div#login div#form label {
  color: #95a5a6;
  font-size: 0.8em;
}

div#Login div#login div#form input {
  background-color: transparent;
  border: none;
  color: #ecf0f1;
  font-size: 1em;
  margin-bottom: 20px;
}

div#Login div#login div#form ::placeholder {
  color: #ecf0f1;
  opacity: 1;
}

div#Login div#login div#form button {
  background-color: #ffffff;
  cursor: pointer;
  border: none;
  padding: 10px;
  transition: background-color 0.2s ease-in-out;
  width: 100%;
}

div#Login div#login div#form button:hover {
  background-color: #eeeeee;
}

@media screen and (max-width: 600px) {
  div#Login div#login {
    align-items: unset;
    background-color: unset;
    display: unset;
    justify-content: unset;
  }

  div#Login div#login div#description {
    margin: 0 auto;
    max-width: 350px;
    width: 100%;
  }

  div#Login div#login div#form {
    border-radius: unset;
    box-shadow: unset;
    width: 100%;
  }

  div#Login div#login div#form form {
    margin: 0 auto;
    max-width: 280px;
    width: 100%;
  }
}
</style>
