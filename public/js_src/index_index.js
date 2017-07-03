require([
    'base'
    // 'echarts'
    // 'bootstrap-tree',
    // 'ui-tree'
],function(){
    // http://echarts.baidu.com/tutorial.html#5%20%E5%88%86%E9%92%9F%E4%B8%8A%E6%89%8B%20ECharts

    require(['echarts'], function(ec) {
        // console.log(ec);

        // console.log($('#main')[0]);
        // console.log(document.getElementById('main'));

        // 为什么 不能 用jquery 选取器？？
        var $myChart = ec.init($('#main')[0]);

        // var $myChart = ec.init(document.getElementById('main'));

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
    });

});






