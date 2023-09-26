<script setup></script>

<template>
  <!-- Page Content -->
  <div class="hero">
    <div class="hero-inner text-center">
      <div class="bg-body-extra-light">
        <div class="content content-full overflow-hidden">
          <div class="py-4">
            <!-- Error Header -->
            <h1 class="display-1 fw-bolder text-smooth">404</h1>
            <h2 class="h4 fw-normal text-muted mb-5">
              We are sorry but the page you are looking for was not found..
            </h2>
          </div>
        </div>
      </div>
      <div class="content content-full text-muted fs-sm fw-medium">
                    <!-- Error Footer -->
                    <p class="mb-1">Would you like to let us know about it?</p>
                    <a class="link-fx" href="javascript:void(0)"
                         >Conntact your Responsible</a
                    >
                    or <br />
                    <RouterLink
                         style="
                              font: bold 25px/1.4 Helvetica, Verdana, sans-serif; /* Adjusted line-height */
                         "
                         :to="{ name: 'examconnect-authentication' }"
                         class="btn btn-primary rounded rounded-pill link-fx m-5"
                         >Log out</RouterLink
                    >
                    <!-- END Error Footer -->
               </div>
    </div>
  </div>
  <!-- END Page Content -->
</template>
