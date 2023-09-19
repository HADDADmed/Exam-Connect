<script>
export default {
  data() {
    return {};
  },
  props: {
    index: Number,
    isAdmin: Boolean,
    question: Object,
  },
};
</script>

<template>

             <!-- Creating the Question body -->
        <div  style="margin: 0px 0px 30px 30px; " class="row  ">
            <div class="col-md-11">
              <div class="form-group">
                <textarea
                  style="border: 1px solid black"
                  class="form-control form-control-alt"
                  rows="3"
                  :placeholder="isAdmin?'readonly ...':'Enter your answer here...'"
                  :readonly="isAdmin"
                 ></textarea>
              </div>
            </div>
          </div>
   
 </template>

<style>
 
</style>
