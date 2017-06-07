<form name="ff" id="ff" class="form-horizontal " action="/system/addAccount" method='post'>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增角色</h4>
    </div>
    <div class="modal-body">

<!-- BEGIN FORM-->
<div class="control-group">

    <label class="control-label">First Name</label>

    <div class="controls">

        <input type="text" placeholder="small" class="m-wrap span6" />

        <span class="help-inline">This is inline help</span>

    </div>

</div>

<div class="control-group">

    <label class="control-label">Last Name</label>

    <div class="controls">

        <input type="text" placeholder="medium" class="m-wrap span6" />

        <span class="help-inline">This is inline help</span>

    </div>

</div>

<div class="control-group">

    <label class="control-label">Gender</label>

    <div class="controls">

        <select  class="m-wrap span6">

            <option value="">Male</option>

            <option value="">Female</option>

        </select>

        <span class="help-block">Select your gender.</span>

    </div>

</div>

<div class="control-group">

    <label class="control-label" >Category</label>

    <div class="controls">

        <div class="select2-wrapper">

            <select class="span6 select2_category">

                <option value=""></option>

                <option value="Category 1">Category 1</option>

                <option value="Category 2">Category 2</option>

                <option value="Category 3">Category 5</option>

                <option value="Category 4">Category 4</option>

            </select>

        </div>

    </div>

</div>

<div class="control-group">

    <label class="control-label">Multi-Value Select</label>

    <div class="controls">

        <div class="select2-wrapper">

            <select class="span6 select2_sample1" multiple>

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

        </div>

    </div>

</div>


<!-- <div class="control-group">

    <label class="control-label">Tags Support List</label>

    <div class="controls">

        <div class="select2-wrapper">

            <input type="hidden" class="span6 select2_sample3" value="red, blue">

        </div>

    </div>

</div> -->

<div class="control-group">

    <label class="control-label" >Membership</label>

    <div class="controls">

        <label class="radio">

        <input type="radio" name="optionsRadios2" value="option1" />

        Free

        </label>

        <label class="radio">

        <input type="radio" name="optionsRadios2" value="option2" checked />

        Professional

        </label>

    </div>

</div>



<!-- END FORM-->


    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="btn_add" type="button" class="btn btn-primary blue">保存</button>
    </div>
</form>
