import request from '@/utils/request'

// 文件初始化上传
export function largeFileInit(query) {
  return request({
    url: '/file/oss/initUploadLargeFile',
    method: 'post',
    params: query
  })
}

// 获取分片上传链接
export function largerUrlInit(query) {
  return request({
    url: '/file/oss/listUploadLargeFileUrls',
    method: 'post',
    params: query
  })
}

// 分片合并
export function mergeFile(query) {
  return request({
    url:'/file/oss/completeMultipartUpload',
    method: 'post',
    params: query
  })
}
