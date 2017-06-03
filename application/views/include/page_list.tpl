<!-- 分页 -->
<div class="row-fluid">
	<div class="span6">
		<div class="dataTables_info" id="sample_1_info">
			共{{$count}}条记录， 第{{$page}}页 共{{$totalPage}}页 
		</div>
	</div>
	<div class="span6">
		<div class="dataTables_paginate paging_bootstrap pagination">
			{{page current_page=$page total_page=$totalPage}}
		</div>
	</div>
</div>