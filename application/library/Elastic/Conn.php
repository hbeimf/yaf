<?php


class Elastic_Conn {
    private $_es = null;
    private function __construct() {
        $this->_es =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();
    }

    public function get_es() {
        return $this->_es;
    }

    private static $_instance = null;

    private function __clone() {
    }

    public static function getInstance() {
        if (self::$_instance === null) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

}

?>
