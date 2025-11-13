package com.match.file.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.*;
import java.util.stream.Collectors;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.io.IoUtil;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.match.common.core.constant.CacheNames;
import com.match.common.core.exception.ServiceException;
import com.match.common.core.utils.BeanCopyUtils;
import com.match.common.core.utils.SpringUtils;
import com.match.common.core.utils.StringUtils;
import com.match.common.core.utils.file.FileUtils;
import com.match.common.oss.core.OssClient;
import com.match.common.oss.entity.UploadResult;
import com.match.common.oss.enums.AccessPolicyType;
import com.match.common.oss.factory.OssFactory;
import com.match.file.constants.OssConstants;
import com.match.file.domain.SysOssConfig;
import com.match.file.event.MultiFileUploadEvent;
import com.match.file.service.ISysOssConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import com.match.file.mapper.SysOssMapper;
import com.match.file.domain.OssLargeResult;
import com.match.file.domain.SysOss;
import com.match.file.service.ISysOssService;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * 文件上传Service业务层处理
 *
 * @author bruceXuu
 */
@Service
public class SysOssServiceImpl implements ISysOssService
{
    @Autowired
    private SysOssMapper sysOssMapper;

    @Autowired
    private ISysOssConfigService ossConfigService;

    @Value("${system.oss.url}")
    private String sysOssUrl;

    @Override
    public List<SysOss> queryPageList(SysOss bo) {
        // 构建查询条件
        SysOss sysOss = new SysOss();
        sysOss.setFileName(bo.getFileName());
        sysOss.setOriginalName(bo.getOriginalName());
        sysOss.setFileSuffix(bo.getFileSuffix());
        sysOss.setUrl(bo.getUrl());
        sysOss.setCreateBy(bo.getCreateBy());
        sysOss.setService(bo.getService());

        List<SysOss> list = sysOssMapper.selectSysOssList(sysOss);
        List<SysOss> filterResult = list.stream().map(this::matchingUrl).collect(Collectors.toList());
        return filterResult;
    }

    @Override
    public List<SysOss> listByIds(Collection<Long> ossIds) {
        List<SysOss> list = new ArrayList<>();
        for (Long id : ossIds) {
            SysOss vo = SpringUtils.getAopProxy(this).getById(id);
            if (ObjectUtil.isNotNull(vo)) {
                SysOssConfig ossConfig = ossConfigService.queryByConfigKey(vo.getService());
                String bucketName = ossConfig.getBucketName();
                if (ObjectUtil.isNotNull(vo)) {
                    String path = "/" + bucketName + "/" +  vo.getFileName();
                }
                list.add(this.matchingUrl(vo));
            }
        }
        return list;
    }

    @Override
    public String selectUrlByIds(String ossIds) {
        List<String> list = new ArrayList<>();
        String matchStr = "^[0-9].*[0-9]$";
        if (StringUtils.isEmpty(ossIds) || !ossIds.matches(matchStr)) {
            return "";
        } else {
            for (Long id : StringUtils.splitTo(ossIds, Convert::toLong)) {
                if (null != id && id.longValue() != 0) {
                    SysOss vo = SpringUtils.getAopProxy(this).getById(id);
                    if (ObjectUtil.isNotNull(vo)) {
                        list.add(this.matchingUrl(vo).getUrl());
                    }
                } else {
                    list.add("");
                }
            }
            return String.join(StringUtils.SEPARATOR_STR, list);
        }
    }

    @Cacheable(cacheNames = CacheNames.SYS_OSS, key = "#ossId")
    @Override
    public SysOss getById(Long ossId) {
        return sysOssMapper.selectSysOssById(ossId);
    }

