<form name="ff" id="ff" class="form-horizontal form-row-seperated validator-popover form-ajax" action="/demo/add" method='post'>

	<div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	     <h4 class="modal-title">新增</h4>

	</div>
	<div class="modal-body">
		<div>
		    姓名: <input type="text" name="name" id="name" data-required="" 
		    class="form-control input" value="test add" />
		</div>
	</div>
	<div class="modal-footer">
	    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	    <button id="btn_add" type="button" class="btn btn-primary">保存</button>
	</div>
</form>