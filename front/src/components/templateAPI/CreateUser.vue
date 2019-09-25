<template>
    <div id="CreateUser">
   <div id="Login">
    <div class="form">
    <br>
    <br>
    <div id="axiomGET">
            USER LIST: 
            <button v-on:click=userList>userList</button> {{ data }}
            <li v-for="u in data" :key="u">
                <ul>{{ u.id }}: {{ u.email }}</ul>
            </li>
        </div>
    <div id="login">
    <div id="description">
      <h1>Sign Up</h1>
      <a href="/login" ><p>Login</p></a>
    </div>
    <div id="axiomPOST">
            <div id="createUser">
    <div id="form">
      <form @submit.prevent="doLogin">
        <label for="email">Email</label>
        <input type="email" id="email" v-model="email" placeholder="user@example.com" autocomplete="off">

        <label for="username">Username</label>
        <input type="text" id="username" v-model="username" placeholder="username" autocomplete="off">

        <label for="password">Password</label>&nbsp;
        <i class="fas" :class="[passwordIcon]" @click="hidePassword = !hidePassword"></i>
        <input :type="passwordType" id="password" v-model="password" placeholder="**********">

        <button v-on:click=createUser>CreateUser</button>

                <li v-for="(key, value) in resCreate" :key="value">
                    <ul>{{ key }}{{ value }}</ul>
                </li>
                <!-- <ul>{{ item.id }}: {{ item.name }}</ul> -->
                {{ errmsgCreateuser }}
      </form>
    </div>
  </div>
    </div>
    </div>
        </div>
    </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'CreateUser',
    methods: {
        userList() { // Basic get request
            axios.get("http://localhost:4000/user_list", {
                    crossOrigine: true,
                })
                .then(response => (this.data = response.data.data))
        },
        createUser() { // Basic post request
            if (this.password == this.password2) {
                axios.post("http://localhost:4000/api/createUser", {
                        user: {
                            email: this.email,
                            username: this.username,
                            password: this.password,
                            rank: 'employee' // employee, manager, general
                        }
                    })
                    .then(response => {
                        this.resCreate = response.data.data
                    })
                    .catch(err => { this.errmsgCreateuser = err })
                    .finally(console.log("this message allways get console.log succes/fail"))
            }
        },
        // login() {
        //     axios.post("http://localhost:4000/api/sign_in", {
        //             email: this.loginEmail,
        //             password: this.loginPass,
        //         })
        //         .then(response => {
        //             this.loginRes = response.data
        //             // console.log(response.data.token)
        //             axios.defaults.headers.common['x-xsrf-token'] = response.data.token
        //             window.location.pathname = "/"
        //         })
        //         .catch(err => { this.loginErrMsg = err })
        // }
    },
    data() {
        return {
            resCreate: null,
            data: null,
            email: null,
            username: null,
            password: null,
            password2: null,
            errmsgCreateuser: null
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