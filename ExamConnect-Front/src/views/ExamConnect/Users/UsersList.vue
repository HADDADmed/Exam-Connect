<script>
    export default {
        data(){
            return{

            }
        }
    }
</script>

<template>
     <!-- Hero -->

      
      

     <!-- Page Content -->
     <div   class="content">
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
                         <div
                              class="dropdown d-inline-block"
                          >
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
                    <div class="table-responsive">
                     
                         
                    </div>
               </template>
          </BaseBlock>
     </div>
     <!-- END Page Content -->
</template>
