require([
    'base'
],function(){
    // http://echarts.baidu.com/tutorial.html#5%20%E5%88%86%E9%92%9F%E4%B8%8A%E6%89%8B%20ECharts

    var $add = $('#mod_1200');
    var $mod_900 = $('#mod_900');


    $mod_900.on('shown.bs.modal', function (e) {

        var $div = $(this).find('#main');
        var code = $(this).find('#code').val();

        require(['echarts'], function(ec) {
            // var code = $('#code').val();
            $.get("/shares/hj/?code="+code, function(res){
                // console.log(res);
                var $myChart = ec.init($div[0]);
                // start
                var data = $.parseJSON(res);
                console.log(data);

                var index = new Array();
                var val = new Array();

                for(var i=0; i<data.all.length; i++) {
                    if (data.all[i].yid == data.yid) {
                        index[i] = '->' + data.all[i].yid;
                    } else {
                        index[i] = data.all[i].yid;
                    }

                    val[i] = data.all[i].num;
                }

                option = {
                    title: {
                        text: code,
                        subtext: ' -> '+data.yid
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    legend: {
                        data: [ code]
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'value',
                        boundaryGap: [0, 0.01]
                    },
                    yAxis: {
                        type: 'category',
                        data: index.reverse()
                    },
                    series: [
                        {
                            name: code,
                            type: 'bar',
                            data: val.reverse()
                        }
                    ]
                };
                $myChart.setOption(option);

            });
        });
    });


    $add.on('shown.bs.modal', function (e) {

        var $div = $(this).find('#main');

        var code = $(this).find('#code').val();
        // console.log(code);

        require(['echarts'], function(ec) {
            // var code = $('#code').val();
            $.get("/shares/json/?code="+code, function(res){
                var $myChart = ec.init($div[0]);
                // start
                var reply = $.parseJSON(res);
                // console.log(reply);
                option = {
                    title: {
                        text: reply.name + ' + '+reply.code
                    },
                    tooltip: {
                        trigger: 'axis',
                        formatter: function (params) {
                            params = params[0];
                            // return params.name + ':' + params.value[0] + ':' + params.value[1];
                            return params.value[0] + ': [ ￥' + params.value[1] + ' ]';
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
                        data: reply.data
                    }]
                };

                // 使用刚指定的配置项和数据显示图表。
                $myChart.setOption(option);
            });
        });
    });


});






