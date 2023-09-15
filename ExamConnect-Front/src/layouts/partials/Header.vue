<script setup>
 import { useTemplateStore } from "@/stores/template";
 

// Grab example data
import notifications from "@/data/notifications";


const store = useTemplateStore();
 
 
</script>

<template>
  <!-- Header -->
  <header id="page-header">
    <slot>
      <!-- Header Content -->
      <div class="content-header">
        <slot name="content">
          <!-- Left Section -->
          <div class="d-flex align-items-center">
            <slot name="content-left">
              <!-- Toggle Sidebar -->
              <button
                type="button"
                class="btn btn-sm btn-alt-secondary me-2 d-lg-none smini-hide fs-5 tracking-wider text-center"
       
                @click="store.sidebar({ mode: 'toggle' })"
              >
                <i class="fa fa-fw fa-bars"></i>
              </button>
              <!-- END Toggle Sidebar -->

              <!-- Toggle Mini Sidebar -->
              <button
                type="button"
                style="margin-left: -60px;"
                class="btn btn-sm btn-primary me-2 d-none d-lg-inline-block"
                @click="store.sidebarMini({ mode: 'toggle' })"
              >
               <i class="fa-solid fa-xmark"></i>
              </button>
               
              <!-- END Toggle Mini Sidebar -->

            
             
              <!-- END Search Form -->
            </slot>
          </div>
          <!-- END Left Section -->

          <!-- Right Section -->
          <div class="d-flex align-items-center">
            <slot name="content-right">
              <!-- User Dropdown -->
              <div  style="color: red; font-size: 16px; font-weight: 800;" >ADMIN</div>
               <div class="dropdown d-inline-block ms-2">
                <button
                  type="button"
                  class="btn btn-sm btn-alt-secondary d-flex align-items-center"
                  id="page-header-user-dropdown"
                  data-bs-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  <img
                    class="rounded-circle"
                    src="/assets/media/avatars/avatar10.jpg"
                    alt="Header Avatar"
                    style="width: 21px"
                  />
                  <span class="d-none d-sm-inline-block ms-2">ADMIN</span>
                  <i
                    class="fa fa-fw fa-angle-down d-none d-sm-inline-block opacity-50 ms-1 mt-1"
                  ></i>
                </button>
                <div
                  class="dropdown-menu dropdown-menu-md dropdown-menu-end p-0 border-0"
                  aria-labelledby="page-header-user-dropdown"
                >
                  <div
                    class="p-3 text-center bg-body-light border-bottom rounded-top"
                  >
                    <img
                      class="img-avatar img-avatar48 img-avatar-thumb"
                      src="/assets/media/avatars/avatar10.jpg"
                      alt="Header Avatar"
                    />
                    <p class="mt-2 mb-0 fw-medium">ADMIN ADMIN</p>
     
                  </div>
                  <div role="separator" class="dropdown-divider m-0"></div>
                  <div class="p-2">
                   
              
                 
                  </div>
                </div>
              </div>
              <!-- END User Dropdown -->

              <!-- Notifications Dropdown -->
              <div class="dropdown d-inline-block ms-2">
                <button
                  type="button"
                  class="btn btn-sm btn-alt-secondary space-x-1"
                  id="page-header-notifications-dropdown"
                  data-bs-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  <i class="fa fa-fw fa-bell"></i>
                  <span v-if="notifications.length > 0" class="text-primary"
                    >•</span
                  >
                </button>
                <div
                  class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0 border-0 fs-sm"
                  aria-labelledby="page-header-notifications-dropdown"
                >
                  <div
                    class="p-2 bg-body-light border-bottom text-center rounded-top"
                  >
                    <h5 class="dropdown-header text-uppercase">
                      Notifications
                    </h5>
                  </div>
                  <ul class="nav-items mb-0">
                    <li
                      v-for="(notification, index) in notifications"
                      :key="`notification-${index}`"
                    >
                      <a
                        class="text-dark d-flex py-2"
                        :href="`${notification.href}`"
                      >
                        <div class="flex-shrink-0 me-2 ms-3">
                          <i :class="`${notification.icon}`"></i>
                        </div>
                        <div class="flex-grow-1 pe-2">
                          <div class="fw-semibold">
                            {{ notification.title }}
                          </div>
                          <span class="fw-medium text-muted">
                            {{ notification.time }}
                          </span>
                        </div>
                      </a>
                    </li>
                    <li v-if="!notifications.length" class="p-2">
                      <div
                        class="alert alert-light d-flex align-items-center space-x-2 mb-0"
                        role="alert"
                      >
                        <i class="fa fa-exclamation-triangle opacity-50"></i>
                        <p class="mb-0">No new ones!</p>
                      </div>
                    </li>
                  </ul>
                 
                </div>
              </div>
              <!-- END Notifications Dropdown -->
 
            </slot>
          </div>
          <!-- END Right Section -->
        </slot>
      </div>
      <!-- END Header Content -->

      <!-- Header Search -->
      <div
        id="page-header-search"
        class="overlay-header bg-body-extra-light"
        :class="{ show: store.settings.headerSearch }"
      >
         
      </div>
      <!-- END Header Search -->

      <!-- Header Loader -->
      <div
        id="page-header-loader"
        class="overlay-header bg-body-extra-light"
        :class="{ show: store.settings.headerLoader }"
      >
        <div class="content-header">
          <div class="w-100 text-center">
            <!-- <img style="width: 10px;" src="/assets/media/photos/toothless.png" alt="Logo">            -->

          </div>
        </div>
      </div>
      <!-- END Header Loader -->
    </slot>
  </header>
  <!-- END Header -->
</template>
