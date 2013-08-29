//Client side validation  
jQuery(document).ready(function() {
	//validation for tasks form
  
         jQuery("#dtc").validate({
      errorElement:'span',
      rules: {
        "dtc_staff[dtc]":{
                        required: true
                  },
       "dtc_staff[user_id]":{
                  required: true
             }
      
          },
      messages: {
   "dtc_staff[dtc]":{
                required: "Please select DTC"
      },
    "dtc_staff[user_id]":{
               required: "Please select user"
           }
       }
     });


         jQuery("#mobileuser").validate({
      errorElement:'span',
      rules: {
        "mobileuser[user_id]":{
                        required: true
                  },
       "mobileuser[imei] ":{
                  required: true
             }
      
          },
      messages: {
   "mobileuser[user_id]":{
                required: "Please select user"
      },
    "mobileuser[imei]  ":{
               required: "Please select imei"
           }
       }
     });

	
	  
	
});
	