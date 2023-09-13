<script>
  export default {
  data() {
    return {      
    }
  },
  methods: {   
    save() {
      console.log("save");
    },
  },
  components: {
   },
};
</script>

 

<template>
  <!-- Hero -->
  <div class="bg-body-light">
    <div class="content content-full">
      <div class="py-3 text-center">
        <h1 class="fw-bold mb-2">Create a new Qst</h1>
        <h2 class="fs-base lh-base fw-medium text-muted mb-0">
          You can chose between a text question or a QCM question
        </h2>
      </div>
    </div>
  </div>
  <!-- END Hero -->

  <!-- Page Content -->
  <div class="content">
    <!-- Tiptap -->

    <BaseBlock title="add New Ticket    " content-full>
               <div  >

                    <div>
                        <div >
                    <div class="form-floating mb-4 col-10 animated bounceInDown">
                         <input
                              type="text"
                              class="form-control form-control-alt border border-primary"
                              id="example-text-input-floating"
                              name="example-text-input-floating"
                              placeholder="John Doe"
                          />
                         <label for="example-text-input-floating">Title</label>
                    </div>
                    <div class="d-flex justify-content-start" >
                                <div class= " mb-4 col-5  mb-4 ">
                                <label class="form-label mb-2" for="startTime"
                                >Start Time:</label
                                >
                                <input
                                type="datetime-local"
                                class="form-control mb-4 col-4 animated form-control-alt border border-danger bounceInLeft"
                                id="startTime"
                                />
                            </div>
                            <div class="  mb-4 col-5  mb-4">
                                <label class="form-label mb-2" for="date_heure_fin"
                                >End Time :</label
                                >
                                <input
                                type="datetime-local"
                                class="form-control mb-4 col-4 form-control-alt border border-danger animated bounceInRight"
                                />
                            </div>
                    </div>

                    <!-- Questions count -->
                    <div class="d-flex">
                        <div class="badge bg-primary">
                            115 QCM Questions
                        </div>
                        <div class="badge bg-primary">
                            115 Text Questions
                        </div>
                        <div class="badge bg-primary">
                            115 Images Questions
                        </div>
                    </div>
                    <div class="d-flex">
                        <div class="d-flex ">
                           <div style="margin-right: 20px;   margin-top: 5px;">
                               <strong> QCM Questions :</strong>
                           </div>
                           <div class="mb-4 col-2 ">
                                <input 
                                type="number"
                                class="form-control form-control-alt form-control   border border-success animated bounceInRight"
                                
                                >
                           </div>
                        </div>

                        <div class="d-flex ">
                            <div style="margin-right: 20px;   margin-top: 5px;">
                                <strong>Text Questions :</strong>
                            </div>
                            <div class=" mb-4 col-2 ">
                                <input 
                                type="number"
                                class="form-control form-control-alt form-control   border border-success animated bounceInRight"
                                
                                >
                           </div>
                        </div>

                        <div class="d-flex ">
                            <div style="margin-right: 20px;   margin-top: 5px;">
                            <strong>Images Questions :</strong>
                            </div>
                            <div class=" mb-4 col-2 ">
                                <input 
                                type="number"
                                class="form-control form-control-alt form-control   border border-success animated bounceInRight"
                                
                                >
                           </div>
                        </div>
                        
                    </div>
                     
               </div>
              
                    </div>

                   
               </div>
               <div class="d-flex justify-content-center mb-4">
                    <button
                          class="btn btn-lg rounded-pill btn-success"
                    >
                         Save
                    </button>
               </div>
          </BaseBlock>
 

    <!-- END Tiptap -->
  </div>
  <!-- END Page Content -->
</template>
