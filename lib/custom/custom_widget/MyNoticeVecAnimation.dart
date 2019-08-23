import 'package:flutter/material.dart';
import 'package:flutter_for_shop/infos/json_bean/main_notice_entity.dart';
import 'package:flutter_for_shop/utils/MyToastUtils.dart';

///
/// Item的点击事件
///
typedef void OnItemClick(int position, String entity);

///公告栏动画 垂直淡入淡出
class MyNoticeVecAnimation extends StatefulWidget {
  final Duration duration;
  final List<MainNoticeNlist> messages;
  final OnItemClick itemPress;

  MyNoticeVecAnimation({
    Key key,
    this.duration = const Duration(milliseconds: 3000),
    this.messages,
    this.itemPress
  }) : super(key: key);

  @override
  _MyNoticeVecAnimationState createState() {
    // TODO: implement createState
    return _MyNoticeVecAnimationState();
  }
}

class _MyNoticeVecAnimationState extends State<MyNoticeVecAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;

  int _nextMassage = 0;

  //透明度
  Animation<double> _opacityAni1, _opacityAni2;

  //位移
  Animation<Offset> _positionAni1, _positionAni2;

  @override
  void didUpdateWidget(MyNoticeVecAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _startVerticalAni();
    //正向开启动画
    // TODO: implement build
    return SlideTransition(
      position: _positionAni2,
      child: FadeTransition(
        opacity: _opacityAni2,
        child: SlideTransition(
          position: _positionAni1,
          child: FadeTransition(
            opacity: _opacityAni1,
            child: InkWell(
                onTap: () {
                  if(widget.itemPress != null){
                    widget.itemPress(_nextMassage, widget.messages[_nextMassage].content);
                  }
                },
                child: Text(
                  widget.messages[_nextMassage].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14.0,
                      decoration: TextDecoration.none),
                )),
          ),
        ),
      ),
    );
  }

  //纵向滚动
  void _startVerticalAni() {
    //每次初始化执行之前先判断是否存在，存在就干掉，不然造成数据以及动画周期错乱
    if(_controller != null){
      _controller.dispose();
      _controller = null;
    }
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _opacityAni1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.linear)),
    );

    _opacityAni2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)),
    );

    _positionAni1 = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.linear)),
    );

    _positionAni2 = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -1.0),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)),
    );

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _nextMassage++;
            if (_nextMassage >= widget.messages.length) {
              _nextMassage = 0;
            }
          });
          _controller.reset();
          _controller.forward();
        }
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  //释放
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
