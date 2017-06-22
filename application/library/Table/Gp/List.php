<?php
// http://www.cnblogs.com/brudeke/p/4228848.html

// use Illuminate\Database\Capsule\Manager as DB;

// http://www.cnblogs.com/52fhy/p/5277657.html
class Table_Gp_List extends EloquentModel {
    protected $table = 'm_gp_list';



    protected $connection = 'demo';



    protected $primaryKey = 'id';

    // public function __construct()
    // {
    //     // parent::__construct($attributes);

    //     $this->setConnection('demo');

    //     // $this->getConnection()->enableQueryLog();

    //     // DB::enableQueryLog();
    // }
}
