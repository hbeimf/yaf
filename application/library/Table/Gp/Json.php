<?php
class Table_Gp_Json extends EloquentModel {
    protected $table = 'parse_json';

    protected $connection = 'demo';

    protected $primaryKey = 'id';

    // 默认情况下，Eloquent 在数据的表中自动地将维护 created_at 和 updated_at 字段。
    // 只需简单的添加这些 timestamp 字段到表中，Eloquent 将为您做剩余的工作。
    // 如果您不希望 Eloquent 维护这些字段，在模型中添加以下属性：public $timestamps = false;
    public $timestamps = false;

}
