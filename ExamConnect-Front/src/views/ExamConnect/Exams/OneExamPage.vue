<script>

export default{
    data(){
        return{
            os : [
                {
                    id:1,
                    isQcm:true,
                    isImage:false,
                }
                ,
                {
                    id:2,
                    isQcm:false,
                    isImage:false,
                }
                ,
                {
                    id:3,
                    isQcm:true,
                    isImage:true,
                }
                ,
                {
                    id:4,
                    isQcm:false,
                }
                ,
                {
                    id:5,
                    isQcm:true,
                    isImage:false,
                }
                ,
                {
                    id:6,
                    isQcm:false,
                }
                ,
                {
                    id:7,
                    isQcm:true,
                    isImage:true,
                }
                ,
                {
                    id:8,
                    isQcm:false,
                }
                ,
                {
                    id:9,
                    isQcm:true,
                }
                ,
                {
                    id:10,
                    isQcm:false,
                }

               ],
                hover:false,
                currentTime: new Date().toLocaleTimeString(),
                exam_id: this.$route.query.exam_id,
        }
    },
    mounted() {
        setInterval(() => {
          this.currentTime = new Date().toLocaleTimeString();
        }, 1000);
}

}


</script>

<template>
    
  <!-- Page Content -->
    <div class=" m-2 timer" 
        @mouseover="hover = true"
        @mouseleave="hover = false"
    >
    <span v-if="!hover" class="timerTitle">Timer </span>
    <span v-else class="timerValue">{{currentTime}}</span>
    </div>
    <!-- Hero -->
    <div class="bg-body-light">
        <div class="content content-full">
        <div class="py-3 text-center">
            <h1 class=" fw-bold mb-2">ExamExam TitleTitle</h1>
            <h2 class="fs-base lh-base fw-medium text-muted mb-0">
            this exam start in 15:00 and end in 16:00  15/10/2021
            </h2>
        </div>
        </div>
    </div>
  <!-- END Hero -->
  <div class="content">
    <!-- Dummy content -->
      <div v-for="o in os" class="col-12">
        <BaseBlock v-if="o.isQcm">


            <div v-if="!o.isImage"> 
                        <h2 class="content-heading">Question 1</h2>
                    <!-- creating the Question body -->
                    <h4>1 -what the true Sentence int this three Sentences</h4>
                    <div class="m-5">
                        <div class="m-3">
                            <input type="checkbox">
                            <label> the first Sentence is true</label>
                        </div>
                        <div class="m-3">
                                <input type="checkbox">
                                <label> the seconde Sentence is true</label>
                        </div>
                        <div class="m-3">
                                <input type="checkbox">
                                <label> the third Sentence is true</label>
                        </div>
                    </div>
            </div>

            <div v-else>
                        <h2 class="content-heading">Question 1</h2>
                    <!-- creating the Question body -->
                    <h4>1 -chose the Logic image </h4>
                    <div class="d-flex">
                            <div  class="m-5">
                                    <div style="width: 300px;">
                                        <img style="width: 100%;" src="/assets/media/photos/photo1@2x.jpg" alt="jashdjk">
                                    </div>
                                    <input type="checkbox">
                            </div>
                            <div  class="m-5">
                                    <div style="width: 300px;">
                                        <img style="width: 100%;" src="/assets/media/photos/photo1@2x.jpg" alt="jashdjk">
                                    </div>
                                    <input type="checkbox">
                            </div>
                            <div  class="m-5">
                                    <div style="width: 300px;">
                                        <img style="width: 100%;" src="/assets/media/photos/photo1@2x.jpg" alt="jashdjk">
                                    </div>
                                    <input type="checkbox">
                            </div>
                    </div>
            </div>


        </BaseBlock>

        <BaseBlock v-else>
            <h2 class="content-heading">Question 8</h2>
            <!-- creating the Question body -->
            <h4>1 -Answer this question by writing a the Answear</h4>
            <div class="m-5">
                <textarea name="" id="" cols="100" rows="4">
                    
                </textarea>
            </div>
              
        </BaseBlock>
      </div>
    <!-- END Dummy content -->
     
       </div>

  <!-- END Page Content -->
</template>


<style>
.timer {
    width: 80px;
    background-color: #f5f5f5;
    border: red 3px solid;
    border-radius: 10px;
    padding: 10px;
    font-size: 16px;
    font-weight: bold;
    color: #000;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    position: fixed;
    top: 255px;
    transition: all 0.3s ease; /* Add a transition for a smooth effect */
}

</style>