-- 删除已存在的赛事状态字典类型和数据，防止重复插入
delete from sys_dict_type where dict_type = 'event_status';
delete from sys_dict_data where dict_type = 'event_status';

-- 添加赛事状态字典类型
insert into sys_dict_type values(11, '赛事状态', 'event_status', '0', 'admin', sysdate(), '', null, '赛事状态列表');

-- 添加赛事状态字典数据
insert into sys_dict_data values(30, 1, '正常', '0', 'event_status', '', 'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values(31, 2, '关闭', '1', 'event_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '关闭状态');
insert into sys_dict_data values(32, 3, '已结束', '2', 'event_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '已结束状态');