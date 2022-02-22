({
   init: function (cmp, event, helper) {
        cmp.set('v.mycolumns', [
                {label: '주소', fieldName: 'results.juso.roadAddr', type: 'text'},
                {label: '우편번호', fieldName: 'results.juso.zipNo', type: 'text'},
                
            ]);
        alert();
           
        helper.getData(cmp);
    }
})