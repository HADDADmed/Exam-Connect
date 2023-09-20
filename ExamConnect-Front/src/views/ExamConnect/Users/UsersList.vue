<script>
import UsersService from "../../../services/users.service";
export default {
     data() {
          return {
               users: [],
          };
     },
     mounted() {
          this.getUsers();
     },
     methods: {
          getUsers() {
               UsersService.getAllUsers().then((response) => {
                    this.users = response.data;
               });
          },
          deleteUser(id) {
               this.globalService
                    .showConfirmMessage(" you want to delete this user?")
                    .then(() => {
                         UsersService.deleteUserById(id).then((response) => {
                              this.users = this.users.filter((user) => {
                                   return user.id != id;
                              });
                              this.globalService.toasterShowSuccess(
                                   "User deleted successfully"
                              );
                         });
                    });
          },
     },
     mounted() {
          this.getUsers();
     },
};
</script>

<template>
     <!-- Hero -->
     <BasePageHeading title="Users List">
          <template #extra>
               <nav aria-label="breadcrumb">
                    <ol class="breadcrumb breadcrumb-alt">
                         <li class="breadcrumb-item">
                              <a class="link-fx" href="javascript:void(0)"
                                   >Users</a
                              >
                         </li>
                         <li class="breadcrumb-item" aria-current="page">
                              Users-List
                         </li>
                    </ol>
               </nav>
          </template>
     </BasePageHeading>
     <!-- Page Content -->
     <div class="content">
          <BaseBlock
               :title="`  User in Total`"
               content-full
               class="animated zoomIn"
          >
               <template #options>
                    <div class="space-x-1">
                         <button
                              type="button"
                              class="btn btn-sm btn-alt-secondary"
                              @click="
                                   () => {
                                        orderSearch = !orderSearch;
                                   }
                              "
                         >
                              <i class="fa fa-search"></i>
                         </button>
                         <div class="dropdown d-inline-block">
                              <button
                                   type="button"
                                   class="btn btn-sm btn-alt-secondary"
                                   id="dropdown-recent-orders-filters"
                                   data-bs-toggle="dropdown"
                                   aria-haspopup="true"
                                   aria-expanded="false"
                              >
                                   <i class="fa fa-fw fa-flask"></i>
                                   Filters
                                   <i class="fa fa-angle-down ms-1"></i>
                              </button>
                              <div
                                   class="dropdown-menu dropdown-menu-md dropdown-menu-end fs-sm"
                                   aria-labelledby="dropdown-recent-orders-filters"
                              >
                                   <a
                                        @click="filters.name.value = 'USER'"
                                        class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)"
                                   >
                                        Users
                                        <span
                                             class="badge bg-primary rounded-pill"
                                        ></span>
                                   </a>
                                   <a
                                        @click="
                                             filters.name.value = 'RESPONSIBLE'
                                        "
                                        class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)"
                                   >
                                        Responsibles
                                        <span
                                             class="badge bg-primary rounded-pill"
                                        ></span>
                                   </a>
                                   <a
                                        @click="filters.name.value = ''"
                                        class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)"
                                   >
                                        All
                                        <span
                                             class="badge bg-primary rounded-pill"
                                        ></span>
                                   </a>
                              </div>
                         </div>
                    </div>
               </template>

               <template #content>
                    <div
                         id="one-dashboard-search-orders"
                         class="block-content border-bottom"
                    >
                         <!-- Search Form -->
                         <form @submit.prevent>
                              <div class="push">
                                   <div class="input-group">
                                        <input
                                             type="text"
                                             class="form-control form-control-alt"
                                             id="one-ecom-orders-search"
                                             name="one-ecom-orders-search"
                                             placeholder="Search all orders.."
                                        />
                                        <span
                                             class="input-group-text bg-body border-0"
                                        >
                                             <i class="fa fa-search"></i>
                                        </span>
                                   </div>
                              </div>
                         </form>
                         <!-- END Search Form -->
                    </div>
                    <BaseBlock title="USERS LIST ">
                         <template #options>
                              <div class="block-options-item">
                                   <code>{{ users.length }} user</code>
                              </div>
                         </template>

                         <table class="table table-sm table-vcenter">
                              <thead>
                                   <tr>
                                        <th
                                             class="text-center"
                                             style="width: 50px"
                                        >
                                             #
                                        </th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th
                                             class="text-center"
                                             style="width: 100px"
                                        >
                                             Actions
                                        </th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr v-for="user in users" :key="user.id">
                                        <th class="text-center" scope="row">
                                             {{ user.id }}
                                        </th>
                                        <td>
                                             <a href="javascript:void(0)">{{
                                                  user.fullName
                                             }}</a>
                                        </td>
                                        <td class="d-none d-sm-table-cell">
                                             <span>
                                                  {{ user.email }}
                                             </span>
                                        </td>
                                        <td class="text-center">
                                             <div class="btn-group">
                                                  <button
                                                       type="button"
                                                       class="btn btn-sm btn-alt-secondary"
                                                       @click="
                                                            deleteUser(user.id)
                                                       "
                                                  >
                                                       <i
                                                            class="fa fa-fw fa-times"
                                                       ></i>
                                                  </button>
                                             </div>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </BaseBlock>
               </template>
          </BaseBlock>
     </div>
     <!-- END Page Content -->
</template>
