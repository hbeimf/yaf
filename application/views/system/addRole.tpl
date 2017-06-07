<form name="ff" id="ff" class="form-horizontal " action="/system/addAccount" method='post'>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增角色</h4>
    </div>
    <div class="modal-body">

<!-- BEGIN FORM-->
<div class="control-group">

    <label class="control-label">角色名称</label>

    <div class="controls">

        <input type="text" placeholder="small" class="m-wrap span6" />

        <span class="help-inline">This is inline help</span>

    </div>

</div>

<div class="control-group">
    <label class="control-label">访问导航权限</label>
    <div class="controls">
        <!-- <div class="select2-wrapper"> -->
            <select class="span6 m-wrap select2_sample1 select2" multiple>
                <option value=""></option>
                <optgroup label="NFC EAST">
                    <option>Dallas Cowboys</option>
                    <option>New York Giants</option>
                    <option>Philadelphia Eagles</option>
                    <option>Washington Redskins</option>
                </optgroup>
                <optgroup label="NFC NORTH">
                    <option>Chicago Bears</option>
                    <option>Detroit Lions</option>
                    <option>Green Bay Packers</option>
                    <option>Minnesota Vikings</option>
                </optgroup>
                <optgroup label="NFC SOUTH">
                    <option>Atlanta Falcons</option>
                    <option>Carolina Panthers</option>
                    <option>New Orleans Saints</option>
                    <option>Tampa Bay Buccaneers</option>
                </optgroup>
                <optgroup label="NFC WEST">
                    <option>Arizona Cardinals</option>
                    <option>St. Louis Rams</option>
                    <option>San Francisco 49ers</option>
                    <option>Seattle Seahawks</option>
                </optgroup>
                <optgroup label="AFC EAST">
                    <option>Buffalo Bills</option>
                    <option>Miami Dolphins</option>
                    <option>New England Patriots</option>
                    <option>New York Jets</option>
                </optgroup>
                <optgroup label="AFC NORTH">
                    <option>Baltimore Ravens</option>
                    <option>Cincinnati Bengals</option>
                    <option>Cleveland Browns</option>
                    <option>Pittsburgh Steelers</option>
                </optgroup>
                <optgroup label="AFC SOUTH">
                    <option>Houston Texans</option>
                    <option>Indianapolis Colts</option>
                    <option>Jacksonville Jaguars</option>
                    <option>Tennessee Titans</option>
                </optgroup>
                <optgroup label="AFC WEST">
                    <option>Denver Broncos</option>
                    <option>Kansas City Chiefs</option>
                    <option>Oakland Raiders</option>
                    <option>San Diego Chargers</option>
                </optgroup>
            </select>
        <!-- </div> -->
    </div>
</div>


<div class="control-group">
    <label class="control-label" >是否启用</label>
    <div class="controls">
        <label class="radio">
        <input type="radio" name="status" value="1" />
        启用
        </label>
        <label class="radio">
        <input type="radio" name="status" value="2" checked />
        禁用
        </label>
    </div>
</div>

<div class="control-group">
    <label class="control-label">备注</label>
    <div class="controls">
        <input name="note" type="text" placeholder="note" class="m-wrap span6" />
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
