package com.match.file.service;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.match.file.domain.OssLargeResult;
import com.match.file.domain.SysOss;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * 文件上传Service接口
 *
 * @author bruceXuu
 */
public interface ISysOssService {


    List<SysOss> queryPageList(SysOss bo);

    /**
     * 根据ID集合查询文件列表
     * @param ossIds 文件ID集合
     * @return 文件列表
     */
    List<SysOss> listByIds(Collection<Long> ossIds);

    String selectUrlByIds(String ossIds);

    /**
     * 根据ID获取文件信息
     * @param ossId 文件ID
     * @return 文件信息
     */
    SysOss getById(Long ossId);

    /**
     * 上传MultipartFile类型的文件
     * @param file MultipartFile文件对象
     * @return 上传后的文件信息
     */
    SysOss upload(MultipartFile file);

    /**
     * 上传File类型的文件
     * @param file 文件对象
     * @param contentType 文件类型
     * @return 上传后的文件信息
     */
    SysOss upload(File file, String contentType);

    /**
     * 下载文件
     * @param ossId 文件ID
     * @param response 响应对象
     * @throws IOException IO异常
     */
    void download(Long ossId, HttpServletResponse response) throws IOException;

    /**
     * 下载报告文件
     * @param ossId 文件ID
     * @param response 响应对象
     * @throws IOException IO异常
     */
    void downloadReport(Long ossId, HttpServletResponse response) throws IOException;

    /**
     * 批量删除文件
     * @param ids 文件ID集合
     * @param isValid 是否验证文件存在
     * @return 删除结果
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 上传KB类型文件
     * @param file MultipartFile文件对象
     * @return 上传后的文件信息
     */
    SysOss uploadKbFile(MultipartFile file);

    /**
     * 获取文件路径信息
     * @param vo 文件信息对象
     * @return 包含路径信息的文件对象
     */
    SysOss getPath(SysOss vo);


    /**
     * 初始化分片上传
     * @param objectKey 对象键
     * @return 上传ID
     * @throws Exception 异常信息
     */
    String initiateMultipartUpload(String objectKey) throws Exception;

    /**
     * 为分片上传列出预签名URL
     * @param objectKey 对象键
     * @param uploadId 上传ID
     * @param partSize 分片大小
     * @return 预签名URL列表
     */
    List<String> listPresignedUrlForPartUpload( String objectKey, String uploadId, int partSize);

    /**
     * 完成分片上传
     * @param objectKey 对象键
     * @param uploadId 上传ID
     */
    void completeMultipartUpload(String objectKey, String uploadId);

    /**
     * 初始化大文件上传参数
     * @param objectKey 对象键
     * @param md5 文件MD5值
     * @return 大文件上传结果
     */
    OssLargeResult initUploadLargeFile(String objectKey, String md5) throws Exception;

    /**
     * 初始化大文件上传参数
     * @param objectKey 对象键
     * @param md5 文件MD5值
     * @param savePath 数据目录地址
     * @return 大文件上传结果
     */
    OssLargeResult initUploadLargeFile(String objectKey, String md5,String savePath ) throws Exception;

    /**
     * 获取分片上传链接
     * @param objectKey 对象键
     * @param uploadId 上传ID
     * @param partSize 分片大小
     * @return 分片上传链接映射
     */
    Map<String, String> listUploadLargeFileUrls(String objectKey, String uploadId, int partSize);
}
