require([
    // 'base'
    'echarts'
    // 'bootstrap-tree',
    // 'ui-tree'
],function(ec){
    // http://echarts.baidu.com/tutorial.html#5%20%E5%88%86%E9%92%9F%E4%B8%8A%E6%89%8B%20ECharts
    // $(function () {





        // var $add = $('#mod_1200');


        // console.log('detail XXX');

        // var $div = $(this).find('#main');

        // console.log($.trim($div.html()));

        // console.log('fff');
        // require(['echarts'], function(ec) {
            console.log(ec);
            // $div = $('#main');


            // var $myChart = ec.init($div);

            var $myChart = ec.init(document.getElementById('main'));

            // console.log($myChart.html());

            var option = {
                title: {
                    text: 'ECharts 入门示例'
                },
                tooltip: {},
                legend: {
                    data:['销量']
                },
                xAxis: {
                    data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
                },
                yAxis: {},
                series: [{
                    name: '销量',
                    type: 'bar',
                    data: [5, 20, 36, 10, 10, 20]
                }]
            };

            // 使用刚指定的配置项和数据显示图表。
            $myChart.setOption(option);

        // });


    // });
});






