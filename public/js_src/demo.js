$(function () {


	console.log('demo');

	$('#add').on('shown.bs.modal', function (e) {

		console.log('vvss');

		$(this).find('#btn_add').click(function () {
			console.log('add');

			var name = $('#name').val();

			console.log(name);
			

			$.post("/demo/add/",{'name':name},function(result){
			    console.log(result);

			});


		});
	});

    $("#add-host-modal").on("hidden.bs.modal",function(){
    	$(this).off('click', '#btn_add');

        // $(document).off("click",".addCard-firm-btn");
        // $(document).off("click",".addVlan-firm-btn");
        // $(document).off("click","#addHost-firm-btn");
        // $(document).off("blur",".ip-txt");
        // $(document).off("click","#add-ip1");
    });


	
});