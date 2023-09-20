<script setup></script>

<template>
  <!-- Hero -->
  <BasePageHeading title="Authentication" subtitle="All pages in one spot!">
    <template #extra>
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb breadcrumb-alt">
          <li class="breadcrumb-item">
            <a class="link-fx" href="javascript:void(0)">Authentication</a>
          </li>
          <li class="breadcrumb-item" aria-current="page">All</li>
        </ol>
      </nav>
    </template>
  </BasePageHeading>
  <!-- END Hero -->

  <!-- Page Content -->
  <div class="content">
    <!-- Original -->
    <h2 class="content-heading">Original</h2>
    <div class="row">
      <div class="col-md-6 col-xxl-3">
        <!-- Sign In -->
       
        <!-- END Sign In -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Sign Up -->
        
        <!-- END Sign Up -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Lock Screen -->
        <RouterLink
          :to="{ name: 'auth-lock' }"
          custom
          v-slot="{ href, navigate }"
        >
          <BaseBlock tag="a" link-shadow :href="href" @click="navigate">
            <div class="py-5 text-center">
              <div class="mb-3">
                <i class="fa fa-lock fa-2x text-city"></i>
              </div>
              <p class="fw-medium text-muted">Lock Screen</p>
            </div>
          </BaseBlock>
        </RouterLink>
        <!-- END Lock Screen -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Password Reminder -->
        
        <!-- END Password Reminder -->
      </div>
    </div>
    <!-- END Original -->

    <!-- Alternative -->
    <h2 class="content-heading">Alternative</h2>
    <div class="row">
      <div class="col-md-6 col-xxl-3">
        <!-- Sign In -->
      
        <!-- END Sign In -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Sign Up -->
        
        <!-- END Sign Up -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Lock Screen -->
        
        <!-- END Lock Screen -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Password Reminder -->
       
        <!-- END Password Reminder -->
      </div>
    </div>
    <!-- END Alternative -->

    <!-- Full Page -->
    <h2 class="content-heading">Full Page</h2>
    <div class="row">
      <div class="col-md-6 col-xxl-3">
        <!-- Sign In -->
      
        <!-- END Sign In -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Sign Up -->
         
        <!-- END Sign Up -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Lock Screen -->
        
        <!-- END Lock Screen -->
      </div>
      <div class="col-md-6 col-xxl-3">
        <!-- Password Reminder -->
        
        <!-- END Password Reminder -->
      </div>
    </div>
    <!-- END Full Page -->
  </div>
  <!-- END Page Content -->
</template>