    @Override
    public void download(Long ossId, HttpServletResponse response) throws IOException {
        SysOss sysOss = SpringUtils.getAopProxy(this).getById(ossId);
        if (ObjectUtil.isNull(sysOss)) {
            throw new ServiceException("文件数据不存在!");
        }
        FileUtils.setAttachmentResponseHeader(response, sysOss.getOriginalName());
        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE + "; charset=UTF-8");
        OssClient storage = OssFactory.instance();
        try (InputStream inputStream = storage.getObjectContent_by_name(sysOss.getFileName())) {
            int available = inputStream.available();
            IoUtil.copy(inputStream, response.getOutputStream(), available);
            response.setContentLength(available);
        } catch (Exception e) {
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public void downloadReport(Long ossId, HttpServletResponse response) throws IOException {
        SysOss sysOss = SpringUtils.getAopProxy(this).getById(ossId);
        if (ObjectUtil.isNull(sysOss)) {
            throw new ServiceException("文件数据不存在!");
        }
        FileUtils.setAttachmentResponseHeader(response, sysOss.getOriginalName());
        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE + "; charset=UTF-8");
        OssClient storage = OssFactory.instance();
        try (InputStream inputStream = storage.getObjectContent(sysOss.getUrl())) {
            int available = inputStream.available();
            IoUtil.copy(inputStream, response.getOutputStream(), available);
            response.setContentLength(available);
        } catch (Exception e) {
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public SysOss upload(File file,String contentType) {
        String originalfileName = file.getName();
        String suffix = StringUtils.substring(originalfileName, originalfileName.lastIndexOf("."), originalfileName.length());
        OssClient storage = OssFactory.instance();
        UploadResult uploadResult;
        try {
            uploadResult = storage.uploadSuffix(Files.readAllBytes(file.toPath()), suffix, contentType);
        } catch (IOException e) {
            throw new ServiceException(e.getMessage());
        }
        // 保存文件信息
        SysOss oss = new SysOss();
        String url = uploadResult.getUrl();
        oss.setUrl(uploadResult.getUrl());
        oss.setFileSuffix(suffix);
        oss.setFileName(uploadResult.getFilename());
        oss.setOriginalName(originalfileName);
        oss.setService(storage.getConfigKey());
        sysOssMapper.insertSysOss(oss);
        SysOss SysOss = new SysOss();
        BeanCopyUtils.copy(oss, SysOss);
        return this.matchingUrl(SysOss);
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 做一些业务上的校验,判断是否需要校验
        }
        // 查询要删除的记录
        List<SysOss> list = new ArrayList<>();
        for (Long id : ids) {
            SysOss sysOss = sysOssMapper.selectSysOssById(id);
            if (sysOss != null) {
                list.add(sysOss);
            }
        }

        for (SysOss sysOss : list) {
            OssClient storage = OssFactory.instance(sysOss.getService());
            // 不要传输带"http://"全路径，使用桶+路径+文件
            storage.delete(sysOss.getFileName());
        }

        // 批量删除
        Long[] idArray = ids.toArray(new Long[0]);
        return sysOssMapper.deleteSysOssByIds(idArray) > 0;
    }


    @Override
    public SysOss uploadKbFile(MultipartFile file) {
        String originalfileName = file.getOriginalFilename();
        String suffix = StringUtils.substring(originalfileName, originalfileName.lastIndexOf("."), originalfileName.length());
        OssClient storage = OssFactory.instance();
        UploadResult uploadResult;
        try {
            uploadResult = storage.uploadSuffix(file.getBytes(), suffix, file.getContentType());
        } catch (IOException e) {
            throw new ServiceException(e.getMessage());
        }
        // 保存文件信息
        SysOss oss = new SysOss();
        String url = uploadResult.getUrl();

        //重设url
        if (StringUtils.isNotBlank(sysOssUrl)) {
            url = url.replace(storage.getOriginUrl(), sysOssUrl);
        }

        oss.setUrl(url);
        oss.setFileSuffix(suffix);
        oss.setFileName(uploadResult.getFilename());
        oss.setOriginalName(originalfileName);
        oss.setService(storage.getConfigKey());
        sysOssMapper.insertSysOss(oss);
        SysOss SysOss = new SysOss();
        BeanCopyUtils.copy(oss, SysOss);
        SysOss.setUrl(uploadResult.getUrl());
        return this.matchingUrl(SysOss);
    }

    @Override
    public SysOss getPath(SysOss vo) {
        SysOssConfig ossConfig = ossConfigService.queryByConfigKey(vo.getService());
        String bucketName = ossConfig.getBucketName();
        if (ObjectUtil.isNotNull(vo)) {
            String path = "/" + bucketName + "/" +  vo.getFileName();
        }
        return vo;
    }

    /**
     * 获取上传ID
     * @param objectKey
     * @return
     * @throws Exception
     */
    @Override
    public String initiateMultipartUpload(String objectKey) throws Exception {
        OssClient storage = OssFactory.instance();
        return storage.initiateMultipartUpload(objectKey);
    }

    /**
     * 获取上传分片地址
     * @param objectKey
     * @param uploadId
     * @param partSize
     * @return
     */
    @Override
    public List<String> listPresignedUrlForPartUpload(String objectKey, String uploadId, int partSize) {
        OssClient storage = OssFactory.instance();
        System.out.println("[listPresignedUrlForPartUpload] objectKey = " + objectKey);
        return storage.listPresignedUrlForPartUpload(objectKey, uploadId, partSize);
    }

    /**
     * 完成分片上传
     * @param objectKey
     * @param uploadId
     */
    @Override
    public void completeMultipartUpload(String objectKey, String uploadId) {
        SysOss oss = getOssByUploadId(uploadId);
        Assert.notNull(oss, "文件初始化信息失败！");
        OssClient storage = OssFactory.instance();
        storage.completeMultipartUpload(oss.getFileName(), uploadId);
        oss.setUploadStatus(OssConstants.FINISH_UPLOAD);
        // 更新状态
        sysOssMapper.updateSysOss(oss);
        //发布多文件上传 监听
        MultiFileUploadEvent multiFileUploadEvent = new MultiFileUploadEvent();
        multiFileUploadEvent.setOssId(oss.getOssId());
        SpringUtils.context().publishEvent(multiFileUploadEvent);

    }


    @Override
    public OssLargeResult initUploadLargeFile(String objectKey, String md5) throws Exception {
        // 1. 校验md5是否已经存在，如果存在，则不用上传，直接返回已完成状态
        // 判断文件是否存在
        SysOss queryOss = new SysOss();
        queryOss.setMd5(md5);
        queryOss.setUploadStatus(OssConstants.FINISH_UPLOAD);
        List<SysOss> sysOssList = sysOssMapper.selectSysOssList(queryOss);
        if (!CollectionUtils.isEmpty(sysOssList)) {
            SysOss ossRes = sysOssList.get(0);
            return OssLargeResult.builder().ossId(ossRes.getOssId()).uploadStatus(OssConstants.FINISH_UPLOAD).build();
        }
        //不存在则执行
        // 获取文件名
        List<String> filePathList = StringUtils.splitList(objectKey, StrUtil.SLASH);
        String fileName = filePathList.get(filePathList.size() - 1);
        filePathList.remove(filePathList.size() -1);
        //获取文件后缀
        String suffix = StringUtils.substring(fileName, fileName.lastIndexOf("."), fileName.length());

        // 生成新文件名，避免重名
        String uuid = IdUtil.simpleUUID();
        String newFileName =  uuid + suffix;
        if (!CollectionUtils.isEmpty(filePathList)) {
            newFileName = StringUtils.join(filePathList, StrUtil.SLASH) + StrUtil.SLASH + uuid + suffix;
        }

        // 2. 如果不存在，则调用分片上传方法，获取uploadId,并生成一条文件上传记录，文件状态更改为上传中
        String uploadId = initiateMultipartUpload(newFileName);
        // 生成文件对象
        OssClient storage = OssFactory.instance();
        SysOss oss = new SysOss();
        oss.setFileSuffix(suffix);
        oss.setFileName(newFileName);
        oss.setOriginalName(fileName);
        oss.setService(storage.getConfigKey());
        oss.setUploadId(uploadId);
        oss.setMd5(md5);
        oss.setUploadStatus(OssConstants.WAIT_UPLOAD);
        oss.setUrl(storage.getUrl() + StrUtil.SLASH + newFileName);
        sysOssMapper.insertSysOss(oss);
        return OssLargeResult.builder().uploadId(uploadId).uploadStatus(OssConstants.WAIT_UPLOAD).ossId(oss.getOssId()).build();

    }
    @Override
    public OssLargeResult initUploadLargeFile(String objectKey, String md5, String savePath) throws Exception {
        // 1. 校验md5是否已经存在，如果存在，则不用上传，直接返回已完成状态
        SysOss queryOss = new SysOss();
        queryOss.setMd5(md5);
        queryOss.setUploadStatus(OssConstants.FINISH_UPLOAD);
        List<SysOss> sysOssList = sysOssMapper.selectSysOssList(queryOss);

        if (!CollectionUtils.isEmpty(sysOssList)) {
            SysOss oss = sysOssList.get(0);
            return OssLargeResult.builder().ossId(oss.getOssId()).uploadStatus(OssConstants.FINISH_UPLOAD).build();
        }

        // 获取文件名
        List<String> filePathList = StringUtils.splitList(objectKey, StrUtil.SLASH);
        String fileName = filePathList.get(filePathList.size() - 1);
        filePathList.remove(filePathList.size() -1);
        //获取文件后缀
        String suffix = StringUtils.substring(fileName, fileName.lastIndexOf("."), fileName.length());

        // 生成新文件名，避免重名
        String uuid = IdUtil.simpleUUID();
        System.out.println("[initUploadLargeFile] uuid = " + uuid);
        String newFileName =  uuid + suffix;

        if (!CollectionUtils.isEmpty(filePathList)) {
            newFileName = StringUtils.join(filePathList, StrUtil.SLASH) + StrUtil.SLASH + uuid + suffix;
        }
        StringBuilder newNewFileName = new StringBuilder();

        if (savePath.startsWith(StrUtil.SLASH)) {
            savePath = savePath.replaceFirst(StrUtil.SLASH,"");
        }
        newNewFileName.append(savePath).append(StrUtil.SLASH).append(newFileName);
        String newFileNameWithSavePath = newNewFileName.toString();

        // 2. 如果不存在，则调用分片上传方法，获取uploadId,并生成一条文件上传记录，文件状态更改为上传中
        String uploadId = initiateMultipartUpload(newFileNameWithSavePath);
        // 生成文件对象
        OssClient storage = OssFactory.instance();
        SysOss oss = new SysOss();
        oss.setFileSuffix(suffix);
        oss.setFileName(newFileNameWithSavePath);
        oss.setOriginalName(fileName);
        oss.setService(storage.getConfigKey());
        oss.setUploadId(uploadId);
        oss.setMd5(md5);
        System.out.println("[initUploadLargeFile] MD5 = " + md5);
        oss.setUploadStatus(OssConstants.WAIT_UPLOAD);
        oss.setUrl(storage.getUrl() + StrUtil.SLASH + newFileNameWithSavePath);
        sysOssMapper.insertSysOss(oss);
        return OssLargeResult.builder().uploadId(uploadId).uploadStatus(OssConstants.WAIT_UPLOAD).ossId(oss.getOssId()).build();

    }

    @Override
    public Map<String, String> listUploadLargeFileUrls(String objectKey, String uploadId, int partSize) {
        // 从数据库中获取oss对象
        SysOss oss = getOssByUploadId(uploadId);
        Assert.notNull(oss, "文件初始化信息失败！");
        List<String> urlList = listPresignedUrlForPartUpload(oss.getFileName(), uploadId, partSize);

        // 确保返回完整的预签名URL，不移除MinIO前缀
        Map<String, String> map = new HashMap<>();
        for (int i = 0; i < urlList.size(); i++) {
            String url = urlList.get(i);
            map.put("chunk_" + i, url);
        }
        return map;
    }

    private SysOss getOssByUploadId(String uploadId) {
        SysOss queryOss = new SysOss();
        queryOss.setUploadId(uploadId);
        List<SysOss> list = sysOssMapper.selectSysOssList(queryOss);
        return list.isEmpty() ? null : list.get(0);
    }



    @Override
    public SysOss upload(MultipartFile file) {
        String originalfileName = file.getOriginalFilename();
        String suffix = StringUtils.substring(originalfileName, originalfileName.lastIndexOf("."), originalfileName.length());
        OssClient storage = OssFactory.instance();
        UploadResult uploadResult;
        try {
            uploadResult = storage.uploadSuffix(file.getBytes(), suffix, file.getContentType());
        } catch (IOException e) {
            throw new ServiceException(e.getMessage());
        }
        // 保存文件信息
        SysOss oss = new SysOss();
        String url = uploadResult.getUrl();
        oss.setUrl(uploadResult.getUrl());
        oss.setFileSuffix(suffix);
        oss.setFileName(uploadResult.getFilename());
        oss.setOriginalName(originalfileName);
        oss.setService(storage.getConfigKey());
        sysOssMapper.insertSysOss(oss);
        SysOss SysOss = new SysOss();
        BeanCopyUtils.copy(oss, SysOss);
        return this.matchingUrl(SysOss);
    }

    /**
     * 匹配Url
     *
     * @param oss OSS对象
     * @return oss 匹配Url的OSS对象
     */
    private SysOss matchingUrl(SysOss oss) {
        OssClient storage = OssFactory.instance(oss.getService());
        // 仅修改桶类型为 private 的URL，临时URL时长为120s
        if (AccessPolicyType.PRIVATE == storage.getAccessPolicy()) {
            oss.setUrl(storage.getPrivateUrl(oss.getFileName(), 120));
        }
        return oss;
    }
}
