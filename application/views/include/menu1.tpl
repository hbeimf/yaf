<!-- BEGIN SIDEBAR MENU -->

<ul class="page-sidebar-menu">

    <li>
        <div class="sidebar-toggler hidden-phone"></div>
    </li>

    <li>
        <!-- <form class="sidebar-search">
            <div class="input-box">
                <a href="javascript:;" class="remove"></a>
                <input type="text" placeholder="Search..." />
                <input type="button" class="submit" value=" " />
            </div>
        </form> -->
    </li>

    <li class="start {{if $current_menu['id'] == 0}}active{{/if}}">
        <a href="/">
            <i class="icon-home"></i>
            <span class="title">控制台</span>
            <span class="selected"></span>
        </a>
    </li>

    {{foreach from=$system_menu item=m}}
        {{if in_array($m['id'], $menu_right)}}
            <li class="{{if $current_menu['parent_id'] == $m['id']}}active{{/if}}">
                <a href="javascript:;">
                    <i class="icon-th"></i>
                    <span class="title">{{$m['menu_name']}}</span>
                    <span class="selected"></span>
                    <span class="arrow open"></span>
                </a>
                <ul class="sub-menu">
                    {{foreach from=$m['child'] item=mm}}
                        {{if $mm['type']=='1' && in_array($mm['id'], $menu_right)}}
                            <li class="{{if $current_menu['id'] == $mm['id']}}active{{/if}}">
                                <a href="/{{$mm['controller']}}/{{$mm['action']}}">{{$mm['menu_name']}}</a>
                            </li>
                        {{/if}}
                    {{/foreach}}
                </ul>
            </li>
        {{/if}}
    {{/foreach}}

</ul>

<!-- END SIDEBAR MENU -->
