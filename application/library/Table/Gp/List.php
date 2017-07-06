<?php
// http://www.cnblogs.com/brudeke/p/4228848.html

// use Illuminate\Database\Capsule\Manager as DB;

// http://www.cnblogs.com/52fhy/p/5277657.html
class Table_Gp_List extends EloquentModel {
    protected $table = 'm_gp_list';



    protected $connection = 'demo';



    protected $primaryKey = 'id';

    // 默认情况下，Eloquent 在数据的表中自动地将维护 created_at 和 updated_at 字段。
    // 只需简单的添加这些 timestamp 字段到表中，Eloquent 将为您做剩余的工作。
    // 如果您不希望 Eloquent 维护这些字段，在模型中添加以下属性：public $timestamps = false;
    public $timestamps = false;

}
