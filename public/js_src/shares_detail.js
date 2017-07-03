require([
    'base'
    // 'echarts'
    // 'bootstrap-tree',
    // 'ui-tree'
],function(){
    // http://echarts.baidu.com/tutorial.html#5%20%E5%88%86%E9%92%9F%E4%B8%8A%E6%89%8B%20ECharts
    $(function () {





        var $add = $('#mod_1200');


        console.log('detail XXX');
        $add.on('shown.bs.modal', function (e) {

            console.log('fff');
            require(['echarts'], function() {
                var $myChart = echarts.init($(this).find('#main'));

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


            });
            // var $myChart = $(this).find('#main');



            // function randomData() {
            //     now = new Date(+now + oneDay);
            //     value = value + Math.random() * 21 - 10;
            //     return {
            //         name: now.toString(),
            //         value: [
            //             [now.getFullYear(), now.getMonth() + 1, now.getDate()].join('/'),
            //             Math.round(value)
            //         ]
            //     }
            // }

            // var data = [];
            // var now = +new Date(1997, 9, 3);
            // var oneDay = 24 * 3600 * 1000;
            // var value = Math.random() * 1000;
            // for (var i = 0; i < 1000; i++) {
            //     data.push(randomData());
            // }

            // option = {
            //     title: {
            //         text: '动态数据 + 时间坐标轴'
            //     },
            //     tooltip: {
            //         trigger: 'axis',
            //         formatter: function (params) {
            //             params = params[0];
            //             var date = new Date(params.name);
            //             return date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear() + ' : ' + params.value[1];
            //         },
            //         axisPointer: {
            //             animation: false
            //         }
            //     },
            //     xAxis: {
            //         type: 'time',
            //         splitLine: {
            //             show: false
            //         }
            //     },
            //     yAxis: {
            //         type: 'value',
            //         boundaryGap: [0, '100%'],
            //         splitLine: {
            //             show: false
            //         }
            //     },
            //     series: [{
            //         name: '模拟数据',
            //         type: 'line',
            //         showSymbol: false,
            //         hoverAnimation: false,
            //         data: data
            //     }]
            // };

            // $Detail.setOption(option);


        });

    });
});






