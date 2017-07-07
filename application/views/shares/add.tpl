<form name="ff" id="ff" class="form-horizontal ajax_form" action="/shares/add" method='post'>
    <input type="hidden" name="id" value="{{if isset($row['id'])}}{{$row['id']}}{{/if}}" />
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增</h4>
    </div>
    <div class="modal-body">

<!-- BEGIN FORM-->
<div class="control-group">
    <label class="control-label">code</label>
    <div class="controls">
        <input value="{{if isset($row['code'])}}{{$row['code']}}{{/if}}"
            name="code" type="text" placeholder="请输入code..." class="m-wrap span6" />
        <!-- <span class="help-inline">This is inline help</span> -->
    </div>
</div>

<div class="control-group">
    <label class="control-label">名称</label>
    <div class="controls">
        <input value="{{if isset($row['name'])}}{{$row['name']}}{{/if}}"
            name="name" type="text" placeholder="请输入名称..." class="m-wrap span6" />
        <!-- <span class="help-inline">This is inline help</span> -->
    </div>
</div>

<div class="control-group">
    <label class="control-label">分类</label>
    <div class="controls">
        <select name="category[]" class="span6 select2" multiple placeholder="请选择分类...">
            <option value="normal" {{if isset($row['category']) and in_array('normal', $row['category'])}}selected{{/if}}>默认分类</option>
            <option value="c300" {{if isset($row['category']) and in_array('c300', $row['category'])}}selected{{/if}}>沪深300</option>
        </select>
    </div>
</div>
<!-- END FORM-->


    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="btn_add" type="button" class="btn btn-primary blue">保存</button>
    </div>
</form>
