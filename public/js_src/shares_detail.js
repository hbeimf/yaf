require([
    'base'
],function(){
    // http://echarts.baidu.com/tutorial.html#5%20%E5%88%86%E9%92%9F%E4%B8%8A%E6%89%8B%20ECharts
    $(function () {

        var $add = $('#mod_1200');

        $add.on('shown.bs.modal', function (e) {

            var $div = $(this).find('#main');

            require(['echarts'], function(ec) {
                var $myChart = ec.init($div[0]);
                // start

                var data = [
                    {name:'名称', value:['2017/01/01', 1]},
                    {name:'名称', value:['2017/01/02', 2]},
                    {name:'名称', value:['2017/01/03', 3]},
                    {name:'名称', value:['2017/01/04', 4]},
                    {name:'名称', value:['2017/01/05', 5]}
                ];

                option = {
                    title: {
                        text: '动态数据 + 时间坐标轴'
                    },
                    tooltip: {
                        trigger: 'axis',
                        formatter: function (params) {
                            params = params[0];
                            // var date = new Date(params.name);
                            // return date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear() + ' : ' + params.value[1];

                            return params.name + ':' + params.value[0] + ':' + params.value[1];
                        },
                        axisPointer: {
                            animation: false
                        }
                    },
                    xAxis: {
                        type: 'time',
                        splitLine: {
                            show: false
                        }
                    },
                    yAxis: {
                        type: 'value',
                        boundaryGap: [0, '100%'],
                        splitLine: {
                            show: false
                        }
                    },
                    series: [{
                        name: '模拟数据',
                        type: 'line',
                        showSymbol: false,
                        hoverAnimation: false,
                        data: data
                    }]
                };

                // 使用刚指定的配置项和数据显示图表。
                $myChart.setOption(option);


            });





        });

    });
});






