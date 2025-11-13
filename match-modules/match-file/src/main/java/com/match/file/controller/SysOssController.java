package com.match.file.controller;


import cn.hutool.core.util.ObjectUtil;
import com.match.common.core.domain.R;
import com.match.common.core.enums.FileType;
import com.match.common.core.exception.ServiceException;
import com.match.common.core.web.controller.BaseController;
import com.match.common.core.web.domain.AjaxResult;
import com.match.common.core.web.page.TableDataInfo;
import com.match.common.log.annotation.Log;
import com.match.common.log.enums.BusinessType;
import com.match.common.security.annotation.RequiresPermissions;
import com.match.file.domain.OssLargeResult;
import com.match.file.domain.SysOss;
import com.match.file.service.ISysOssService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotEmpty;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 文件上传 控制层
 *
 * @author Lion Li
 */

@RestController
@RequestMapping("/file/oss")
public class SysOssController extends BaseController {

    @Autowired
    private ISysOssService iSysOssService;

    private  final FileType[] FILE_TYPE_LIST = new FileType[]{FileType.DOCX, FileType.DOC, FileType.XLSX, FileType.XLS, FileType.PDF,  FileType.JPG, FileType.JPEG, FileType.PNG, FileType.GIF, FileType.TIFF, FileType.XML, FileType.HTML, FileType.JAR};

    /**
     * 查询OSS对象存储列表
     */
    @RequiresPermissions("system:oss:list")
    @GetMapping("/list")
    public TableDataInfo list(SysOss bo) {
        startPage();
        List<SysOss> list = iSysOssService.queryPageList(bo);
        return getDataTable(list);
    }

    /**
     * 查询OSS对象基于id串
     *
     * @param ossIds OSS对象ID串
     */
    @RequiresPermissions("system:oss:list")
    @GetMapping("/listByIds/{ossIds}")
    public R<List<SysOss>> listByIds(@NotEmpty(message = "主键不能为空")
                                       @PathVariable Long[] ossIds) {
        List<SysOss> list = iSysOssService.listByIds(Arrays.asList(ossIds));
        return R.ok(list);
    }

    /**
     * 上传OSS对象存储
     *
     * @param file 文件
     */
    @RequiresPermissions("system:oss:upload")
    @Log(title = "OSS对象存储", businessType = BusinessType.INSERT)
    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<Map<String, String>> upload(@RequestPart("file") MultipartFile file) {
        if (ObjectUtil.isNull(file)) {
            throw new ServiceException("上传文件不能为空");
        }
        SysOss oss = iSysOssService.upload(file);
        oss = iSysOssService.getPath(oss);
        Map<String, String> map = new HashMap<>(2);
        map.put("url", oss.getUrl());
        map.put("fileName", oss.getOriginalName());
        map.put("ossId", oss.getOssId().toString());
        return R.ok(map);
    }

    /**
     * 下载OSS对象
     *
     * @param ossId OSS对象ID
     */
    @RequiresPermissions("system:oss:download")
    @GetMapping("/download/{ossId}")
    public void download(@PathVariable Long ossId, HttpServletResponse response) throws IOException {
        iSysOssService.download(ossId,response);
    }

    /**
     * 下载OSS对象-临沂产业报告
     *
     * @param ossId OSS对象ID
     */
    @RequiresPermissions("system:oss:download")
    @GetMapping("/downloadReport/{ossId}")
    public void downloadReport(@PathVariable Long ossId, HttpServletResponse response) throws IOException {
        iSysOssService.downloadReport(ossId,response);
    }

    /**
     * 删除OSS对象存储
     *
     * @param ossIds OSS对象ID串
     */
    @RequiresPermissions("system:oss:remove")
    @Log(title = "OSS对象存储", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ossIds}")
    public AjaxResult remove(@NotEmpty(message = "主键不能为空")
                          @PathVariable Long[] ossIds) {
        return toAjax(iSysOssService.deleteWithValidByIds(Arrays.asList(ossIds), true));
    }

    /**
     * 获取大文件上传初始化参数
     * @param objectKey
     * @param md5
     * @param  savePath
     * @return
     */
    @PostMapping("/initUploadLargeFile")
    public R<OssLargeResult> initUploadLargeFile(@RequestParam String objectKey, @RequestParam String md5,
                                                 @RequestParam(required = false) String savePath) throws Exception {
        if (StringUtils.isEmpty(savePath)){
            return R.ok(iSysOssService.initUploadLargeFile(objectKey, md5));
        }else {
            return R.ok(iSysOssService.initUploadLargeFile(objectKey, md5, savePath));
        }
    }

    /**
     * 获取分片上传链接
     * @param objectKey
     * @param uploadId
     * @param partSize
     * @return
     */
    @PostMapping("/listUploadLargeFileUrls")
    public R<Map<String, String>> listUploadLargeFileUrls(@RequestParam String objectKey, @RequestParam String uploadId, @RequestParam int partSize) {
        return R.ok(iSysOssService.listUploadLargeFileUrls(objectKey, uploadId, partSize));
    }

    /**
     * 分片合并
     * @param objectKey
     * @param uploadId
     * @return
     */
    @PostMapping("/completeMultipartUpload")
    public R<Void> completeMultipartUpload(@RequestParam String objectKey, @RequestParam String uploadId) {
        iSysOssService.completeMultipartUpload(objectKey, uploadId);
        return R.ok();
    }

}