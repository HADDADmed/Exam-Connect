<script>
export default {
  data() {
    return {
      os: [
        {
          id: 1,
          isQcm: 1,
        },
        {
          id: 2,
          isQcm: 0,
        },
        {
          id: 3,
          isQcm: 2,
        },
        {
          id: 4,
          isQcm: 0,
        },
        {
          id: 5,
          isQcm: 1,
        },
        {
          id: 6,
          isQcm: 0,
        },
        {
          id: 7,
          isQcm: 2,
        },
        {
          id: 8,
          isQcm: 0,
        },
        {
          id: 9,
          isQcm: 1,
        },
        {
          id: 10,
          isQcm: 0,
        },
      ],
      ns: [
        {
          id: 1,
          isTrue: 1,
        },
        {
          id: 2,
          isTrue: 0,
        },
        {
          id: 3,
          isTrue: 0,
        },
        {
          id: 4,
          isTrue: 0,
        },
        
      ],
      orderSearch: false,
    };
  },
  mounted() {
    setInterval(() => {
      this.currentTime = new Date().toLocaleTimeString();
    }, 1000);
  },
};
</script>

<template>
  <!-- Page Content -->

  <!-- Hero -->
  <div class="bg-body-light">
    <div class="content content-full">
      <div class="py-3 text-center">
        <h1 class="fw-bold mb-2">All Questions</h1>
      </div>
      
    </div>
  </div>
  <!-- END Hero -->
  <!-- Page Content -->
  <div class="content">
    <BaseBlock
      :title="`600 Questions in Total`"
      content-full
      class="animated zoomIn"
      :header-bg="true"
      transparent
    >
      <template #options>
        <div class="space-x-1 bg-light">
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
                Text Questions
                <span class="badge bg-primary rounded-pill">110</span>
              </a>
              <a
                @click="filters.name.value = 'RESPONSIBLE'"
                class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                href="javascript:void(0)"
              >
                QCM Questions
                <span class="badge bg-primary rounded-pill">115</span>
              </a>
              <a
                @click="filters.name.value = ''"
                class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                href="javascript:void(0)"
              >
                Image Questions
                <span class="badge bg-primary rounded-pill">115</span>
              </a>
              <a
                @click="filters.name.value = ''"
                class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                href="javascript:void(0)"
              >
                All
                <span class="badge bg-primary rounded-pill">600</span>
              </a>
            </div>
          </div>
        </div>
      </template>

      <template #content>
        <div
          v-if="orderSearch"
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
                <span class="input-group-text bg-body border-0">
                  <i class="fa fa-search"></i>
                </span>
              </div>
            </div>
          </form>
          <!-- END Search Form -->
        </div>
        <div class="table-responsive">
          <div class="content">
            <!-- Dummy content -->

            <div v-for="o in os" class="col-12">
              <BaseBlock v-if="o.isQcm">
                <div v-if="o.isQcm == 1">
                  <h2 class="content-heading">Question 1</h2>
                  <!-- creating the Question body -->
                  <h4>1 -what the true Sentence int this three Sentences</h4>
                  <div class="m-5">
                    <div class="m-3">
                      <input
                        type="checkbox"
                        class="form-check-input is-valid"
                        checked
                        disabled
                      />
                      <label class="qst"> a- the first Sentence is true</label>
                    </div>
                    <div class="m-3">
                      <input
                        type="checkbox"
                        class="form-check-input is-invalid"
                        disabled
                      />
                      <label class="qst">b- the seconde Sentence is true</label>
                    </div>
                    <div class="m-3">
                      <input
                        type="checkbox"
                        class="form-check-input is-invalid"
                        disabled
                      />
                      <label class="qst">c- the third Sentence is true</label>
                    </div>
                  </div>
                </div>
                <div v-else>
                  <h2 class="content-heading">Question 1</h2>
                  <!-- creating the Question body -->
                  <h4>1 - Choose the Logic image</h4>
                  <div class="d-flex flex-wrap justify-content-center">
                    <div v-for="(n, index) in ns" class="m-5" :key="index">
                      <div style="width: 200px">
                        <img
                          style="width: 100%"
                          src="/assets/media/photos/photo1@2x.jpg"
                          alt="jashdjk"
                        />
                      </div>
                      <div class="text-center">
                        <input
                          type="checkbox"
                          class="form-check-input "
                          :class="n.isTrue ? 'is-valid' : 'is-invalid'"
                          :checked="n.isTrue"
                          disabled
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </BaseBlock>

              <BaseBlock v-else>
                <h2 class="content-heading">Question 8</h2>
                <!-- creating the Question body -->
                <h4>1 -Answer this question by writing a the Answear ?</h4>
              </BaseBlock>
            </div>
            <!-- END Dummy content -->
          </div>
        </div>
      </template>
    </BaseBlock>
  </div>
  <!-- END Page Content -->

  <!-- END Page Content -->
</template>

<style>
.form-check-input {
  width: 25px;
  height: 25px;
  margin-right: 20px;
}
.qst {
  font-size: 16px;
  font-weight: 600;
  margin-top: 5px;
}
</style>
