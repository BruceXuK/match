import request from '@/utils/request'

// 查询可报名赛事列表
export function listAvailableEvents() {
  return request({
    url: '/event/available',
    method: 'get'
  })
}

// 查询赛事列表
export function listEvent(query) {
  return request({
    url: '/event/list',
    method: 'get',
    params: query
  })
}

// 查询赛事详细
export function getEvent(id) {
  return request({
    url: '/event/' + id,
    method: 'get'
  })
}

// 新增赛事
export function addEvent(data) {
  return request({
    url: '/event',
    method: 'post',
    data: data
  })
}

// 修改赛事
export function updateEvent(data) {
  return request({
    url: '/event',
    method: 'put',
    data: data
  })
}

// 删除赛事
export function delEvent(id) {
  return request({
    url: '/event/' + id,
    method: 'delete'
  })
}

// 用户报名赛事
export function registerEvent(eventId, data) {
  return request({
    url: '/event/user/registration/' + eventId,
    method: 'post',
    data: data
  })
}

// 检查用户是否已报名某个赛事
export function isRegistered(userId, eventId) {
  return request({
    url: '/event/isRegistered',
    method: 'get',
    params: {
      userId: userId,
      eventId: eventId
    }
  })
}

// 导出赛事
export function exportEvent(query) {
  return request({
    url: '/event/export',
    method: 'post',
    params: query
  })
}