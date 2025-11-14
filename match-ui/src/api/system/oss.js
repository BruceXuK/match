import request from '@/utils/request'

// 查询OSS对象存储列表
export function listOss(query) {
  return request({
    url: '/file/oss/list',
    method: 'get',
    params: query
  })
}

// 查询OSS对象基于id串
export function listOssByIds(ossIds) {
  return request({
    url: '/file/oss/listByIds/' + ossIds,
    method: 'get'
  })
}

// 上传OSS对象存储
export function uploadOss(data) {
  return request({
    url: '/file/oss/upload',
    method: 'post',
    data: data
  })
}

// 下载OSS对象
export function downloadOss(ossId) {
  return request({
    url: '/file/oss/download/' + ossId,
    method: 'get'
  })
}

// 下载OSS对象-临沂产业报告
export function downloadReport(ossId) {
  return request({
    url: '/file/oss/downloadReport/' + ossId,
    method: 'get'
  })
}

// 删除OSS对象存储
export function delOss(ossIds) {
  return request({
    url: '/file/oss/' + ossIds,
    method: 'delete'
  })
}

// 修改OSS对象存储
export function updateOss(data) {
  return request({
    url: '/file/oss',
    method: 'put',
    data: data
  })
}

// 获取大文件上传初始化参数
export function initUploadLargeFile(objectKey, md5, savePath) {
  const params = new URLSearchParams();
  params.append('objectKey', objectKey);
  params.append('md5', md5);
  if (savePath !== undefined) {
    params.append('savePath', savePath);
  }
  
  return request({
    url: '/file/oss/initUploadLargeFile',
    method: 'post',
    data: params
  })
}

// 获取分片上传链接
export function listUploadLargeFileUrls(objectKey, uploadId, partSize) {
  const params = new URLSearchParams();
  params.append('objectKey', objectKey);
  params.append('uploadId', uploadId);
  params.append('partSize', partSize);
  
  return request({
    url: '/file/oss/listUploadLargeFileUrls',
    method: 'post',
    data: params
  })
}

// 分片合并
export function completeMultipartUpload(objectKey, uploadId) {
  const params = new URLSearchParams();
  params.append('objectKey', objectKey);
  params.append('uploadId', uploadId);
  
  return request({
    url: '/file/oss/completeMultipartUpload',
    method: 'post',
    data: params
  })
}

// 查询对象存储配置列表
export function listOssConfig(query) {
  return request({
    url: '/file/oss/config/list',
    method: 'get',
    params: query
  })
}

// 获取对象存储配置详细信息
export function getOssConfig(ossConfigId) {
  return request({
    url: '/file/oss/config/' + ossConfigId,
    method: 'get'
  })
}

// 新增对象存储配置
export function addOssConfig(data) {
  return request({
    url: '/file/oss/config',
    method: 'post',
    data: data
  })
}

// 修改对象存储配置
export function updateOssConfig(data) {
  return request({
    url: '/file/oss/config',
    method: 'put',
    data: data
  })
}

// 删除对象存储配置
export function delOssConfig(ossConfigIds) {
  return request({
    url: '/file/oss/config/' + ossConfigIds,
    method: 'delete'
  })
}

// 状态修改
export function changeOssConfigStatus(data) {
  return request({
    url: '/file/oss/config/changeStatus',
    method: 'put',
    data: data
  })
}