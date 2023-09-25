<script setup>
import { useTemplateStore } from "@/stores/template";
const store = useTemplateStore();
import BaseLayout from "@/layouts/BaseLayout.vue";
const user = JSON.parse(localStorage.getItem("user"));
// Main store



if(user.isAdmin) {// Set default elements for this layout
store.setLayout({
  header: true,
  sidebar: true,
  sideOverlay: true,
  footer: true,
});
// Set various template options for this layout variation
store.headerStyle({ mode: "dark" });
store.mainContent({ mode: "narrow" });
}
else {
  store.setLayout({
  header: true,
  sidebar: false,
  sideOverlay: false,
  footer: true,
});

// Set various template options for this layout variation
store.headerStyle({ mode: "dark" });
store.mainContent({ mode: "boxed" });
}
</script>

<template>
  
  <BaseLayout v-if="user.isAdmin"/>
  <BaseLayout v-else>
    <!-- Header Content -->
    <!-- Using the available v-slot, we can override the default Header content from layouts/partials/Header.vue -->
    <template #header-content>
      <!-- Left Section -->
      <div class="d-flex align-items-center">
        <!-- Logo -->
        
      <div  class="fw-semibold fs-5 tracking-wider text-dual me-3">
        Exam
        <span class="fw-normal">Connect</span>
      </div>
        <!-- END Logo -->
        <!-- END Notifications Dropdown -->
      </div>
      <!-- END Left Section -->

      <!-- Right Section -->
      <div class="d-flex align-items-center">
        <!-- Open Search Section (visible on smaller screens) -->
       
        <!-- END Open Search Section -->
 

        <!-- User Dropdown -->
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
            <span class="d-none d-sm-inline-block ms-2">User</span>
            <i
              class="fa fa-fw fa-angle-down d-none d-sm-inline-block opacity-50 ms-1"
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
              <p class="mt-2 mb-0 fw-medium">Full Name</p>
             </div>
              
            <div role="separator" class="dropdown-divider m-0"></div>
            <div class="p-2">
               
             
            </div>
          </div>
        </div>
        <!-- END User Dropdown -->
      </div>
      <!-- END Right Section -->
    </template>
    <!-- END Header Content -->

     
  </BaseLayout>


</template>
