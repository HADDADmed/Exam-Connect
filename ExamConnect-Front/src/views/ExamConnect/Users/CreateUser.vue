<script >
import UsersService from '../../../services/users.service';
     export default {
          data(){
               return{
                    newUser:{
                         fullName:'',
                         email:'',
                         password:'',
                         password_confirmation:''
                    }
               }
          },methods:{
               createUser(){
                if(!(this.globalService.passwordValidation(this.newUser.password,this.newUser.password_confirmation))){
                    return
                }else
                {
                     this.globalService.showConfirmMessage('you want to confirm creating this User ?').then(res=>{
                          if(res.value){
                               UsersService.createUser(this.newUser).then(res=>{
                                    this.globalService.toasterShowSuccess('User Created Successfully')
                                    this.$router.push({name:'examconnect-users-list'})
                               }).catch(err=>{
                                    this.globalService.errorMessage('Error Creating User')
                               })
                          }
                     })
                }

               
          }
     }
}
 
</script>

<template>
     <!-- Hero -->
     <BasePageHeading
          title="add New ticket"
          subtitle="Pleas fill the form belong then send."
     >
          <template #extra>
               <nav aria-label="breadcrumb">
                    <ol class="breadcrumb breadcrumb-alt">
                         <li class="breadcrumb-item">
                              <a class="link-fx" href="javascript:void(0)"
                                   >Users</a
                              >
                         </li>
                         <li class="breadcrumb-item" aria-current="page">
                              new-User
                         </li>
                    </ol>
               </nav>
          </template>
     </BasePageHeading>
     <!-- END Hero -->

     <!-- Page Content -->
     <div class="content">
          <!-- Tiptap -->
          <BaseBlock title="add New User    " content-full>
               <div class="row">
                    <div class="col-lg-12 mx-auto pb-4">
                         <div class="card mt-2 mx-auto p-4">
                              <div class="card-body">
                                   <div class="container">
                                        <form
                                             @submit.prevent="createUser()"
                                             id="contact-form"
                                             role="form"
                                        >
                                             <div class="controls">
                                                  <div class="row">
                                                       <div class="col-md-6">
                                                            <div
                                                                 class="form-group animated bounceInRight"
                                                            >
                                                                 <label
                                                                      for="form_fullName"
                                                                      >Full Name
                                                                      *</label
                                                                 >
                                                                 <input
                                                                      id="form_fullName"
                                                                      type="text"
                                                                      
                                                                      class="form-control form-control-alt"
                                                                      placeholder="enter the User full Name *"
                                                                      required="required"
                                                                      data-error="Firstname is required."
                                                                      v-model="newUser.fullName"
                                                                 />
                                                            </div>
                                                       </div>
                                                       <div class="col-md-6">
                                                            <div
                                                                 class="form-group animated bounceInLeft"
                                                            >
                                                                 <label
                                                                      for="form_email"
                                                                      >Email
                                                                      *</label
                                                                 >
                                                                 <input
                                                                      id="form_email"
                                                                      type="email"
                                                                      name="email"
                                                                     
                                                                      class="form-control form-control-alt"
                                                                      placeholder="Please enter your email *"
                                                                      required="required"
                                                                      data-error="Valid email is required."
                                                                      v-model="newUser.email"
                                                                 />
                                                            </div>
                                                       </div>
                                                  </div>
                                                   
                                                  <div
                                                       class="row"
                                                       style="margin-top: 30px"
                                                  >
                                                       <div class="col-md-6">
                                                            <div
                                                                 class="form-group animated bounceInLeft"
                                                            >
                                                                 <label
                                                                      for="form_password"
                                                                      >Access
                                                                      Pasword
                                                                      *</label
                                                                 >
                                                                 <input
                                                                      id="form_password"
                                                                      
                                                                      type="password"
                                                                      name="empasswordail"
                                                                      class="form-control form-control-alt"
                                                                      placeholder="enter the User Access Pasword *"
                                                                      required="required"
                                                                      data-error="Pleas enter the Pasword."
                                                                      v-model="newUser.password"
                                                                 />
                                                            </div>
                                                       </div>
                                                       <div class="col-md-6">
                                                            <div
                                                                 class="form-group animated bounceInRight"
                                                            >
                                                                 <label
                                                                      for="form_passwordConfirmation"
                                                                      >Confirm
                                                                      Pasword
                                                                      *</label
                                                                 >
                                                                 <input
                                                                      id="form_passwordConfirmation"
                                                                      type="password"
                                                                       
                                                                      name="passwordConfirmation"
                                                                      class="form-control form-control-alt"
                                                                      placeholder="comfirm the Access Pasword *"
                                                                      required="required"
                                                                      data-error="Pleas enter the Pasword comfirmation."
                                                                      v-model="newUser.password_confirmation"
                                                                 />
                                                            </div>
                                                       </div>
                                                  </div>

                                                  <div
                                                       class="col-md-12 d-flex justify-conetent-center animated bounceInUp"
                                                       style="
                                                            margin-top: 30px;
                                                            margin-left: 50px;
                                                       "
                                                  >
                                                       <input
                                                            type="submit"
                                                            class="btn btn-send pt-2 btn-block submitButton"
                                                            value="Create The User"
                                                       />
                                                  </div>
                                             </div>
                                        </form>
                                   </div>
                              </div>
                         </div>
                         <!-- /.8 -->
                    </div>
                    <!-- /.row-->
               </div>
          </BaseBlock>

          <!-- END Tiptap -->
     </div>
     <!-- END Page Content -->
</template>

<style scoped>
.User {
     color: green;
}
.Admin {
     color: red;
     font-size: large;
}
body {
     font-family: "Lato", sans-serif;
}

h1 {
     margin-bottom: 40px;
}

label {
     color: #333;
}

.btn-send {
     font-weight: 300;
     text-transform: uppercase;
     letter-spacing: 0.2em;
     width: 80%;
     margin-left: 3px;
}
.help-block.with-errors {
     color: #ff5050;
     margin-top: 5px;
}

.card {
     margin-left: 10px;
     margin-right: 10px;
}
.submitButton {
     background: #003366;
     font-size: 30px;
     font-weight: 700;
     letter-spacing: 3px;
     line-height: 1em;
     color: white;
}
</style>
