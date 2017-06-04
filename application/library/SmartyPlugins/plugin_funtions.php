<?php
// function smarty_function_page($params, $template) {
// 	$father_res_id = isset($params['id']) ? $params['id'] : '';
// 	$the_right = isset($params['the_right']) ? $params['the_right'] : '';
// 	$superadmin = isset($params['superadmin']) ? $params['superadmin'] : 'superadmin';

// 	return 'page fun';
// }

// 分页函数
function page($params) {
	$current_page = isset($params['current_page']) ? $params['current_page'] : 1;
	$total_page = isset($params['total_page']) ? $params['total_page'] : 1;
	$current_url = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];

	$pure_urls = explode('?', $current_url);
	$pure_url = $pure_urls[0];

	$urls = parse_url($current_url);

	$querys = [];
	if (isset($urls['query'])) {
		$p = explode('&', $urls['query']);
		foreach ($p as $val) {
			$kv = explode('=', $val);
			$querys[$kv[0]] = isset($kv[1]) ? $kv[1] : '';
		}
	}

	$html = '<ul>';

	if ($current_page <= 1) {
		$html .= '	<li class="prev disabled"><a href="javascript:;">← <span class="hidden-480">上一页</span></a></li>';
	} else {
		$querys['page'] = $current_page - 1;
		$url = $pure_url . '?' . http_build_query($querys);
		$html .= '	<li class="prev"><a href="' . $url . '">← <span class="hidden-480">上一页</span></a></li>';
	}

	// $html .= '	<li class="active"><a href="#">1</a></li>';
	// $html .= '	<li><a href="#">2</a></li>';
	// $html .= '	<li><a href="#">3</a></li>';
	$show_size = 10;

	$for_num = ($total_page <= $show_size) ? $total_page : 10;
	$start_add = 0;

	$start = 1;
	if ($current_page <= ($show_size / 2)) {
		$start = 1;
	} elseif ($current_page >= ($total_page - ($show_size / 2))) {
		$start = $total_page - $show_size + 1;
	}

	for ($i = 0; $i < $for_num; $i++) {
		$the_page = $i + $start;
		$querys['page'] = $the_page;
		$url = $pure_url . '?' . http_build_query($querys);

		if ($the_page == $current_page) {
			$html .= '	<li class="active"><a href="' . $url . '">' . $the_page . '</a></li>';
		} else {
			$html .= '	<li><a href="' . $url . '">' . $the_page . '</a></li>';
		}
	}

	if ($current_page >= $total_page) {
		$html .= '	<li class="next disabled"><a href="javascript:;"><span class="hidden-480">下一页</span> → </a></li>';
	} else {
		$querys['page'] = $current_page + 1;
		$url = $pure_url . '?' . http_build_query($querys);
		$html .= '	<li class="next"><a href="' . $url . '"><span class="hidden-480">下一页</span> → </a></li>';
	}

	$html .= '</ul>';

	return $html;
}
?>