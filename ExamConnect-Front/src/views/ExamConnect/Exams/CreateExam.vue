<script>

import ExamsService from '../../../services/exams.service';
  export default {
  data() {
    return {  
        exam:{
          examTitle:"",
            startTime:"",
            endTime:"",
            questions:{
                qcmQuestions:0,
                textQuestions:0,
                imageQuestions:0,
            }
        }    
    }
  },
  methods: {   
    save() {

        ExamsService.createExam(this.exam)
        console.log("created successfuly");
      console.log("to other page@!");
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
                    <div class="form-floating mb-4 col-12 animated bounceInDown">
                         <input
                              type="text"
                              class="form-control form-control-alt border border-primary"
                              id="example-text-input-floating"
                              name="example-text-input-floating"
                              v-model="exam.examTitle"
                           />
                         <label for="example-text-input-floating">Title</label>
                    </div>
                    <div class="d-flex justify-content-start" >
                                <div class= " mb-4 col-6  mb-4 ">
                                <label class="form-label mb-2" for="startTime"
                                >Start Time:</label
                                > 
                                <input
                                type="datetime-local"
                                class="form-control mb-4 col-6 animated form-control-alt border border-danger bounceInLeft"
                                id="startTime"
                                v-model="exam.startTime"
                                />
                            </div>
                            <div class="  mb-4 col-6  mb-4">
                                <label class="form-label mb-2" for="date_heure_fin"
                                >End Time :</label
                                >
                                <input
                                type="datetime-local"
                                class="form-control mb-4 col-6 form-control-alt border border-danger animated bounceInRight"
                                v-model="exam.endTime"
                                />
                            </div>
                    </div>

                    <!-- Questions count -->
                    <div class="d-flex justify-content-center">
                        <div class="badge bg-primary m-2">
                            115 QCM Questions
                        </div>
                        <div class="badge bg-primary m-2">
                            115 Text Questions
                        </div>
                        <div class="badge bg-primary m-2">
                            115 Images Questions
                        </div>
                    </div>
                    <div class="d-flex m-5 justify-content-center" >
                        <div class="d-flex ">
                           <div style="margin-right: 20px;   margin-top: 5px;">
                               <strong> QCM Questions :</strong>
                           </div>
                           <div class="mb-4 col-2 ">
                                <input 
                                type="number"
                                class="form-control form-control-alt form-control   border border-success animated bounceInRight"
                                  min="1"  
                                v-model="exam.questions.qcmQuestions"
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
                                 min="1"
                                v-model="exam.questions.textQuestions"
                                >
                           </div>
                        </div>

                        <div class="d-flex ">
                            <div style="margin-right: 20px;   margin-top: 5px;">
                            <strong>Image Questions :</strong>
                            </div>
                            <div class=" mb-4 col-2 ">
                                <input 
                                type="number"
                                class="form-control form-control-alt form-control   border border-success animated bounceInRight"
                                  min="1"
                                v-model="exam.questions.imageQuestions"
                                >
                           </div>
                        </div>
                        
                    </div>
                    <div style="margin-top: -50px;" class="d-flex justify-content-center">
                        <div class="badge bg-success m-2">
                            {{exam.questions.qcmQuestions}}  QCM Questions
                        </div>
                        <div class="badge bg-success m-2">
                            {{ exam.questions.textQuestions }}  Text Questions
                        </div>
                        <div class="badge bg-success m-2">
                            {{ exam.questions.imageQuestions }}  Images Questions
                        </div>
                    </div>
                     
               </div>
              
                    </div>

                   
               </div>
               <div style="margin-top: 30px;" class="d-flex justify-content-center mb-4">
                    <button
                            @click="save()"
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
