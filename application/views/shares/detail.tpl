<form name="ff" id="ff" class="form-horizontal ajax_form" action="/system/addaccount" method='post'>
    <input type="hidden" name="id" value="{{if isset($account['id'])}}{{$account['id']}}{{/if}}" />
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">详情</h4>
    </div>
    <div class="modal-body">

<!-- BEGIN FORM-->


<div id="main" style="width: 600px;height:400px;">
    main
</div>

<!-- END FORM-->


    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <!-- <button id="btn_add" type="button" class="btn btn-primary blue">保存</button> -->
    </div>
</form>
