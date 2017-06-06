<form name="ff" id="ff" class="form-horizontal " action="/system/addAccount" method='post'>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增</h4>
    </div>
    <div class="modal-body">
        <div class="control-group">
            <label class="control-label">Input</label>
            <div class="controls">
                <input type="text" class="span6" />
                <span class="help-inline">Some hint here</span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">Input with Tooltip</label>
            <div class="controls">
                <input type="text" class="span6 m-wrap tooltips" data-trigger="hover" data-original-title="Tooltip text goes here. Tooltip text goes here." />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">Default Dropdown</label>
            <div class="controls">
                <select class="span6 m-wrap" data-placeholder="Choose a Category" tabindex="1">
                    <option value="">Select...</option>
                    <option value="Category 1">Category 1</option>
                    <option value="Category 2">Category 2</option>
                    <option value="Category 3">Category 5</option>
                    <option value="Category 4">Category 4</option>
                </select>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="btn_add" type="button" class="btn btn-primary blue">保存</button>
    </div>
</form>
