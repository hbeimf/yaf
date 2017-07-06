<form name="ff" id="ff" class="form-horizontal ajax_form" action="/shares/add" method='post'>
    <!-- <input type="hidden" name="id" value="{{if isset($account['id'])}}{{$account['id']}}{{/if}}" /> -->
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增</h4>
    </div>
    <div class="modal-body">

<!-- BEGIN FORM-->
<div class="control-group">
    <label class="control-label">code</label>
    <div class="controls">
        <input value="{{if isset($data['code'])}}{{$data['code']}}{{/if}}"
            name="code" type="text" placeholder="请输入code..." class="m-wrap span6" />
        <!-- <span class="help-inline">This is inline help</span> -->
    </div>
</div>

<div class="control-group">
    <label class="control-label">名称</label>
    <div class="controls">
        <input value="{{if isset($data['name'])}}{{$data['name']}}{{/if}}"
            name="name" type="text" placeholder="请输入名称..." class="m-wrap span6" />
        <!-- <span class="help-inline">This is inline help</span> -->
    </div>
</div>

<!-- END FORM-->


    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="btn_add" type="button" class="btn btn-primary blue">保存</button>
    </div>
</form>
