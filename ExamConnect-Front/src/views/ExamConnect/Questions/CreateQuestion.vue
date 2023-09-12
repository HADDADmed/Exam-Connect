<script>
import CKEditor from "@ckeditor/ckeditor5-vue";
import ClassicEditor from "@ckeditor/ckeditor5-build-classic";
 export default{
    data(){
        return{
            editorData: '<p>Content of the editor.</p>',
            editorConfig: {
                // The configuration of the editor.
            },
            ClassicEditor: ClassicEditor,
        }
    },
    components: {
        ckeditor: CKEditor.component,
    },
 }

</script>

<style lang="scss">

// Tiptap overrides
.ProseMirror-focused {
     outline: none;
     border: 1px solid black;
}
.ProseMirror {
     border: 1px solid black;
     padding: 20px;
     
}
</style>


<template>
     
   
  <!-- Hero -->
  <div class="bg-body-light">
        <div class="content content-full">
        <div class="py-3 text-center">
            <h1 class=" fw-bold mb-2">Create a new Qst</h1>
            <h2 class="fs-base lh-base fw-medium text-muted mb-0">
            this exam start in 15:00 and end in 16:00  15/10/2021
            </h2>
        </div>
        </div>
    </div>
  <!-- END Hero -->

     <!-- Page Content -->
     <div class="content">
          <!-- Tiptap -->
          <BaseBlock title="add New Ticket    " content-full>
               <div class="d-flex justify-content-around">
               </div>
               <div>

                   <BaseBlock title="the Question" content-full>
                   <ckeditor
                       :editor="ClassicEditor"
                       :config="editorConfig"
              
                   />
                   </BaseBlock>
               </div>
               <div class="d-flex justify-content-center mb-4">
                    <button
                         @click="console.log('newTicket')"
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
