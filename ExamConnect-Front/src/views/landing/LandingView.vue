<script setup>
import { useTemplateStore } from "@/stores/template";

// Main store
const store = useTemplateStore();
</script>

<template>
  <div>
    <!-- Hero -->
    <div id="one-vue-hero" class="bg-body-extra-light backgr">
      <div class="content content-full">
        <div class="row g-0 justify-content-center text-center">
          <div class="col-md-10 pt-7 pb-9">
            <h1 class="h1 fw-black mb-3">
              Build a new test that your users will using
            </h1>
            <RouterLink
              :to="{ name: 'backend-elearning-courses' }"
              class="btn btn-primary py-2 px-3 m-1"
              v-click-ripple
            >
              <i class="fa fa-fw fa-desktop opacity-50 me-1"></i> Gérer
              l'Application
            </RouterLink>
          </div>
        </div>
      </div>
    </div>
    <!-- END Hero -->

    <!-- Hero After -->
    <div id="one-vue-hero-after" class="bg-body-light">
      <div class="content content-full">
        <div class="px-lg-8 text-center"></div>
        <div class="row py-5">
          <div class="col-6 col-md-3">
            <div class="item item-rounded my-4 text-flat bg-flat-lighter">
              <i class=""></i>
            </div>
            <h4 class="mb-2">Vue.js 3</h4>
            <p class="text-muted">
              The latest version of the progressive JavaScript framework is now
              in core.
            </p>
          </div>
          <div class="col-6 col-md-3">
            <div class="item item-rounded my-4 text-danger bg-danger-light">
              <i class=""></i>
            </div>
            <h4 class="mb-2">Laravel 10</h4>
            <p class="text-muted">
              A brand new Laravel 10 with Vite integration version is now
              included.
            </p>
          </div>
          <div class="col-6 col-md-3">
            <div class="item item-rounded my-4 text-default bg-default-lighter">
              <i class=""></i>
            </div>
            <h4 class="mb-2">OneUI 5</h4>
            <p class="text-muted">
              Based on the design of our best seller dashboard template.
            </p>
          </div>
          <div class="col-6 col-md-3">
            <div
              class="item item-rounded my-4 text-amethyst bg-amethyst-lighter"
            >
              <i class=""></i>
            </div>
            <h4 class="mb-2">Bootstrap 5</h4>
            <p class="text-muted">
              The latest and greatest framework version under the hood.
            </p>
          </div>
        </div>
      </div>
    </div>
    <!-- END Hero After -->

    <!-- Versions -->
    <div id="one-vue-versions" class="bg-body-extra-light">
      <div class="content content-full">
        <div class="py-5">
          <div class="row mb-5">
            <div class="col-md-6">
              <h2 class="h1 fw-bold mb-2">
                Comes in 2 powerful
                <span class="fw-normal">Versions</span>
              </h2>
              <p class="fs-lg fw-medium text-muted mb-0">
                Either you are building a pure API powered Vue.js app or a
                Laravel Vue.js based one, we've got you covered.
              </p>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-6">
            <BaseBlock transparent class="bg-flat-lighter">
              <div class="py-4 py-md-7 text-center">
                <i class="fa fa-desktop fa-5x text-flat"></i>
              </div>
            </BaseBlock>
          </div>
          <div class="col-6">
            <BaseBlock transparent class="bg-danger-light">
              <div class="py-4 py-md-7 text-center">
                <i class="fas fa-tablet fa-5x text-city"></i>
              </div>
            </BaseBlock>
          </div>
        </div>
      </div>
    </div>
    <!-- END Versions -->

    <!-- Call To Action -->
    <div id="one-vue-call-to-action" class="bg-body-extra-light">
      <div class="content content-full">
        <div class="py-5 py-md-8 text-center">
          <h2 class="h1 fw-black mb-2">
            Crafted with
            <i class="fa fa-fw fa-heart text-city"></i> by
            <a class="link-fx" href="https://1.envato.market/ydb">pixelcave</a>
          </h2>
          <p class="fs-lg fw-medium text-muted mb-4">
            Passionate web design and development with over 16,000 customers
            worldwide.
          </p>
          <RouterLink
            :to="{ name: 'backend-dashboard' }"
            class="btn btn-primary py-2 px-3 m-1"
            v-click-ripple
          >
            <i class="fa fa-fw fa-desktop opacity-50 me-1"></i> Live preview
          </RouterLink>
        </div>
      </div>
    </div>
    <!-- END Call To Action -->

    <!-- Footer -->
    <footer id="page-footer" class="gb">
      <div class="content py-5">
        <div class="row fs-sm fw-medium">
          <div class="col-sm-6 order-sm-2 py-1 text-center text-sm-end">
            Crafted with
            <i class="fa fa-heart text-danger"></i> by
            <a class="fw-semibold" href="https://1.envato.market/ydb"
              >pixelcave</a
            >
          </div>
          <div class="col-sm-6 order-sm-1 py-1 text-center text-sm-start">
            <a class="fw-semibold" href="https://1.envato.market/5Noyb">{{
              store.app.name + " " + store.app.version
            }}</a>
            &copy; {{ store.app.copyright }}
          </div>
        </div>
      </div>
    </footer>
    <!-- END Footer -->
  </div>
</template>

<style>
.backgr {
  background-image: url("assets/media/photos/bg11.jpg");
  background-repeat: no-repeat;
  background-size: cover;
}
.gb {
  background-image: url("assets/media/photos/bg11.jpg");
  background-repeat: no-repeat;
  background-size: cover;
  opacity: 0.75;
}
</style>
