-- 赛事管理菜单项
insert into sys_menu values('2000', '赛事管理', '1', '10', 'event', 'event/index', '', '', 1, 0, 'C', '0', '0', 'event:event:list', 'education', 'admin', sysdate(), '', null, '赛事管理菜单');

-- 赛事管理按钮权限
insert into sys_menu values('2001', '赛事查询', '2000', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2002', '赛事新增', '2000', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2003', '赛事修改', '2000', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2004', '赛事删除', '2000', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('2005', '赛事导出', '2000', '5', '#', '', '', '', 1, 0, 'F', '0', '0', 'event:event:export', '#', 'admin', sysdate(), '', null, '');

-- 为管理员角色分配赛事管理权限（使用 INSERT IGNORE 避免重复插入错误）
insert ignore into sys_role_menu values ('1', '2000');
insert ignore into sys_role_menu values ('1', '2001');
insert ignore into sys_role_menu values ('1', '2002');
insert ignore into sys_role_menu values ('1', '2003');
insert ignore into sys_role_menu values ('1', '2004');
insert ignore into sys_role_menu values ('1', '2005');