<template>
    <div id="login">
        <div class="form">
            <h1 class="titre">Welcome to the Gotham City hall website.</h1>
            <br>
            <br>
            <form class="container" @submit="login">
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
            </form>
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

@media screen and (max-width: 708px) {
    #logo img {
        width: 30%;
    }
}
</style>
