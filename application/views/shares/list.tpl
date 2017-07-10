{{include file="include/header.tpl"}}


<!-- BEGIN PAGE CONTENT-->
<div class="row-fluid">
    <div class="span12">

        <!-- BEGIN EXAMPLE TABLE PORTLET-->
            <div class="portlet-body">
                <div class="clearfix">
                    <div class="btn-group pull-right">
                        <!-- <a data-toggle="modal" data-target="#mod_1200" href="/system/addAccount/" class="btn green" > -->
                        <a data-toggle="modal" data-target="#mod_1200" href="/shares/add/" class="btn green" >

                        新增 <i class="icon-plus"></i>
                        </a>
                    </div>
                </div>
                <!-- 搜索开始 -->
                <div class="row-fluid">
                    <form>
                        <div id="sample_1_length" class="dataTables_length">
                            <label>每页显示:
                                <select size="1" name="page_size" aria-controls="sample_1" class="m-wrap small">
                                    <option value="5" {{if $params['page_size'] == 5}}selected="selected"{{/if}}>5</option>
                                    <option value="10" {{if $params['page_size'] == 10}}selected="selected"{{/if}}>10</option>
                                    <option value="15" {{if $params['page_size'] == 15}}selected="selected"{{/if}}>15</option>

                                    <option value="20" {{if $params['page_size'] == 20}}selected="selected"{{/if}}>20</option>
                                    <!-- <option value="-1">All</option> -->
                                </select>
                                &nbsp;&nbsp;
                            </label>
                            <label>名称: <input value="{{$params['name']}}" name="name" type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
                            <label><button id="btn_search" class="btn blue">查找 <!-- <i class="icon-plus"> --></i></button></label>
                        </div>
                    </form>
                </div>
                <!-- 搜索结束  -->

                <!-- 表开始 -->
                <table class="table table-striped table-bordered table-hover" id="sample_1">
                    <thead>
                        <tr>
                            <!-- <th style="width:8px;"><input type="checkbox" class="group-checkable" data-set="#sample_1 .checkboxes" /></th> -->
                            <th class="hidden-480">id</th>
                            <th class="hidden-480">code</th>
                            <th class="hidden-480">名称</th>
                            <th class="hidden-480">更新时间</th>
                            <th class="hidden-480">价格</th>
                            <th class="hidden-480">YID</th>
                            <th class="hidden-480">年数</th>

                            <th class="hidden-480">明细</th>
                        </tr>
                    </thead>
                    <tbody>
                        {{foreach from=$users item=r}}
                        <tr class="odd gradeX">
                            <!-- <td><input type="checkbox" class="checkboxes" value="{{$r['id']}}" /></td> -->
                            <td>{{$r['id']}}</td>
                            <td>{{$r['code']}}</td>
                            <td>{{$r['name']}}</td>
                            <td>{{date("Y-m-d", $r['last_time'])}}</td>
                            <td>{{$r['last_price']}}</td>
                            <td>{{$r['last_yid']}}</td>
                            <td>{{$r['all_years']}}</td>
                            <td>

                            <a data-toggle="modal" data-target="#mod_1200" href="/shares/add/?code={{$r['code']}}" class="btn green" >
                                修改
                                </a>

                            <a data-toggle="modal" data-target="#mod_1200" href="/shares/detail/?code={{$r['code']}}" class="btn default" >
                                详情
                                </a>

                            <a data-toggle="modal" data-target="#mod_900" href="/shares/heap/?code={{$r['code']}}" class="btn default" >
                                堆积图
                                </a>

                            </td>

                        </tr>
                        {{/foreach}}

                    </tbody>
                </table>

                <!-- 分页开始 -->
                {{include file="include/page_list.tpl"}}
                <!-- 分页结束 -->
                <!-- 表结束  -->

            </div>
        <!-- END EXAMPLE TABLE PORTLET-->
    </div>

</div>
<!-- END PAGE CONTENT-->

{{include file="include/footer.tpl"}}




