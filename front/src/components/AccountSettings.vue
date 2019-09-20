<template>
  <div class="account">
    <h1>Account Settings</h1>

    <div id="info">
      <p>On this page, each employee can edit their account information, or even delete it.</p>
    </div>

    <div class="form">
      <h1>Modify your profile here!</h1>

      <form class="container">
        <div class="form-group">
          <label for="exampleInputEmail1">Email Address</label>
          <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                 placeholder="Enter Email">
        </div>
        <div class="form-group">
          <label for="exampleInputPassword1">Password</label>
          <input type="password" class="form-control" id="exampleInputPassword1"
                 placeholder="Enter Password">
        </div>
        <button id="btn_edit" type="submit" class="btn btn-outline-dark btn-lg">Edit</button>
      </form>
    </div>

    <div>
      <h1>If you want to delete your account, click on this button.</h1>
      <button id="btn_delete" class="btn btn-dark btn-lg">Delete</button>
    </div>

  </div>
</template>

<script>
    export default {
        name: "AccountSettings"
    }
</script>

<style scoped>
  .account {
    text-align: center;
  }

  h1 {
    margin-top: 3%;
    margin-bottom: 2%;
    font-family: "DejaVu Math TeX Gyre";
  }

  #info {
    font-size: large;
    margin-bottom: 3%;
  }

  .form {
    background-color: #9f9f9f;
    color: white;
    padding: 2%;
  }

  #btn_edit {
    width: 15%;
  }

  #btn_delete {
    width: 15%;
  }
</style>
