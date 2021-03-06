<form name="ff" id="ff" class="form-horizontal ajax_form" action="/system/addMenu" method='post'>
    <input value="{{if isset($menu['id'])}}{{$menu['id']}}{{/if}}"
        name="id" type="hidden" />

    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增导航</h4>
    </div>
    <div class="modal-body">

        <!-- BEGIN FORM-->
        <div class="control-group">
            <label class="control-label">导航名称</label>
            <div class="controls">
                <input value="{{if isset($menu['menu_name'])}}{{$menu['menu_name']}}{{/if}}"
                name="menu_name" type="text" placeholder="请输入导航名称..." class="m-wrap span4" />
                <!-- <span class="help-inline">This is inline help</span> -->
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">上级导航</label>
            <div class="controls">
                <select name="parent_id" class="span6 select2" placeholder="请选择导航...">
                    <option value="0">顶级导航</option>
                    {{foreach from=$system_menu item=m}}
                        <option {{if isset($menu['parent_id']) && $menu['parent_id']==$m['id']}}selected{{/if}}
                        value="{{$m['id']}}">{{$m['menu_name']}} </option>
                    {{/foreach}}
                </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">Controller</label>
            <div class="controls">
                <input value="{{if isset($menu['controller'])}}{{$menu['controller']}}{{/if}}"
                name="controller" type="text"
                placeholder="请输入 Controller..." class="m-wrap span6" />
                <span class="help-inline"></span>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">Action</label>
            <div class="controls">
                <input value="{{if isset($menu['action'])}}{{$menu['action']}}{{/if}}"
                    name="actions" type="text"
                    placeholder="请输入 Action..." class="m-wrap span6" />
                <span class="help-inline"></span>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" >是否启用</label>
            <div class="controls">
                <label class="radio">
                <input {{if isset($menu['status']) && $menu['status']=='1'}}checked{{/if}}
                    type="radio" name="status" value="1" />
                启用
                </label>
                <label class="radio">
                <input {{if isset($menu['status']) && $menu['status']=='2'}}checked{{/if}}
                    {{if not isset($menu['status'])}}checked{{/if}}
                type="radio" name="status" value="2" />
                禁用
                </label>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" >类别</label>
            <div class="controls">
                <label class="radio">
                <input {{if isset($menu['type']) && $menu['type']=='1'}}checked{{/if}}
                    type="radio" name="type" value="1" />
                导航
                </label>
                <label class="radio">
                <input {{if isset($menu['type']) && $menu['type']=='2'}}checked{{/if}} {{if not isset($menu['type'])}}checked{{/if}}
                    type="radio" name="type" value="2" />
                功能
                </label>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">备注</label>
            <div class="controls">
                <input
                    value="{{if isset($menu['note'])}}{{$menu['note']}}{{/if}}"
                 name="note" type="text" placeholder="请输入备注..." class="m-wrap span6" />
                <span class="help-inline"></span>
            </div>

        </div>

        <!-- END FORM-->


    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="btn_add" type="button" class="btn btn-primary blue">保存</button>
    </div>
</form>
