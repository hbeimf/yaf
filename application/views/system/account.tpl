{{include file="include/header.tpl"}}


<!-- BEGIN PAGE CONTENT-->
<div class="row-fluid">
    <div class="span12">

        <!-- BEGIN EXAMPLE TABLE PORTLET-->
            <div class="portlet-body">
                <div class="clearfix">
                    <div class="btn-group pull-right">
                        <a data-toggle="modal" data-target="#mod_1200" href="/system/addAccount/" class="btn green" >
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
                                    <option value="5" selected="selected">5</option>
                                    <option value="15">15</option>
                                    <option value="20">20</option>
                                    <!-- <option value="-1">All</option> -->
                                </select>
                                &nbsp;&nbsp;
                            </label>
                            <label>名称: <input name="name" type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>
                            <label>邮箱: <input name="email" type="text" aria-controls="sample_1" class="m-wrap medium"> &nbsp;&nbsp;</label>


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
                            <th class="hidden-480">账号名称</th>
                            <th class="hidden-480">角色</th>
                            <th class="hidden-480">状态</th>
                            <th class="hidden-480">创建时间</th>

                            <th class="hidden-480">编辑</th>


                        </tr>
                    </thead>
                    <tbody>
                        {{foreach from=$users item=r}}
                        <tr class="odd gradeX">
                            <!-- <td><input type="checkbox" class="checkboxes" value="{{$r['id']}}" /></td> -->
                            <td>{{$r['name']}}</td>
                            <td>{{role_name the_role=$r['role_id'] all_role=$roles}}</td>
                            <td>{{if $r['status']=='1'}}启用{{else}}<font color="red">禁用</font>{{/if}}</td>
                            <td>{{$r['created_at']}}</td>
                            <td>
                                <a data-toggle="modal" data-target="#mod_1200" href="/system/addAccount/id/{{$r['id']}}/"
                                    class="btn grey">
                                    <i class="fa fa-pencil"></i>编辑
                                </a>

                                <a data-link="/system/delRole/id/{{$r['id']}}/"
                                    class="btn red ajax-delete">
                                    <i class="fa fa-pencil"></i>删除
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




