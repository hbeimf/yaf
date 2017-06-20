<?php

// http://www.cnblogs.com/52fhy/p/5277657.html
class Table_Gp_List extends EloquentModel {
    protected $table = 'm_gp_list';

    public function __construct(array $attributes = array())
    {
        parent::__construct($attributes);

        $this->setConnection('demo');

    }
}
