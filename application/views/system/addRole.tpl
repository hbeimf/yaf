<form name="ff" id="ff" class="form-horizontal " action="/system/addAccount" method='post'>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
         <h4 class="modal-title">新增角色</h4>
    </div>
    <div class="modal-body">
       <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">

                    <div class="span12">

                        <!-- BEGIN SAMPLE FORM PORTLET-->

                        <div class="portlet box blue">

                            <div class="portlet-title">

                                <div class="caption"><i class="icon-reorder"></i>Sample Form</div>

                                <div class="tools">

                                    <a href="javascript:;" class="collapse"></a>

                                    <a href="#portlet-config" data-toggle="modal" class="config"></a>

                                    <a href="javascript:;" class="reload"></a>

                                    <a href="javascript:;" class="remove"></a>

                                </div>

                            </div>

                            <div class="portlet-body form">

                                <!-- BEGIN FORM-->

                                <form action="#" class="form-horizontal">

                                    <div class="control-group">

                                        <label class="control-label">Input</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" />

                                            <span class="help-inline">Some hint here</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Disabled Input</label>

                                        <div class="controls">

                                            <input class="span6 m-wrap" type="text" placeholder="Disabled input here..." disabled />

                                            <span class="help-inline">Some hint here</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Readonly Input</label>

                                        <div class="controls">

                                            <input class="span6 m-wrap" type="text" placeholder="Readonly input here..." disabled />

                                            <span class="help-inline">Some hint here</span>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Input with Popover</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap popovers" data-trigger="hover" data-content="Popover body goes here. Popover body goes here." data-original-title="Popover header" />

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Input with Tooltip</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap tooltips" data-trigger="hover" data-original-title="Tooltip text goes here. Tooltip text goes here." />

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Auto Complete</label>

                                        <div class="controls">

                                            <input type="text" class="span6 m-wrap" style="margin: 0 auto;" data-provide="typeahead" data-items="4" data-source="[&quot;Alabama&quot;,&quot;Alaska&quot;,&quot;Arizona&quot;,&quot;Arkansas&quot;,&quot;California&quot;,&quot;Colorado&quot;,&quot;Connecticut&quot;,&quot;Delaware&quot;,&quot;Florida&quot;,&quot;Georgia&quot;,&quot;Hawaii&quot;,&quot;Idaho&quot;,&quot;Illinois&quot;,&quot;Indiana&quot;,&quot;Iowa&quot;,&quot;Kansas&quot;,&quot;Kentucky&quot;,&quot;Louisiana&quot;,&quot;Maine&quot;,&quot;Maryland&quot;,&quot;Massachusetts&quot;,&quot;Michigan&quot;,&quot;Minnesota&quot;,&quot;Mississippi&quot;,&quot;Missouri&quot;,&quot;Montana&quot;,&quot;Nebraska&quot;,&quot;Nevada&quot;,&quot;New Hampshire&quot;,&quot;New Jersey&quot;,&quot;New Mexico&quot;,&quot;New York&quot;,&quot;North Dakota&quot;,&quot;North Carolina&quot;,&quot;Ohio&quot;,&quot;Oklahoma&quot;,&quot;Oregon&quot;,&quot;Pennsylvania&quot;,&quot;Rhode Island&quot;,&quot;South Carolina&quot;,&quot;South Dakota&quot;,&quot;Tennessee&quot;,&quot;Texas&quot;,&quot;Utah&quot;,&quot;Vermont&quot;,&quot;Virginia&quot;,&quot;Washington&quot;,&quot;West Virginia&quot;,&quot;Wisconsin&quot;,&quot;Wyoming&quot;]" />

                                            <p class="help-block">Start typing to auto complete!. E.g: California</p>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Email Address Input</label>

                                        <div class="controls">

                                            <div class="input-prepend"><span class="add-on">@</span><input class="m-wrap " type="text" placeholder="Email Address" />

                                            </div>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Email Address Input</label>

                                        <div class="controls">

                                            <div class="input-icon left">

                                                <i class="icon-envelope"></i>

                                                <input class="m-wrap " type="text" placeholder="Email Address" />

                                            </div>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Currency Input</label>

                                        <div class="controls">

                                            <div class="input-prepend input-append">

                                                <span class="add-on">$</span><input class="m-wrap " type="text" /><span class="add-on">.00</span>

                                            </div>

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

                                    <div class="control-group">

                                        <label class="control-label">Default Dropdown(Multiple)</label>

                                        <div class="controls">

                                            <select class="span6 m-wrap" multiple="multiple" data-placeholder="Choose a Category" tabindex="1">

                                                <option value="Category 1">Category 1</option>

                                                <option value="Category 2">Category 2</option>

                                                <option value="Category 3">Category 5</option>

                                                <option value="Category 4">Category 4</option>

                                                <option value="Category 3">Category 6</option>

                                                <option value="Category 4">Category 7</option>

                                                <option value="Category 3">Category 8</option>

                                                <option value="Category 4">Category 9</option>

                                            </select>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Custom Dropdown</label>

                                        <div class="controls">

                                            <select class="span6 chosen" data-placeholder="Choose a Category" tabindex="1">

                                                <option value=""></option>

                                                <option value="Category 1">Category 1</option>

                                                <option value="Category 2">Category 2</option>

                                                <option value="Category 3">Category 5</option>

                                                <option value="Category 4">Category 4</option>

                                            </select>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Grouped Custom Dropdown</label>

                                        <div class="controls">

                                            <select data-placeholder="Your Favorite Football Team" class="chosen span6" tabindex="-1" id="selS0V">

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

                                    <div class="control-group">

                                        <label class="control-label">Custom Dropdown Multiple Select</label>

                                        <div class="controls">

                                            <select data-placeholder="Your Favorite Football Teams" class="chosen span6" multiple="multiple" tabindex="6">

                                                <option value=""></option>

                                                <optgroup label="NFC EAST">

                                                    <option>Dallas Cowboys</option>

                                                    <option>New York Giants</option>

                                                    <option>Philadelphia Eagles</option>

                                                    <option>Washington Redskins</option>

                                                </optgroup>

                                                <optgroup label="NFC NORTH">

                                                    <option selected>Chicago Bears</option>

                                                    <option>Detroit Lions</option>

                                                    <option>Green Bay Packers</option>

                                                    <option>Minnesota Vikings</option>

                                                </optgroup>

                                                <optgroup label="NFC SOUTH">

                                                    <option>Atlanta Falcons</option>

                                                    <option selected>Carolina Panthers</option>

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

                                    <div class="control-group">

                                        <label class="control-label">Custom Dropdown Diselect</label>

                                        <div class="controls">

                                            <select data-placeholder="Your Favorite Type of Bear" class="chosen-with-diselect span6" tabindex="-1" id="selCSI">

                                                <option value=""></option>

                                                <option>American Black Bear</option>

                                                <option>Asiatic Black Bear</option>

                                                <option>Brown Bear</option>

                                                <option>Giant Panda</option>

                                                <option selected="">Sloth Bear</option>

                                                <option>Sun Bear</option>

                                                <option>Polar Bear</option>

                                                <option>Spectacled Bear</option>

                                            </select>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Radio Buttons</label>

                                        <div class="controls">

                                            <label class="radio">

                                            <input type="radio" name="optionsRadios1" value="option1" />

                                            Option 1

                                            </label>

                                            <label class="radio">

                                            <input type="radio" name="optionsRadios1" value="option2" checked />

                                            Option 2

                                            </label>

                                            <label class="radio">

                                            <input type="radio" name="optionsRadios1" value="option2" />

                                            Option 3

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Radio Buttons</label>

                                        <div class="controls">

                                            <label class="radio line">

                                            <input type="radio" name="optionsRadios2" value="option1" />

                                            Option 1

                                            </label>

                                            <label class="radio line">

                                            <input type="radio" name="optionsRadios2" value="option2" checked />

                                            Option 2

                                            </label>

                                            <label class="radio line">

                                            <input type="radio" name="optionsRadios2" value="option2" />

                                            Option 3

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Checkbox</label>

                                        <div class="controls">

                                            <label class="checkbox">

                                            <input type="checkbox" value="" /> Checkbox 1

                                            </label>

                                            <label class="checkbox">

                                            <input type="checkbox" value="" /> Checkbox 2

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Checkbox</label>

                                        <div class="controls">

                                            <label class="checkbox line">

                                            <input type="checkbox" value="" /> Checkbox 1

                                            </label>

                                            <label class="checkbox line">

                                            <input type="checkbox" value="" /> Checkbox 2

                                            </label>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Checkbox Group</label>

                                        <div class="controls">

                                            <div class="row-fluid">

                                                <div class="span3">

                                                    <label class="checkbox line">

                                                    <input type="checkbox" value="" /> Checkbox 1

                                                    </label>

                                                    <label class="checkbox line">

                                                    <input type="checkbox" value="" /> Checkbox 2

                                                    </label>

                                                    <label class="checkbox line">

                                                    <input type="checkbox" value="" /> Checkbox 3

                                                    </label>

                                                </div>

                                                <div class="span3">

                                                    <label class="checkbox line">

                                                    <input type="checkbox" value="" /> Checkbox 4

                                                    </label>

                                                    <label class="checkbox line">

                                                    <input type="checkbox" value="" /> Checkbox 5

                                                    </label>

                                                    <label class="checkbox line">

                                                    <input type="checkbox" value="" /> Checkbox 6

                                                    </label>

                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                    <div class="control-group">

                                        <label class="control-label">Textarea</label>

                                        <div class="controls">

                                            <textarea class="span6 m-wrap" rows="3"></textarea>

                                        </div>

                                    </div>

                                    <div class="form-actions">

                                        <button type="submit" class="btn blue">Submit</button>

                                        <button type="button" class="btn">Cancel</button>

                                    </div>

                                </form>

                                <!-- END FORM-->

                            </div>

                        </div>

                        <!-- END SAMPLE FORM PORTLET-->
                        </div>
                        </div>

    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="btn_add" type="button" class="btn btn-primary blue">保存</button>
    </div>
</form>
