<?php

include APP_PATH.'/application/library/Smarty/libs/Smarty.class.php';

class View
{
    private $_smarty = null;
    private function __construct()
    {
        $this->_smarty = new Smarty();

        $root_dir = rtrim($_SERVER['DOCUMENT_ROOT'], '/');

        // echo $root_dir;exit;

        $this->_smarty->template_dir = $root_dir . "/../application/views/";
        //$this->_smarty->compile_dir = $root_dir . "/Application/library/Smarty/compile_dir/";

        $this->_smarty->compile_dir = $root_dir . "/../cache/compile_dir/";
        $this->_smarty->cache_dir = $root_dir . "/../application/library/Smarty/cache_dir/";
        $this->_smarty->plugins_dir = $root_dir . "/../application/viewPlugins/";

        $this->_smarty->left_delimiter = '{{';
        $this->_smarty->right_delimiter = '}}';

    }

    public function assign($key, $val)
    {
        $this->_smarty->assign($key, $val);
    }

    public function display($temp = '', $data = array())
    {

        if (!empty($data))
        {
            foreach ($data as $key => $v)
            {
                $this->_smarty->assign($key, $v);
            }
        }

        $this->_smarty->display($temp);

    }

    public function fetch($temp = '', $data = array(), $filter = false)
    {

        if (!empty($data))
        {
            foreach ($data as $key => $v)
            {
                $this->_smarty->assign($key, $v);
            }
        }

        if ($filter)
        {
            $_strip_search = array(
                "![\t ]+$|^[\t ]+!m",  // remove leading/trailing space chars
                '%[\r\n]+%m'  // remove CRs and newlines
            );
            $_strip_replace = array(
                '',
                ''
            );
            return preg_replace($_strip_search, $_strip_replace, $this->_smarty->fetch($temp));
        }
        else
        {
            return $this->_smarty->fetch($temp);
        }
    }

    private static $_instance = null;

    private function __clone()
    {
    }

    public static function getInstance()
    {
        if (self::$_instance === null)
        {
            self::$_instance = new self();
        }
        return self::$_instance;
    }

}

?>
