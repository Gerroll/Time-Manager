<template>
    <div class="tplIn">
        <nav class="navbar navbar-dark bg-dark">
            <a class="navbar-brand" href="/">Time-Manager</a>
            <div class="w3-xlarge text-light">
                <router-link to="/dashboard">Dashboard</router-link> |
                <router-link to="/profile">Profile</router-link> |
                <span v-if="this.manager"><router-link v-if="this.manager" to="team">Manage teams</router-link> | </span>
                <span v-if="this.general"><router-link v-if="this.general" to="accountSetting">Accounts Settings</router-link> | </span>
                <a v-on:click.stop="logOut()" href="">Log out</a>
            </div>
        </nav>

        <router-view></router-view>
    
        <div id="town">
            <img src="@/assets/bulding.jpeg" alt="town" />
        </div>
        <footer>
            <p>© 2019 | Tous droits réservés. The Gotham town hall</p>
        </footer>
    </div>
</template>

<script>
export default {
    name: "templateIn",
    data() {
        return {
            manager: null,
            general: null,
        }
    },
    mounted() {
        this.getRank();
    },
    methods: {
        getRank() {
            const rank = localStorage.getItem("rank");
            if (rank === "manager") this.manager = true;
            else if (rank === "general") {
                this.manager = true;
                this.general = true;
            }
        },
        redirectDashboard() {
            this.$router.push("/user/dashboard");
        },
        redirectProfile() {
            this.$router.push("/user/profile");
        },
        redirectManageTeam() {
            this.$router.push("/manager/team");
        },
        logOut(m, e) {
            localStorage.setItem("token", null);
            localStorage.setItem("rank", null);
            this.$router.push("/login");
        }
    }
};
</script>

<style scoped>
a {
    color: white;
}

a:hover {
    color: darkgrey;
}

#town {
    margin-top: 5%;
    text-align: center;
}

.link {
    display: flex;
    justify-content: center;
}

footer .link a {
    margin: 3%;
}

footer {
    background-color: black;
    color: white;
}

footer p {
    margin-bottom: 0;
    text-align: center;
}

@media screen and (max-width: 650px) {
    footer a {
        display: contents;
    }
    footer .link {
        margin-bottom: 5%;
    }
}

@media screen and (max-width: 708px) {
    #town img {
        display: none;
    }
}
</style>
